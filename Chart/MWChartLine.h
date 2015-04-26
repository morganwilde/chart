//
//  MWChartLine.h
//  Chart
//
//  Created by Morgan Wilde on 21/04/2015.
//  Copyright (c) 2015 Morgan Wilde. All rights reserved.
//

@import Foundation;
@import CoreGraphics;
@import UIKit;

@class MWChartGoalLine;

@interface MWChartLine : NSObject

@property (nonatomic) CGSize size;
@property (nonatomic) CGPoint position;
@property (nonatomic) UIColor *fillColor;
@property (nonatomic) NSInteger level;

@property (nonatomic) NSMutableArray *goalLines;

- (instancetype)initWithSize:(CGSize)size position:(CGPoint)position;

- (CGRect)frame;
- (void)addGoalLine:(MWChartGoalLine *)goalLine;

@end
