//
//  MWChartTests.m
//  Chart
//
//  Created by Morgan Wilde on 19/04/2015.
//  Copyright (c) 2015 Morgan Wilde. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "MWChart.h"
#import "MWChartBar.h"
#import "MWChartLine.h"
#import <float.h>
#define EPSILON 0.0001

@interface MWChartTests : XCTestCase

@end

@implementation MWChartTests

- (void)testInitialiser
{
    NSArray *dataArray = @[[MWData createDataWithValue:10]];
    MWDataContainer *dataContainer = [[MWDataContainer alloc] initWithDataArray:dataArray];
    MWChart *chart = [[MWChart alloc] initWithDataContainer:dataContainer height:100];
    [chart createChart];
    
    XCTAssertEqual(chart.dataContainer.dataCount, 1);
}

- (void)testZeroValues
{
    NSArray *dataArray = @[[MWData dataWithValue:0],
                           [MWData dataWithValue:0],];
    MWDataContainer *dataContainer = [[MWDataContainer alloc] initWithDataArray:dataArray];
    MWChart *chart = [[MWChart alloc] initWithDataContainer:dataContainer height:100];
    [chart createChart];
    
    // Check bar heights
    XCTAssertEqualWithAccuracy(((MWChartBar *)chart.bars[0]).size.height, 0, FLT_EPSILON);
    XCTAssertEqualWithAccuracy(((MWChartBar *)chart.bars[1]).size.height, 0, FLT_EPSILON);
    
    // Check line positions
    XCTAssertEqualWithAccuracy(((MWChartLine *)chart.markerLines[0]).position.y, 0, FLT_EPSILON);
}

- (void)testBarHeightPositive
{
    NSInteger max = 100;
    NSArray *dataArray = @[[MWData createDataWithValue:0],
                           [MWData createDataWithValue:10],
                           [MWData createDataWithValue:20],
                           [MWData createDataWithValue:25],
                           [MWData createDataWithValue:max]];
    MWDataContainer *dataContainer = [[MWDataContainer alloc] initWithDataArray:dataArray];
    MWChart *chart = [[MWChart alloc] initWithDataContainer:dataContainer height:100];
    [chart createChart];
    
    NSInteger barLabelPadding = 21;
    NSInteger padding = 9;
    NSInteger maxNew = max + barLabelPadding + padding;
    CGFloat height0 = (((MWData *)dataArray[0]).value / (CGFloat)maxNew) * chart.height;
    CGFloat height1 = (((MWData *)dataArray[1]).value / (CGFloat)maxNew) * chart.height;
    CGFloat height2 = (((MWData *)dataArray[2]).value / (CGFloat)maxNew) * chart.height;
    CGFloat height3 = (((MWData *)dataArray[3]).value / (CGFloat)maxNew) * chart.height;
    CGFloat height4 = (((MWData *)dataArray[4]).value / (CGFloat)maxNew) * chart.height;
    
    // Check the height
    XCTAssertEqualWithAccuracy(((MWChartBar *)chart.bars[0]).size.height, height0, FLT_EPSILON);
    XCTAssertEqualWithAccuracy(((MWChartBar *)chart.bars[1]).size.height, height1, FLT_EPSILON);
    XCTAssertEqualWithAccuracy(((MWChartBar *)chart.bars[2]).size.height, height2, FLT_EPSILON);
    XCTAssertEqualWithAccuracy(((MWChartBar *)chart.bars[3]).size.height, height3, FLT_EPSILON);
    XCTAssertEqualWithAccuracy(((MWChartBar *)chart.bars[4]).size.height, height4, FLT_EPSILON);
    
    // Check the position
    XCTAssertEqualWithAccuracy(((MWChartBar *)chart.bars[0]).position.y, chart.height - height0, FLT_EPSILON);
    XCTAssertEqualWithAccuracy(((MWChartBar *)chart.bars[1]).position.y, chart.height - height1, FLT_EPSILON);
    XCTAssertEqualWithAccuracy(((MWChartBar *)chart.bars[2]).position.y, chart.height - height2, FLT_EPSILON);
    XCTAssertEqualWithAccuracy(((MWChartBar *)chart.bars[3]).position.y, chart.height - height3, FLT_EPSILON);
    XCTAssertEqualWithAccuracy(((MWChartBar *)chart.bars[4]).position.y, chart.height - height4, FLT_EPSILON);
}

