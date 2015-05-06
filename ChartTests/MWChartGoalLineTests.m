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
    NSArray *dataArray = @[[MWData dataWithValue:0 goal:10 date:nil],
                           [MWData dataWithValue:-9 goal:10 date:nil],
                           [MWData dataWithValue:9 goal:50 date:nil],
                           [MWData dataWithValue:0 goal:10 date:nil]];
    MWDataContainer *dataContainer = [[MWDataContainer alloc] initWithDataArray:dataArray];
    MWChart *chart = [[MWChart alloc] initWithDataContainer:dataContainer height:100 dateComponents:nil];
    
    MWChartGoalLine *goalLine1 = [[MWChartGoalLine alloc] initWithGoal:10 chart:chart barRange:NSMakeRange(0, 1)];
    MWChartGoalLine *goalLine2 = [[MWChartGoalLine alloc] initWithGoal:50 chart:chart barRange:NSMakeRange(2, 0)];
    MWChartGoalLine *goalLine3 = [[MWChartGoalLine alloc] initWithGoal:10 chart:chart barRange:NSMakeRange(3, 0)];
    
    XCTAssertEqual(goalLine1.from, 0);
    XCTAssertEqual(goalLine1.to, 1);
    
    XCTAssertEqual(goalLine2.from, 2);
    XCTAssertEqual(goalLine2.to, 2);
    
    XCTAssertEqual(goalLine3.from, 3);
    XCTAssertEqual(goalLine3.to, 3);
}


@end
