//
//  MWMonthLabel.m
//  Chart
//
//  Created by Morgan Wilde on 26/04/2015.
//  Copyright (c) 2015 Morgan Wilde. All rights reserved.
//

#import "MWMonthLabel.h"

#import "MWConstants.h"

@interface MWMonthLabel ()

@property (nonatomic) MWMonth month;
@property (nonatomic) NSString *monthText;
@property (nonatomic) NSString *labelText;
@property (nonatomic, readwrite) NSAttributedString *labelString;

@end

@implementation MWMonthLabel

- (instancetype)initWithChartDateComponents:(NSDateComponents *)chartDateComponents
{
    self = [super init];
    if (self) {
        self.chartDateComponents = chartDateComponents;
        self.month = self.chartDateComponents.month;
        
        self.labelText = [NSString stringWithFormat:@"%@ %ld", self.monthText, self.chartDateComponents.year];
        self.labelString = [[NSAttributedString alloc] initWithString:self.labelText attributes:[MWMonthLabel monthAttributes]];
    }
    return self;
}

- (NSString *)monthText
{
    if (!_monthText) {
        NSString *string = nil;
        switch (self.month) {
            case MWJanuary  : string = @"January"; break;
            case MWFebruary : string = @"February"; break;
            case MWMarch    : string = @"March"; break;
            case MWApril    : string = @"April"; break;
            case MWMay      : string = @"May"; break;
            case MWJune     : string = @"June"; break;
            case MWJuly     : string = @"July"; break;
            case MWAugust   : string = @"August"; break;
            case MWSeptember: string = @"September"; break;
            case MWOctober  : string = @"October"; break;
            case MWNovember : string = @"November"; break;
            case MWDecember : string = @"December"; break;
        }
        _monthText = string;
    }
    
    return _monthText;
}

#pragma mark - Class constants
+ (CGFloat)paddingTop
{
    return 6;
}
+ (CGFloat)paddingBottom
{
    return 6;
}
+ (NSDictionary *)monthAttributes
{
    UIFont *font = [UIFont fontWithName:@"Comfortaa-Bold" size:11];
    NSDictionary *attributes = @{NSFontAttributeName: font,
                                 NSForegroundColorAttributeName: [MWConstants monthLabelForegroundColor]};
    
    return attributes;
}

#pragma mark - Size
+ (CGFloat)monthTextHeight
{
    NSAttributedString *test = [[NSAttributedString alloc] initWithString:@"MMM" attributes:[MWMonthLabel monthAttributes]];
    return [test size].height;
}
+ (CGFloat)labelHeight
{
    CGFloat paddingTotal = [MWMonthLabel paddingTop] + [MWMonthLabel paddingBottom];
    return roundf([MWMonthLabel monthTextHeight] + paddingTotal);
}

@end
