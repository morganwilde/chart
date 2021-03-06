//
//  MWDayLabel.m
//  Chart
//
//  Created by Morgan Wilde on 26/04/2015.
//  Copyright (c) 2015 Morgan Wilde. All rights reserved.
//

#import "MWDayLabel.h"

#import "MWConstants.h"
#import "MWEnums.h"

@interface MWDayLabel ()

@property (nonatomic) CGRect frame;
@property (nonatomic) NSString *dayText;
@property (nonatomic) NSString *weekdayText;
@property (nonatomic, readwrite) NSAttributedString *dayString;
@property (nonatomic, readwrite) NSAttributedString *weekdayString;

@end

@implementation MWDayLabel

- (instancetype)initWidthDayNumber:(NSInteger)dayNumber chartDateComponents:(NSDateComponents *)chartDateComponents frame:(CGRect)frame
{
    self = [super init];
    if (self) {
        self.dayNumber = dayNumber;
        self.chartDateComponents = chartDateComponents;
        self.frame = frame;
        
        self.dayString = [[NSAttributedString alloc] initWithString:self.dayText attributes:[MWDayLabel dayAttributes]];
        self.weekdayString = [[NSAttributedString alloc] initWithString:self.weekdayText attributes:[MWDayLabel weekdayAttributes]];
    }
    return self;
}

+ (NSDictionary *)dayAttributes
{
    UIFont *font = [UIFont fontWithName:[MWConstants dayLabelDayFontName]
                                   size:[MWConstants dayLabelDayFontSize]];
    
    NSDictionary *attributes = @{NSFontAttributeName: font,
                                 NSForegroundColorAttributeName: [MWConstants dayLabelDayForegroundColor]};
    
    return attributes;
}
+ (NSDictionary *)weekdayAttributes
{
    UIFont *font = [UIFont fontWithName:[MWConstants dayLabelWeekdayFontName]
                                   size:[MWConstants dayLabelWeekdayFontSize]];
    
    NSDictionary *attributes = @{NSFontAttributeName: font,
                                 NSForegroundColorAttributeName: [MWConstants dayLabelWeekdayForegroundColor]};
    
    return attributes;
}

#pragma mark - Size
+ (CGSize)weekdayTextSize
{
    NSAttributedString *test = [[NSAttributedString alloc] initWithString:@"MMM" attributes:[MWDayLabel weekdayAttributes]];
    return [test size];
}
+ (CGSize)dayTextSize
{
    NSAttributedString *test = [[NSAttributedString alloc] initWithString:@"99" attributes:[MWDayLabel dayAttributes]];
    return [test size];
}
+ (CGFloat)dayLabelHeight
{
    CGFloat paddingTotal = [MWConstants dayLabelTopPadding] + [MWConstants dayLabelMiddlePadding] + [MWConstants dayLabelBottomPadding];
    return round([MWDayLabel weekdayTextSize].height + [MWDayLabel dayTextSize].height + paddingTotal);
}

- (MWWeekday)weekdayNumber
{
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    [dateComponents setYear:self.chartDateComponents.year];
    [dateComponents setMonth:self.chartDateComponents.month];
    [dateComponents setDay:self.dayNumber];
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDate *date = [gregorian dateFromComponents:dateComponents];
    NSDateComponents *weekdayComponents = [gregorian components:NSCalendarUnitWeekday fromDate:date];
    
    return (weekdayComponents.weekday + 6) % 7;
}

#pragma mark - Getters

- (NSString *)weekdayText
{
    if (!_weekdayText) {
        MWWeekday weekday = [self weekdayNumber];
        NSString *string = nil;
        switch (weekday) {
            case MWMonday   : string = @"MON"; break;
            case MWTuesday  : string = @"TUE"; break;
            case MWWednesday: string = @"WED"; break;
            case MWThursday : string = @"THU"; break;
            case MWFriday   : string = @"FRI"; break;
            case MWSaturday : string = @"SAT"; break;
            case MWSunday   : string = @"SUN"; break;
        }
        _weekdayText = string;
    }

    return _weekdayText;
}

- (NSString *)dayText
{
    if (!_dayText) {
        _dayText = [NSString stringWithFormat:@"%ld", (long)self.dayNumber];
    }
    return _dayText;
}

#pragma mark - Convenience methods

- (CGRect)weekdayFrame
{
    CGSize size = [self.weekdayString size];
    CGRect rect = CGRectMake(self.frame.origin.x + self.frame.size.width/2 - size.width/2,
                             self.frame.origin.y + [MWConstants dayLabelTopPadding],
                             size.width,
                             size.height);
    
    return rect;
}

- (CGRect)dayFrame
{
    CGSize size = [self.dayString size];
    CGRect rect = CGRectMake(self.frame.origin.x + self.frame.size.width/2 - size.width/2,
                             self.frame.origin.y + [MWConstants dayLabelTopPadding] + [MWDayLabel weekdayTextSize].height + [MWConstants dayLabelMiddlePadding],
                             size.width,
                             size.height);
    
    return rect;
}

@end
