//
//  MWChartGoalLineTests.m
//  Chart
//
//  Created by Morgan Wilde on 22/04/2015.
//  Copyright (c) 2015 Morgan Wilde. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "MWChartGoalLine.h"
#import "MWData.h"
#import "MWDataContainer.h"
#import "MWChart.h"

@interface MWChartGoalLineTests : XCTestCase

@end

@implementation MWChartGoalLineTests

- (void)testInitialiser
{
    NSArray *dataArray = @[[MWData dataWithValue:0 goal:10],
                           [MWData dataWithValue:-9 goal:10],
                           [MWData dataWithValue:9 goal:50],
                           [MWData dataWithValue:0 goal:10],];
    MWDataContainer *dataContainer = [[MWDataContainer alloc] initWithDataArray:dataArray];
    MWChart *chart = [[MWChart alloc] initWithDataContainer: dataContainer height:100];
    
    MWChartGoalLine *goalLine1 = [[MWChartGoalLine alloc] initWithGoal:10 chart:chart barRange:NSMakeRange(0, 2)];
    MWChartGoalLine *goalLine2 = [[MWChartGoalLine alloc] initWithGoal:50 chart:chart barRange:NSMakeRange(2, 1)];
    MWChartGoalLine *goalLine3 = [[MWChartGoalLine alloc] initWithGoal:10 chart:chart barRange:NSMakeRange(3, 1)];
    
    XCTAssertEqual(goalLine1.from, 0);
    XCTAssertEqual(goalLine1.to, 1);
    
    XCTAssertEqual(goalLine2.from, 2);
    XCTAssertEqual(goalLine2.to, 2);
    
    XCTAssertEqual(goalLine3.from, 3);
    XCTAssertEqual(goalLine3.to, 3);
}

- (void)testGoalInitialiser
{
    NSArray *dataArray = @[[MWData dataWithValue:0 goal:10],
                           [MWData dataWithValue:0 goal:10],
                           [MWData dataWithValue:0 goal:20],
                           [MWData dataWithValue:0 goal:20],
                           [MWData dataWithValue:0 goal:30]];
    MWDataContainer *dataContainer = [[MWDataContainer alloc] initWithDataArray:dataArray];
    MWChart *chart = [[MWChart alloc] initWithDataContainer:dataContainer height:100];
    [chart createChart];
    
    // Goal line count
    XCTAssertEqual([chart.goalLines count], 3);
    
    // Goal line values
    MWChartGoalLine *goalLine1 = chart.goalLines[0];
    MWChartGoalLine *goalLine2 = chart.goalLines[1];
    MWChartGoalLine *goalLine3 = chart.goalLines[2];
    
    XCTAssertEqual(goalLine1.goal, 10);
    XCTAssertEqual(goalLine2.goal, 20);
    XCTAssertEqual(goalLine3.goal, 30);
}

- (void)testGoalInitialiserSingleGoal
{
    NSArray *dataArray = @[[MWData dataWithValue:0 goal:10],
                           [MWData dataWithValue:0 goal:10],
                           [MWData dataWithValue:0 goal:10],
                           [MWData dataWithValue:0 goal:10],
                           [MWData dataWithValue:0 goal:10]];
    MWDataContainer *dataContainer = [[MWDataContainer alloc] initWithDataArray:dataArray];
    MWChart *chart = [[MWChart alloc] initWithDataContainer:dataContainer height:100];
    [chart createChart];
    
    // Goal line count
    XCTAssertEqual([chart.goalLines count], 1);
    
    // Goal line values
    MWChartGoalLine *goalLine1 = chart.goalLines[0];
    
    XCTAssertEqual(goalLine1.goal, 10);
}

- (void)testGoalBarRangesSingleGoal
{
    NSArray *dataArray = @[[MWData dataWithValue:0 goal:10],];
    MWDataContainer *dataContainer = [[MWDataContainer alloc] initWithDataArray:dataArray];
    MWChart *chart = [[MWChart alloc] initWithDataContainer:dataContainer height:100];
    [chart createChart];
    
    MWChartGoalLine *goalLine = chart.goalLines[0];
    
    XCTAssertEqual(goalLine.from, 0);
    XCTAssertEqual(goalLine.to, 0);
}

- (void)testGoalBarRangesMultipleEqualGoals
{
    NSArray *dataArray = @[[MWData dataWithValue:0 goal:10],
                           [MWData dataWithValue:0 goal:10],
                           [MWData dataWithValue:0 goal:10],
                           [MWData dataWithValue:0 goal:10],];
    MWDataContainer *dataContainer = [[MWDataContainer alloc] initWithDataArray:dataArray];
    MWChart *chart = [[MWChart alloc] initWithDataContainer:dataContainer height:100];
    [chart createChart];
    
    MWChartGoalLine *goalLine = chart.goalLines[0];
    
    XCTAssertEqual(goalLine.from, 0);
    XCTAssertEqual(goalLine.to, 3);
}

- (void)testGoalBarRangesMultipleGoals
{
    NSArray *dataArray = @[[MWData dataWithValue:0 goal:10],
                           [MWData dataWithValue:0 goal:20],
                           [MWData dataWithValue:0 goal:10],
                           [MWData dataWithValue:0 goal:10],];
    MWDataContainer *dataContainer = [[MWDataContainer alloc] initWithDataArray:dataArray];
    MWChart *chart = [[MWChart alloc] initWithDataContainer:dataContainer height:100];
    [chart createChart];
    
    XCTAssertEqual([chart.goalLines count], 3);
    
    MWChartGoalLine *goalLine1 = chart.goalLines[0];
    MWChartGoalLine *goalLine2 = chart.goalLines[1];
    MWChartGoalLine *goalLine3 = chart.goalLines[2];
    
    XCTAssertEqual(goalLine1.from, 0);
    XCTAssertEqual(goalLine1.to, 0);
    
    XCTAssertEqual(goalLine2.from, 1);
    XCTAssertEqual(goalLine2.to, 1);
    
    XCTAssertEqual(goalLine3.from, 2);
    XCTAssertEqual(goalLine3.to, 3);
}

@end
