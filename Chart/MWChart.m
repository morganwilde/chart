//
//  MWChart.m
//  Chart
//
//  Created by Morgan Wilde on 19/04/2015.
//  Copyright (c) 2015 Morgan Wilde. All rights reserved.
//

#import "MWChart.h"
#import "MWChartBar.h"
#import "MWChartGoalLine.h"
#import "MWDayLabel.h"

@interface MWChart ()

@property (nonatomic) CGFloat positivePart;
@property (nonatomic) CGFloat negativePart;
@property (nonatomic) NSInteger positiveAbsoluteTotal;
@property (nonatomic) NSInteger negativeAbsoluteTotal;
@property (nonatomic) CGFloat barLabelHeight;

@end

@implementation MWChart

- (instancetype)initWithDataContainer:(MWDataContainer *)dataContainer height:(CGFloat)height dateComponents:(NSDateComponents *)dateComponents
{
    self = [super init];
    if (self) {
        // Properties from user
        self.dataContainer = dataContainer;
        self.dateComponents = dateComponents;
        self.monthLabel = [[MWMonthLabel alloc] initWithChartDateComponents:self.dateComponents];
        
        // Filler
        _zeroLineHeight = 2;
        _height = height - _zeroLineHeight;
        _barWidth = 20;
        _barPaddingRight = 10;
        _markerLineInterval = 10;
        _markerLineHeight = 0.5;
    }
    return self;
}

- (instancetype)initWithDataContainer:(MWDataContainer *)dataContainer height:(CGFloat)height
{
    NSDateComponents *dateComponentNow = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:[NSDate date]];
    return [self initWithDataContainer:dataContainer height:height dateComponents:dateComponentNow];
}

- (instancetype)initWithDataContainer:(MWDataContainer *)dataContainer
{
    NSDateComponents *dateComponentNow = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:[NSDate date]];
    return [self initWithDataContainer:dataContainer height:100 dateComponents:dateComponentNow];
}

- (void)analyseData
{
//    if (self.dataContainer.maxValue > 0) {
//        self.height -= self.barLabelHeight;
//    }
//    if (self.dataContainer.minValue < 0) {
//        self.height -= self.barLabelHeight;
//    }
    // Find how much does a bar label take up in vertical size
    self.barLabelPadding = round((self.barLabelHeight / self.height) * self.dataContainer.valueRange);
    
    // Adjust the range to fit the label
    NSInteger valueRangeWithLabel = self.dataContainer.valueRange;
    if (self.dataContainer.maxValue > 0) {
        valueRangeWithLabel += self.barLabelPadding;
    }
    if (self.dataContainer.minValue < 0) {
        valueRangeWithLabel += self.barLabelPadding;
    }
    
    // Positive padding
    if (self.dataContainer.maxValue > 0) {
        self.positiveAbsoluteTotal = self.barLabelPadding + self.dataContainer.maxValue;
        self.positivePadding = self.markerLineInterval - self.positiveAbsoluteTotal % self.markerLineInterval;
        self.positiveAbsoluteTotal += self.positivePadding;
    } else {
        self.positivePadding = 0;
        self.positiveAbsoluteTotal = 0;
    }
    
    // Negative padding
    if (self.dataContainer.minValue < 0) {
        self.negativeAbsoluteTotal = -self.barLabelPadding + self.dataContainer.minValue;
        self.negativePadding = self.markerLineInterval + self.negativeAbsoluteTotal % self.markerLineInterval;
        self.negativeAbsoluteTotal -= self.negativePadding;
    } else {
        self.negativePadding = 0;
    }
    
    self.valueRangeWithPadding = valueRangeWithLabel + self.positivePadding + self.negativePadding;
    
    // Positive part
    if (self.dataContainer.minValue < 0) {
        NSInteger minValueWithLabelAndPadding = self.barLabelPadding + labs(self.dataContainer.minValue) + self.negativePadding;
        self.negativePart = (CGFloat)minValueWithLabelAndPadding / (CGFloat)self.valueRangeWithPadding;
    } else {
        self.negativePart = 0;
    }
    self.positivePart = 1 - self.negativePart;
}

- (void)createBars
{
    NSMutableArray *array = [NSMutableArray array];
    
    CGFloat positionX = self.barPaddingRight/2;
    CGFloat positionY = 0;

    CGFloat zeroLineY = self.height * self.negativePart * -1;
    
    for (MWData *data in self.dataContainer.dataArray) {
        // Size
        CGFloat heightRelative = (CGFloat)labs(data.value) / (CGFloat)self.valueRangeWithPadding;
        if (heightRelative != heightRelative) {
            heightRelative = 0;
        }
        CGSize size = CGSizeMake(self.barWidth, self.height * heightRelative);
        
        // Positivity
        BOOL positive = (data.value >= 0);
        if (self.dataContainer.maxValue == 0 && self.dataContainer.minValue != 0) {
            positive = NO;
        }
        
        // Position
        positionY = zeroLineY;
        
        if (!positive) {
            positionY += size.height;
            positionY += self.zeroLineHeight;
        }
        
        positionY += self.height - size.height;
        CGPoint position = CGPointMake(positionX, positionY);
        
        // Title
        NSString *title = [NSString stringWithFormat:@"%ld", labs(data.value)];
        
        MWChartBar *bar = [[MWChartBar alloc] initWithSize:size position:position positive:positive title:title];
        [array addObject:bar];
        
        positionX += self.barWidth + self.barPaddingRight;
    }
    
    self.bars = array;
}

