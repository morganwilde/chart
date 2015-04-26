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

@interface MWChartView ()

@property (nonatomic) MWChart *chart;

@end

@implementation MWChartView

- (instancetype)initWithPosition:(CGPoint)position chart:(MWChart *)chart
{
    CGRect frame = CGRectMake(position.x,
                              position.y,
                              [chart width],
                              [chart heightTotal]);
    
    self = [super initWithFrame:frame];
    if (self) {
        self.chart = chart;
        
        // Default colors
        self.chartBackgroundColor = [UIColor colorWithRed:238/255.0 green:199/255.0 blue:101/255.0 alpha:1];
        
        self.backgroundColor = self.chartBackgroundColor;
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    // Draw the zero line
    [[UIColor colorWithRed:230/255.0 green:56/255.0 blue:62/255.0 alpha:1.0] setFill];
    UIBezierPath *zeroLinePath = [UIBezierPath bezierPathWithRect:[self.chart zeroLineFrame]];
    [zeroLinePath fill];
    
    // Draw the marker lines
    NSMutableArray *goalLinePaths = [NSMutableArray array];
    
    for (MWChartLine *markerLine in self.chart.markerLines) {
        CGRect markerLineRect = [markerLine frame];
        [markerLine.fillColor setFill];
        
        if ([markerLine.goalLines count] > 0) {
            CGFloat positionXCurrent = 0;
            
            for (MWChartGoalLine *goalLine in markerLine.goalLines) {
                // Marker line
                CGRect rect = CGRectMake(positionXCurrent,
                                         markerLineRect.origin.y,
                                         goalLine.positionX - positionXCurrent,
                                         markerLineRect.size.height);
                positionXCurrent = goalLine.positionX + goalLine.width;
                [markerLine.fillColor setFill];
                UIBezierPath *path = [UIBezierPath bezierPathWithRect:rect];
                [path fill];
                
                // Goal line
                CGFloat lineStartPointX = rect.origin.x + rect.size.width;
                CGFloat lineEndPointX = rect.origin.x + rect.size.width + goalLine.width;
                if ((goalLine.to - goalLine.from) >= 1) {
                    lineEndPointX -= self.chart.barPaddingRight/2;
                    positionXCurrent -= self.chart.barPaddingRight/2;
                }
                
                // Goal line end points
                CGSize goalLinePointSize = CGSizeMake(4, 4);
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
                
                [[UIColor blackColor] setFill];
                [[UIColor blackColor] setStroke];
                
                [goalLineStart fill];
                [goalLineEnd stroke];
                
                // Goal line
                lineStartPointX += goalLinePointSize.width;
                lineEndPointX -= goalLinePointSize.width;
                [[UIColor whiteColor] setFill];
                
                UIBezierPath *goalPath = [UIBezierPath bezierPath];
                [goalPath moveToPoint:CGPointMake(lineStartPointX, rect.origin.y)];
                [goalPath addLineToPoint:CGPointMake(lineEndPointX, rect.origin.y)];
                goalPath.lineWidth = 1;
                CGFloat dashPattern[] = {6, 2};
                [goalPath setLineDash:dashPattern count:2 phase:0];
                [[UIColor blackColor] setStroke];
                [goalPath stroke];
                
                [goalLinePaths addObject:goalPath];
            }
            CGRect rect = CGRectMake(positionXCurrent,
                                     markerLineRect.origin.y,
                                     markerLineRect.size.width - positionXCurrent,
                                     markerLineRect.size.height);
            [markerLine.fillColor setFill];
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
        [[UIColor blackColor] setFill];
        [[UIColor blackColor] setStroke];
        
        if (index % 3 == 0) {
            [goalPath fill];
        }
        [goalPath stroke];
        
        
        index++;
    }
}

@end
