//
//  MWChartLine.m
//  Chart
//
//  Created by Morgan Wilde on 21/04/2015.
//  Copyright (c) 2015 Morgan Wilde. All rights reserved.
//

#import "MWChartLine.h"
#import "MWChartGoalLine.h"

#import "MWConstants.h"

@implementation MWChartLine

- (instancetype)initWithSize:(CGSize)size position:(CGPoint)position
{
    self = [super init];
    if (self) {
        self.size = size;
        self.position = position;
        self.goalLines = [NSMutableArray array];
    }
    return self;
}

#pragma mark - Convenience methods

- (CGRect)frame
{
    return CGRectMake(self.position.x, self.position.y, self.size.width, self.size.height);
}

- (void)addGoalLine:(MWChartGoalLine *)goalLine
{
    [self.goalLines addObject:goalLine];
}

@end
