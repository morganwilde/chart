//
//  MWChartContainerView.m
//  Chart
//
//  Created by Morgan Wilde on 26/04/2015.
//  Copyright (c) 2015 Morgan Wilde. All rights reserved.
//

#import "MWChartContainerView.h"
#import "MWChartView.h"
#import "MWChartHeaderView.h"
#import "MWDayLabel.h"
#import "MWMonthLabel.h"

@interface MWChartContainerView ()

@property (nonatomic) MWChart *chart;
@property (nonatomic) MWChartHeaderView *chartHeaderView;
@property (nonatomic) MWChartView *chartView;

@end

@implementation MWChartContainerView

- (instancetype)initWithPosition:(CGPoint)position chart:(MWChart *)chart
{
    CGRect frame = CGRectMake(position.x,
                              position.y,
                              [chart width],
                              [MWMonthLabel labelHeight] + [chart heightTotal] + [MWDayLabel dayLabelHeight]);
    self = [super initWithFrame:frame];
    if (self) {
        self.chart = chart;
        CGPoint chartHeaderPosition = CGPointMake(position.x, 0);
        CGPoint chartPosition = CGPointMake(0, [MWMonthLabel labelHeight]);
        
        self.chartHeaderView = [[MWChartHeaderView alloc] initWithPosition:chartHeaderPosition chart:self.chart];
        self.chartView = [[MWChartView alloc] initWithPosition:chartPosition chart:self.chart];
        
        [self addSubview:self.chartHeaderView];
        [self addSubview:self.chartView];
        
        self.backgroundColor = [UIColor colorWithRed:238/255.0 green:199/255.0 blue:101/255.0 alpha:1];
    }
    return self;
}

- (void)setVisibleFromX:(CGFloat)visibleFromX
{
    _visibleFromX = visibleFromX;
    self.chartHeaderView.visibleFromX = _visibleFromX - self.frame.origin.x;
    NSLog(@"self.chartHeaderView.visibleFromX: %f", self.chartHeaderView.visibleFromX);
}

@end
