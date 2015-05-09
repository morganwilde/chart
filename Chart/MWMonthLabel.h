//
//  MWMonthLabel.h
//  Chart
//
//  Created by Morgan Wilde on 26/04/2015.
//  Copyright (c) 2015 Morgan Wilde. All rights reserved.
//

@import UIKit;

@interface MWMonthLabel : NSObject

@property (nonatomic) NSDateComponents *chartDateComponents;
@property (nonatomic, readonly) NSAttributedString *labelString;

- (instancetype)initWithChartDateComponents:(NSDateComponents *)chartDateComponents;

+ (CGFloat)monthTextHeight;
+ (CGFloat)labelHeight;

@end
