//
//  MWChartHeaderView.m
//  Chart
//
//  Created by Morgan Wilde on 26/04/2015.
//  Copyright (c) 2015 Morgan Wilde. All rights reserved.
//

#import "MWChartHeaderView.h"

@interface MWChartHeaderView ()

@property (nonatomic) MWChart *chart;

@end

@implementation MWChartHeaderView

- (instancetype)initWithPosition:(CGPoint)position chart:(MWChart *)chart
{
    CGRect frame = CGRectMake(position.x,
                              position.y,
                              [chart width],
                              [MWMonthLabel labelHeight]);
    self = [super initWithFrame:frame];
    if (self) {
        self.chart = chart;
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    CGSize labelSize = self.chart.monthLabel.labelString.size;
    CGFloat paddingY = rect.size.height/2 - labelSize.height/2;
    CGRect labelRect = CGRectMake(rect.origin.x + paddingY,
                                  rect.origin.y + paddingY,
                                  labelSize.width,
                                  labelSize.height);
    
//    UIBezierPath *labelPath = [UIBezierPath bezierPathWithRect:labelRect];
//    [[UIColor greenColor] setFill];
//    [labelPath fill];
    
    [self.chart.monthLabel.labelString drawInRect:labelRect];
}

@end