- (void)testBarHeightNegative
{
    NSInteger max = -100;
    NSArray *dataArray = @[[MWData createDataWithValue:0],
                           [MWData createDataWithValue:-10],
                           [MWData createDataWithValue:-20],
                           [MWData createDataWithValue:-25],
                           [MWData createDataWithValue:max]];
    MWDataContainer *dataContainer = [[MWDataContainer alloc] initWithDataArray:dataArray];
    MWChart *chart = [[MWChart alloc] initWithDataContainer:dataContainer height:100];
    [chart createChart];
    
    NSInteger barLabelPadding = 21;
    NSInteger padding = 9;
    NSInteger maxNew = labs(max) + barLabelPadding + padding;
    CGFloat height0 = -(((MWData *)dataArray[0]).value / (CGFloat)maxNew) * chart.height;
    CGFloat height1 = -(((MWData *)dataArray[1]).value / (CGFloat)maxNew) * chart.height;
    CGFloat height2 = -(((MWData *)dataArray[2]).value / (CGFloat)maxNew) * chart.height;
    CGFloat height3 = -(((MWData *)dataArray[3]).value / (CGFloat)maxNew) * chart.height;
    CGFloat height4 = -(((MWData *)dataArray[4]).value / (CGFloat)maxNew) * chart.height;
    
    // Check the height
    XCTAssertEqualWithAccuracy(((MWChartBar *)chart.bars[0]).size.height, height0, FLT_EPSILON);
    XCTAssertEqualWithAccuracy(((MWChartBar *)chart.bars[1]).size.height, height1, FLT_EPSILON);
    XCTAssertEqualWithAccuracy(((MWChartBar *)chart.bars[2]).size.height, height2, FLT_EPSILON);
    XCTAssertEqualWithAccuracy(((MWChartBar *)chart.bars[3]).size.height, height3, FLT_EPSILON);
    XCTAssertEqualWithAccuracy(((MWChartBar *)chart.bars[4]).size.height, height4, FLT_EPSILON);
    
    // Check the position
    XCTAssertEqualWithAccuracy(((MWChartBar *)chart.bars[0]).position.y, chart.zeroLineHeight, FLT_EPSILON);
    XCTAssertEqualWithAccuracy(((MWChartBar *)chart.bars[1]).position.y, chart.zeroLineHeight, FLT_EPSILON);
    XCTAssertEqualWithAccuracy(((MWChartBar *)chart.bars[2]).position.y, chart.zeroLineHeight, FLT_EPSILON);
    XCTAssertEqualWithAccuracy(((MWChartBar *)chart.bars[3]).position.y, chart.zeroLineHeight, FLT_EPSILON);
    XCTAssertEqualWithAccuracy(((MWChartBar *)chart.bars[4]).position.y, chart.zeroLineHeight, FLT_EPSILON);
}

- (void)testBarHeightMixed
{
    NSArray *dataArray = @[[MWData createDataWithValue:0],
                           [MWData createDataWithValue:5],
                           [MWData createDataWithValue:-10],
                           [MWData createDataWithValue:-25],
                           [MWData createDataWithValue:75]];
    MWDataContainer *dataContainer = [[MWDataContainer alloc] initWithDataArray:dataArray];
    MWChart *chart = [[MWChart alloc] initWithDataContainer:dataContainer height:100];
    [chart createChart];
    
    NSInteger barLabelPadding = 21;
    NSInteger paddingPositive = 4;
    NSInteger paddingNegative = 4;
    NSInteger valueRange = 75 + (barLabelPadding + paddingPositive) + 25 + (barLabelPadding + paddingNegative);
    CGFloat height0 = 0;
    CGFloat height1 = (((MWData *)dataArray[1]).value / (CGFloat)valueRange) * chart.height;
    CGFloat height2 = 2 * height1;
    CGFloat height3 = 5 * height1;
    CGFloat height4 = 15 * height1;
    
    
    // Check the height
    XCTAssertEqualWithAccuracy(((MWChartBar *)chart.bars[0]).size.height, height0, EPSILON);
    XCTAssertEqualWithAccuracy(((MWChartBar *)chart.bars[1]).size.height, height1, EPSILON);
    XCTAssertEqualWithAccuracy(((MWChartBar *)chart.bars[2]).size.height, height2, EPSILON);
    XCTAssertEqualWithAccuracy(((MWChartBar *)chart.bars[3]).size.height, height3, EPSILON);
    XCTAssertEqualWithAccuracy(((MWChartBar *)chart.bars[4]).size.height, height4, EPSILON);
    
    NSInteger positiveRange = 75 + (barLabelPadding + paddingPositive);
    CGFloat positiveHeight = (positiveRange / (CGFloat)valueRange) * chart.height;
    
    // Check the position
    XCTAssertEqualWithAccuracy(((MWChartBar *)chart.bars[0]).position.y, positiveHeight - height0, EPSILON);
    XCTAssertEqualWithAccuracy(((MWChartBar *)chart.bars[1]).position.y, positiveHeight - height1, EPSILON);
    XCTAssertEqualWithAccuracy(((MWChartBar *)chart.bars[2]).position.y, positiveHeight + chart.zeroLineHeight, EPSILON);
    XCTAssertEqualWithAccuracy(((MWChartBar *)chart.bars[3]).position.y, positiveHeight + chart.zeroLineHeight, EPSILON);
    XCTAssertEqualWithAccuracy(((MWChartBar *)chart.bars[4]).position.y, positiveHeight - height4, EPSILON);
}

