//
//  MWChartView.m
//  Chart
//
//  Created by Morgan Wilde on 20/04/2015.
//  Copyright (c) 2015 Morgan Wilde. All rights reserved.
//

#import "MWChartView.h"
#import "MWChartLine.h"
#import "MWChartBar.h"
#import "MWChartGoalLine.h"
#import "MWDayLabel.h"
#import "MWMonthLabel.h"

#import "MWConstants.h"

@interface MWChartView ()

@property (nonatomic) MWChart *chart;

@end

@implementation MWChartView

- (instancetype)initWithPosition:(CGPoint)position chart:(MWChart *)chart
{
    CGRect frame = CGRectMake(position.x,
                              position.y,
                              [chart width],
                              [chart heightTotal] + [MWDayLabel dayLabelHeight]);
    
    self = [super initWithFrame:frame];
    
    if (self) {
        self.chart = chart;
        self.backgroundColor = [MWConstants chartBackgroundColor];
    }
    
    return self;
}

- (void)drawRect:(CGRect)rect
{
    // Draw the zero line
    [[MWConstants zeroMarkerLineFillColor] setFill];
    UIBezierPath *zeroLinePath = [UIBezierPath bezierPathWithRect:[self.chart zeroLineFrame]];
    [zeroLinePath fill];
    
    // Draw the marker lines
    NSMutableArray *goalLinePaths = [NSMutableArray array];
    
    for (MWChartLine *markerLine in self.chart.markerLines) {
        CGRect markerLineRect = [markerLine frame];
        [[MWConstants markerLineFillColor] setFill];
        
        if ([markerLine.goalLines count] > 0) {
            CGFloat positionXCurrent = 0;
            
            for (MWChartGoalLine *goalLine in markerLine.goalLines) {
                // Marker line
                CGRect rect = CGRectMake(positionXCurrent,
                                         markerLineRect.origin.y,
                                         goalLine.positionX - positionXCurrent,
                                         markerLineRect.size.height);
                positionXCurrent = goalLine.positionX + goalLine.width;
                [[MWConstants markerLineFillColor] setFill];
                UIBezierPath *path = [UIBezierPath bezierPathWithRect:rect];
                [path fill];
                
                // Goal line
                CGFloat lineStartPointX = rect.origin.x + rect.size.width;
                CGFloat lineEndPointX = rect.origin.x + rect.size.width + goalLine.width;
                if ((goalLine.to - goalLine.from) >= 1) {
                    lineEndPointX -= [MWConstants barPadding]/2;
                    positionXCurrent -= [MWConstants barPadding]/2;
                }
                
                // Goal line end points
                CGSize goalLinePointSize = [MWConstants goalLineEndCapSize];
                lineStartPointX -= goalLinePointSize.width/2;
                lineEndPointX += goalLinePointSize.width/2;
                CGRect goalLineStartRect = CGRectMake(lineStartPointX,
                                                      rect.origin.y - goalLinePointSize.height/2,
                                                      goalLinePointSize.width,
                                                      goalLinePointSize.height);
                CGRect goalLineEndRect = CGRectMake(lineEndPointX - goalLinePointSize.width,
                                                    rect.origin.y - goalLinePointSize.height/2,
                                                    goalLinePointSize.width,
                                                    goalLinePointSize.height);
                
                UIBezierPath *goalLineStart = [UIBezierPath bezierPathWithOvalInRect:goalLineStartRect];
                UIBezierPath *goalLineEnd = [UIBezierPath bezierPathWithOvalInRect:goalLineEndRect];
                [goalLinePaths addObject:goalLineStart];
                [goalLinePaths addObject:goalLineEnd];
                
                // Goal line
                lineStartPointX += goalLinePointSize.width;
                lineEndPointX -= goalLinePointSize.width;
                
                UIBezierPath *goalPath = [UIBezierPath bezierPath];
                [goalPath moveToPoint:CGPointMake(lineStartPointX, rect.origin.y)];
                [goalPath addLineToPoint:CGPointMake(lineEndPointX, rect.origin.y)];
                goalPath.lineWidth = 1;
                CGFloat dashPattern[] = {6, 2};
                [goalPath setLineDash:dashPattern count:2 phase:0];
                
                [goalLinePaths addObject:goalPath];
            }
            CGRect rect = CGRectMake(positionXCurrent,
                                     markerLineRect.origin.y,
                                     markerLineRect.size.width - positionXCurrent,
                                     markerLineRect.size.height);
            [[MWConstants markerLineFillColor] setFill];
            UIBezierPath *path = [UIBezierPath bezierPathWithRect:rect];
            [path fill];
            
        } else {
            UIBezierPath *path = [UIBezierPath bezierPathWithRect:markerLineRect];
            [path fill];
        }
        
    }
    
    // Draw the bars
    for (MWChartBar *bar in self.chart.bars) {
        [bar.fillColor setFill];
        
        UIBezierPath *path = [UIBezierPath bezierPathWithRect:[bar frame]];
        [path fill];
        
//        // DEBUG
//        [[UIColor greenColor] setFill];
//        UIBezierPath *labelPath = [UIBezierPath bezierPathWithRect:[bar labelFrame]];
//        [labelPath fill];
//        // /DEBUG
        
        // TODO: fix this for a hundred
        [bar labelFrame];
        [bar.labelAttributedString drawInRect:[bar labelFrame]];
    }
    
    // Draw goal lines
    NSInteger index = 0;
    for (UIBezierPath *goalPath in goalLinePaths) {
        [[MWConstants goalLineFillColor] setFill];
        [[MWConstants goalLineStrokeColor] setStroke];
        
        if (index % 3 == 0) {
            [goalPath fill];
        }
        [goalPath stroke];
        
        
        index++;
    }
    
    // Draw day labels
    for (MWDayLabel *dayLabel in self.chart.dayLabels) {
        [dayLabel.weekdayString drawInRect:[dayLabel weekdayFrame]];
        [dayLabel.dayString drawInRect:[dayLabel dayFrame]];
    }
}

@end
