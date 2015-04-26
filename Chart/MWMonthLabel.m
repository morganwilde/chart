//
//  MWMonthLabel.m
//  Chart
//
//  Created by Morgan Wilde on 26/04/2015.
//  Copyright (c) 2015 Morgan Wilde. All rights reserved.
//

#import "MWMonthLabel.h"

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
            case MWJanuary  : string = @"january"; break;
            case MWFebruary : string = @"february"; break;
            case MWMarch    : string = @"march"; break;
            case MWApril    : string = @"april"; break;
            case MWMay      : string = @"may"; break;
            case MWJune     : string = @"june"; break;
            case MWJuly     : string = @"july"; break;
            case MWAugust   : string = @"august"; break;
            case MWSeptember: string = @"september"; break;
            case MWOctober  : string = @"october"; break;
            case MWNovember : string = @"november"; break;
            case MWDecember : string = @"december"; break;
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
                                 NSForegroundColorAttributeName: [UIColor blackColor]};
    
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
    return [MWMonthLabel monthTextHeight] + paddingTotal;
}

@end