- (void)testPaddingPositive
{
    NSArray *dataArray = @[[MWData createDataWithValue:0],
                           [MWData createDataWithValue:10],
                           [MWData createDataWithValue:75]];
    MWDataContainer *dataContainer = [[MWDataContainer alloc] initWithDataArray:dataArray];
    MWChart *chart = [[MWChart alloc] initWithDataContainer:dataContainer height:100];
    [chart createChart];
    
    NSInteger barLabelHeight = 18;
    NSInteger positiveMax = 75 + barLabelHeight;
    
    XCTAssertEqualWithAccuracy(chart.positivePadding, chart.markerLineInterval - positiveMax % chart.markerLineInterval, FLT_EPSILON);
    XCTAssertEqualWithAccuracy(chart.negativePadding, 0, FLT_EPSILON);
}

- (void)testPaddingNegative
{
    NSArray *dataArray = @[[MWData createDataWithValue:0],
                           [MWData createDataWithValue:-10],
                           [MWData createDataWithValue:-17],
                           [MWData createDataWithValue:-72]];
    MWDataContainer *dataContainer = [[MWDataContainer alloc] initWithDataArray:dataArray];
    MWChart *chart = [[MWChart alloc] initWithDataContainer:dataContainer height:100];
    [chart createChart];
    
    NSInteger barLabelHeight = 17;
    NSInteger negativeMax = 72 + barLabelHeight;
    
    XCTAssertEqualWithAccuracy(chart.positivePadding, 0, FLT_EPSILON);
    XCTAssertEqualWithAccuracy(chart.negativePadding, chart.markerLineInterval - negativeMax % chart.markerLineInterval, FLT_EPSILON);
}

- (void)testPaddingMixed
{
    NSArray *dataArray = @[[MWData createDataWithValue:0],
                           [MWData createDataWithValue:-10],
                           [MWData createDataWithValue:-17],
                           [MWData createDataWithValue:17],
                           [MWData createDataWithValue:28],
                           [MWData createDataWithValue:-73]];
    MWDataContainer *dataContainer = [[MWDataContainer alloc] initWithDataArray:dataArray];
    MWChart *chart = [[MWChart alloc] initWithDataContainer:dataContainer height:100];
    [chart createChart];
    
    NSInteger barLabelHeight = 24;
    NSInteger positiveMax = 28 + barLabelHeight;
    NSInteger negativeMax = 73 + barLabelHeight;
    
    NSInteger positivePadding = chart.markerLineInterval - positiveMax % chart.markerLineInterval;
    NSInteger negativePadding = chart.markerLineInterval - negativeMax % chart.markerLineInterval;
    
    XCTAssertEqualWithAccuracy(chart.positivePadding, positivePadding, FLT_EPSILON);
    XCTAssertEqualWithAccuracy(chart.negativePadding, negativePadding, FLT_EPSILON);
}

- (void)testMarkerLineCountPositive
{
    NSArray *dataArray = @[[MWData createDataWithValue:0],
                           [MWData createDataWithValue:10],
                           [MWData createDataWithValue:17],
                           [MWData createDataWithValue:72]];
    MWDataContainer *dataContainer = [[MWDataContainer alloc] initWithDataArray:dataArray];
    MWChart *chart = [[MWChart alloc] initWithDataContainer:dataContainer height:100];
    [chart createChart];
    
    NSInteger barLabelHeight = 15;
    NSInteger height = 72 + barLabelHeight + 3;
    
    XCTAssertEqual([chart.markerLines count], height / chart.markerLineInterval);
}

- (void)testMarkerLineCountNegative
{
    NSArray *dataArray = @[[MWData createDataWithValue:0],
                           [MWData createDataWithValue:-10],
                           [MWData createDataWithValue:-17],
                           [MWData createDataWithValue:-59]];
    MWDataContainer *dataContainer = [[MWDataContainer alloc] initWithDataArray:dataArray];
    MWChart *chart = [[MWChart alloc] initWithDataContainer:dataContainer height:100];
    [chart createChart];
    
    NSInteger barLabelHeight = 12;
    NSInteger height = 59 + barLabelHeight + 9;
    
    XCTAssertEqual([chart.markerLines count], height / chart.markerLineInterval);
}

- (void)testMarkerLineCountMixed
{
    NSArray *dataArray = @[[MWData createDataWithValue:0],
                           [MWData createDataWithValue:10],
                           [MWData createDataWithValue:17],
                           [MWData createDataWithValue:-23],
                           [MWData createDataWithValue:72]];
    MWDataContainer *dataContainer = [[MWDataContainer alloc] initWithDataArray:dataArray];
    MWChart *chart = [[MWChart alloc] initWithDataContainer:dataContainer height:100];
    [chart createChart];
    
    NSInteger barLabelHeight = 20;
    NSInteger height = 72 + barLabelHeight + 8 + 23 + barLabelHeight + 7;
    
    XCTAssertEqual([chart.markerLines count], height / chart.markerLineInterval);
}

@end