- (void)createMarkerLines
{
    NSMutableArray *array = [NSMutableArray array];
    
    NSInteger lineCount = 0;
    CGFloat lineYPadding = ((CGFloat)self.markerLineInterval / (CGFloat)self.valueRangeWithPadding) * self.height;
    if (lineYPadding == INFINITY) {
        lineYPadding = 0;
    }
    CGFloat lineYZeroLineJump = 0;
    NSInteger zeroLineNumber = -1;
    
    if (self.positivePart > 0) {
        lineCount += (labs(self.dataContainer.maxValue) + self.positivePadding + self.barLabelPadding) / self.markerLineInterval;
        if (self.dataContainer.maxValue != 0) {
            zeroLineNumber = lineCount;
        }
    }
    if (self.negativePart > 0) {
        if (zeroLineNumber == -1 && lineCount == 0) {
            zeroLineNumber = 0;
        }
        lineCount += (labs(self.dataContainer.minValue) + self.negativePadding + self.barLabelPadding) / self.markerLineInterval;
    }
    
    for (NSInteger lineNumber = 0; lineNumber <= lineCount; lineNumber++) {
        CGFloat paddingY = lineYPadding * lineNumber + lineYZeroLineJump;
        CGFloat paddingYRounded = round(paddingY);
        CGFloat delta = paddingY - paddingYRounded;
        CGFloat inset = 0;
        if (delta > 0.5) {
            inset = 0.5;
        } else {
            inset = -0.5;
        }
        CGFloat paddingYWithInset = paddingYRounded;
        if (paddingYWithInset != 0) {
            paddingYWithInset += inset;
        }
        
        CGSize size = CGSizeMake([self width], self.markerLineHeight);
        CGPoint position = CGPointMake(0, paddingYWithInset);
        
        MWChartLine *line = [[MWChartLine alloc] initWithSize:size position:position];
        line.level = self.positiveAbsoluteTotal - lineNumber * self.markerLineInterval;
        
        if (lineNumber != zeroLineNumber) {
            [array addObject:line];
        } else {
            lineYZeroLineJump = self.zeroLineHeight;
        }
        
    }
    
    self.markerLines = array;
}

- (void)createGoalLines
{
    NSInteger index = 0;
    NSInteger currentGoal = self.dataContainer.firstDataItem.goal;
    NSInteger currentGoalStarted = 0;
    NSInteger currentGoalLength = 0;
    
    for (MWData *data in self.dataContainer.dataArray) {
        if (data.goal != currentGoal) {
            // Save the ongoing goal line
            MWChartGoalLine *goalLine = [[MWChartGoalLine alloc] initWithGoal:currentGoal chart:self barRange:NSMakeRange(currentGoalStarted, currentGoalLength)];
            MWChartLine *markerLine = [self markerLineAtLevel:currentGoal];
            [markerLine addGoalLine:goalLine];
            
            // Setup for a new one
            currentGoal = data.goal;
            currentGoalStarted = index;
            currentGoalLength = 0;
        }

        index++;
        currentGoalLength++;
    }
    // Save the last goal line
    MWChartGoalLine *goalLine = [[MWChartGoalLine alloc] initWithGoal:currentGoal chart:self barRange:NSMakeRange(currentGoalStarted, currentGoalLength)];
    MWChartLine *markerLine = [self markerLineAtLevel:currentGoal];
    [markerLine addGoalLine:goalLine];
}

- (void)createDayLabels
{
    NSMutableArray *array = [NSMutableArray array];
    
    CGFloat positionX = self.barPaddingRight/2;
    CGFloat positionY = self.heightTotal;
    CGFloat width = self.barWidth;
    CGFloat height = [MWDayLabel dayLabelHeight];
    
    for (MWData *data in self.dataContainer.dataArray) {
        CGRect frame = CGRectMake(positionX,
                                  positionY,
                                  width,
                                  height);
        MWDayLabel *dayLabel = [[MWDayLabel alloc] initWidthDayNumber:[data dayNumber] chartDateComponents:self.dateComponents frame:frame];
        [array addObject:dayLabel];
        
        positionX += self.barWidth + self.barPaddingRight;
    }
    
    self.dayLabels = array;
}

#pragma mark - Chart creation

- (void)createChart
{
    [self analyseData];
    [self createBars];
    [self createMarkerLines];
    [self createGoalLines];
    [self createDayLabels];
}

#pragma mark - Setters

- (void)setHeight:(CGFloat)height
{
    _height = height;
}

- (void)setZeroLineHeight:(CGFloat)zeroLineHeight
{
    CGFloat heightNew = [self heightTotal] - zeroLineHeight;
    _zeroLineHeight = zeroLineHeight;
    self.height = heightNew;
}

#pragma mark - Getters

- (CGFloat)width
{
    return (self.barWidth + self.barPaddingRight) * [self.bars count];
}

- (CGFloat)heightTotal
{
    return self.height + self.zeroLineHeight;
}

- (CGRect)zeroLineFrame
{
    return CGRectMake(0,
                      self.positivePart * self.height,
                      [self width],
                      self.zeroLineHeight);
}

- (CGFloat)barLabelHeight
{
    if (_barLabelHeight == 0) {
        _barLabelHeight = [MWChartBar labelHeight];
    }
    return _barLabelHeight;
}

- (NSInteger)markerLineIndexByLevel:(NSInteger)level
{
    NSInteger index = 0;
    for (MWChartLine *markerLine in self.markerLines) {
        if (markerLine.level == level) {
            return index;
        }
        index++;
    }
    return NSIntegerMin;
}

- (MWChartLine *)markerLineAtLevel:(NSInteger)level
{
    for (MWChartLine *markerLine in self.markerLines) {
        if (markerLine.level == level) {
            return markerLine;
        }
    }
    return nil;
}

@end
