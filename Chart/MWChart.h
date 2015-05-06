//
//  MWChart.h
//  Chart
//
//  Created by Morgan Wilde on 19/04/2015.
//  Copyright (c) 2015 Morgan Wilde. All rights reserved.
//

@import Foundation;
@import CoreGraphics;
#import "MWDataContainer.h"
#import "MWChartMarkerLine.h"
#import "MWMonthLabel.h"

@interface MWChart : NSObject

@property (nonatomic) MWDataContainer *dataContainer;
@property (nonatomic) CGFloat height;

// Date
@property (nonatomic) NSDateComponents *dateComponents;

// Bar label related properties
@property (nonatomic) NSInteger barLabelPadding;

// Line properties
@property (nonatomic) NSInteger markerLineInterval;
// Padding
@property (nonatomic) NSInteger positivePadding;
@property (nonatomic) NSInteger negativePadding;
@property (nonatomic) NSInteger valueRangeWithPadding;

// Geometry objects/arrays
@property (nonatomic) MWMonthLabel *monthLabel;
@property (nonatomic) NSArray *bars;
@property (nonatomic) NSArray *markerLines;
@property (nonatomic) NSArray *goalLines;
@property (nonatomic) NSArray *dayLabels;

- (instancetype)initWithDataContainer:(MWDataContainer *)dataContainer height:(CGFloat)height dateComponents:(NSDateComponents *)dateComponents;

- (void)createBars;
- (void)createMarkerLines;
- (void)createGoalLines;
- (void)createChart;

- (CGFloat)width;
- (CGFloat)heightTotal;
- (CGRect)zeroLineFrame;
- (MWChartMarkerLine *)markerLineAtLevel:(NSInteger)level;

@end
