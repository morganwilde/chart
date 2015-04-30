//
//  MWChartGoalLine.m
//  Chart
//
//  Created by Morgan Wilde on 21/04/2015.
//  Copyright (c) 2015 Morgan Wilde. All rights reserved.
//

#import "MWChartGoalLine.h"
#import "MWChart.h"
#import "MWChartBar.h"

#import "MWConstants.h"

@implementation MWChartGoalLine

- (instancetype)initWithGoal:(NSInteger)goal chart:(MWChart *)chart barRange:(NSRange)range
{
    self = [super init];
    if (self) {
        self.goal = goal;
        self.chart = chart;
        self.from = range.location;
        self.to = self.from + range.length;// - 1;
        
        // Calculate the appropriate starting position
        CGFloat barSpace = [MWConstants barWidth] + [MWConstants barPadding];
        self.positionX = barSpace * self.from;
        
        // And the width
        if (self.from == self.to) {
            self.width = barSpace + [MWConstants barPadding]/2;
        } else {
            self.width = barSpace * self.to - self.positionX + [MWConstants barPadding]/2;
        }
    }
    return self;
}

@end
