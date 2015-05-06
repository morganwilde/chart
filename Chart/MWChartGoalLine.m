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
            self.width = barSpace;
        } else {
            self.width = barSpace * self.to - self.positionX;
        }
        // Adjust it for the initial half-padding for the first bar
        self.width += [MWConstants barPadding]/2;
        
        MWChartMarkerLine *markerLine = [self.chart markerLineAtLevel:goal];
        
        // Create line end caps
        CGFloat startCapX = self.positionX - [MWConstants goalLineEndCapSize].width/2;
        CGFloat startCapY = markerLine.position.y - [MWConstants goalLineEndCapSize].height/2;
        CGFloat endCapX = self.positionX + self.width - [MWConstants barPadding]/2 - [MWConstants goalLineEndCapSize].width/2;
        CGFloat endCapY = startCapY;
        
        // Adjust for pixel accuracy
//        startCapX += 0.5;
//        endCapX += 0.5;
        
        self.startCapFrame = CGRectMake(startCapX,
                                        startCapY,
                                        [MWConstants goalLineEndCapSize].width,
                                        [MWConstants goalLineEndCapSize].height);
        self.endCapFrame = CGRectMake(endCapX,
                                      endCapY,
                                      [MWConstants goalLineEndCapSize].width,
                                      [MWConstants goalLineEndCapSize].height);
        
        // Create the main line
        self.startPoint = CGPointMake(startCapX + [MWConstants goalLineEndCapSize].width,
                                      markerLine.position.y);
        self.endPoint = CGPointMake(endCapX,
                                    markerLine.position.y);
        
        // Dash pattern
        self.dashPattern = [MWChartGoalLine makeDashPatternFromConstantString];
    }
    return self;
}

+ (CGFloat *)makeDashPatternFromConstantString
{
    NSString *string = [MWConstants goalLineDashPatternString];
    UniChar *characters = malloc(sizeof(UniChar) * string.length);
    [string getCharacters:characters];
    
    CGFloat dashLength = 0;
    CGFloat spaceLength = 0;
    for (int index = 0; index < string.length; index++) {
        if (characters[index] == '-') {
            dashLength++;
        } else if (characters[index] == ' ') {
            spaceLength++;
        }
    }
    
    CGFloat *pattern = malloc(sizeof(CGFloat) * 2);
    pattern[0] = dashLength;
    pattern[1] = spaceLength;
    
    return pattern;
}

@end
