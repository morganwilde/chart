//
//  MWDayLabel.h
//  Chart
//
//  Created by Morgan Wilde on 26/04/2015.
//  Copyright (c) 2015 Morgan Wilde. All rights reserved.
//

@import UIKit;

@interface MWDayLabel : NSObject

@property (nonatomic) NSInteger dayNumber;
@property (nonatomic) NSDateComponents *chartDateComponents;
@property (nonatomic, readonly) NSAttributedString *dayString;
@property (nonatomic, readonly) NSAttributedString *weekdayString;

- (instancetype)initWidthDayNumber:(NSInteger)dayNumber chartDateComponents:(NSDateComponents *)chartDateComponents frame:(CGRect)frame;

- (CGRect)weekdayFrame;
- (CGRect)dayFrame;

+ (CGFloat)dayLabelHeight;

@end
