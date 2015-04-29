//
//  MWChartHeaderView.m
//  Chart
//
//  Created by Morgan Wilde on 26/04/2015.
//  Copyright (c) 2015 Morgan Wilde. All rights reserved.
//

#import "MWChartHeaderView.h"

#import "MWConstants.h"

@interface MWChartHeaderView ()

@property (nonatomic) MWChart *chart;
@property (nonatomic) CGFloat padding;

@end

@implementation MWChartHeaderView

- (instancetype)initWithPosition:(CGPoint)position chart:(MWChart *)chart
{
    CGRect frame = CGRectMake(0,
                              position.y,
                              [chart width],
                              [MWMonthLabel labelHeight]);
    
    self = [super initWithFrame:frame];
    
    if (self) {
        self.chart = chart;
        self.padding = self.frame.size.height/2 - self.chart.monthLabel.labelString.size.height/2;
        self.backgroundColor = [MWConstants chartBackgroundColor];
    }
    
    return self;
}

- (void)drawRect:(CGRect)rect {
    CGSize labelSize = self.chart.monthLabel.labelString.size;
    CGRect labelRect = CGRectMake(rect.origin.x + self.padding + self.visibleFromX,
                                  rect.origin.y + self.padding,
                                  labelSize.width,
                                  labelSize.height);
    
//    UIBezierPath *labelPath = [UIBezierPath bezierPathWithRect:labelRect];
//    [[UIColor greenColor] setFill];
//    [labelPath fill];
    
    [self.chart.monthLabel.labelString drawInRect:labelRect];
}

- (void)setVisibleFromX:(CGFloat)visibleFromX
{
    CGFloat positionXMax = self.frame.size.width - self.chart.monthLabel.labelString.size.width - self.padding*2;
    
    if (visibleFromX >= 0 && visibleFromX <= positionXMax) {
        _visibleFromX = visibleFromX;
    } else if (visibleFromX < 0) {
        _visibleFromX = 0;
    } else if (visibleFromX > positionXMax) {
        _visibleFromX = positionXMax;
    }
    
    [self setNeedsDisplay];
}

@end
