//
//  MWChartView.m
//  Chart
//
//  Created by Morgan Wilde on 20/04/2015.
//  Copyright (c) 2015 Morgan Wilde. All rights reserved.
//

#import "MWChartView.h"
#import "MWChartMarkerLine.h"
#import "MWChartBar.h"
#import "MWChartGoalLine.h"
#import "MWDayLabel.h"
#import "MWMonthLabel.h"

#import "MWConstants.h"

@interface MWChartView ()

@property (nonatomic) MWChart *chart;

@end

@implementation MWChartView

- (instancetype)initWithPosition:(CGPoint)position chart:(MWChart *)chart
{
    CGRect frame = CGRectMake(position.x,
                              position.y,
                              [chart width],
                              [chart heightTotal] + [MWDayLabel dayLabelHeight]);
    
    self = [super initWithFrame:frame];
    
    if (self) {
        self.chart = chart;
        self.backgroundColor = [MWConstants chartBackgroundColor];
    }
    
    return self;
}

- (void)drawRect:(CGRect)rect
{
    [self drawZeroMarkerLineSegment];
    [self drawMarkerLinesSegment];
    [self drawBarsSegment];
    [self drawGoalLinesSegment];
    [self drawDayLabelsSegment];
}

- (void)drawZeroMarkerLineSegment
{
    [[MWConstants zeroMarkerLineFillColor] setFill];
    UIBezierPath *zeroLinePath = [UIBezierPath bezierPathWithRect:[self.chart zeroLineFrame]];
    [zeroLinePath fill];
}

- (void)drawMarkerLinesSegment
{
    [[MWConstants markerLineFillColor] setFill];
    
    for (MWChartMarkerLine *markerLine in self.chart.markerLines) {
        if ([markerLine.markerLineSegments count] > 0) {
            for (NSValue *frameValue in markerLine.markerLineSegments) {
                UIBezierPath *path = [UIBezierPath bezierPathWithRect:[frameValue CGRectValue]];
                [path fill];
            }
        } else {
            UIBezierPath *path = [UIBezierPath bezierPathWithRect:[markerLine frame]];
            [path fill];
        }
    }
}

- (void)drawBarsSegment
{
    for (MWChartBar *bar in self.chart.bars) {
        [bar.fillColor setFill];
        
        UIBezierPath *path = [UIBezierPath bezierPathWithRect:[bar frame]];
        [path fill];
        
        //        // DEBUG
        //        [[UIColor greenColor] setFill];
        //        UIBezierPath *labelPath = [UIBezierPath bezierPathWithRect:[bar labelFrame]];
        //        [labelPath fill];
        //        // /DEBUG
        
        // TODO: fix this for a hundred
        [bar labelFrame];
        [bar.labelAttributedString drawInRect:[bar labelFrame]];
    }
}

- (void)drawGoalLinesSegment
{
    [[MWConstants goalLineFillColor] setFill];
    
    for (MWChartMarkerLine *markerLine in self.chart.markerLines) {
        for (MWChartGoalLine *goalLine in markerLine.goalLines) {
            // Create the shapes
            UIBezierPath *goalLineStart = [UIBezierPath bezierPathWithOvalInRect:goalLine.startCapFrame];
            UIBezierPath *goalLineEnd = [UIBezierPath bezierPathWithOvalInRect:goalLine.endCapFrame];
            UIBezierPath *goalPath = [UIBezierPath bezierPath];
            [goalPath moveToPoint:goalLine.startPoint];
            [goalPath addLineToPoint:goalLine.endPoint];
            [goalPath setLineDash:goalLine.dashPattern count:2 phase:0];
            goalPath.lineWidth = 1;
            
            // Fill and stroke them
            [[MWConstants goalLineStrokeColor] setStroke];
            [goalPath stroke];
            [[MWConstants goalLineStartCapFillColor] setFill];
            [goalLineStart fill];
            [[MWConstants goalLineEndCapStrokeColor] setStroke];
            [goalLineEnd stroke];
        }
    }
}

- (void)drawDayLabelsSegment
{
    for (MWDayLabel *dayLabel in self.chart.dayLabels) {
        [dayLabel.weekdayString drawInRect:[dayLabel weekdayFrame]];
        [dayLabel.dayString drawInRect:[dayLabel dayFrame]];
    }
}

@end
