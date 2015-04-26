//
//  MWMonthLabel.h
//  Chart
//
//  Created by Morgan Wilde on 26/04/2015.
//  Copyright (c) 2015 Morgan Wilde. All rights reserved.
//

@import UIKit;

typedef NS_ENUM(NSInteger, MWMonth) {
    MWJanuary = 1,
    MWFebruary = 2,
    MWMarch = 3,
    MWApril = 4,
    MWMay = 5,
    MWJune = 6,
    MWJuly = 7,
    MWAugust = 8,
    MWSeptember = 9,
    MWOctober = 10,
    MWNovember = 11,
    MWDecember = 12
};

@interface MWMonthLabel : NSObject

@property (nonatomic) NSDateComponents *chartDateComponents;
@property (nonatomic, readonly) NSAttributedString *labelString;

- (instancetype)initWithChartDateComponents:(NSDateComponents *)chartDateComponents;

+ (CGFloat)monthTextHeight;
+ (CGFloat)labelHeight;

@end
