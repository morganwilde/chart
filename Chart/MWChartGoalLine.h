//
//  MWChartGoalLine.h
//  Chart
//
//  Created by Morgan Wilde on 21/04/2015.
//  Copyright (c) 2015 Morgan Wilde. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MWChartLine.h"

@class MWChart;

@interface MWChartGoalLine : NSObject

@property (nonatomic) MWChart *chart;
@property (nonatomic) NSInteger from;
@property (nonatomic) NSInteger to;
@property (nonatomic) NSInteger goal;

@property (nonatomic) CGFloat width;
@property (nonatomic) CGFloat positionX;

- (instancetype)initWithGoal:(NSInteger)goal chart:(MWChart *)chart barRange:(NSRange)range;

@end
