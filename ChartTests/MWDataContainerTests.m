//
//  MWDataContainerTests.m
//  Chart
//
//  Created by Morgan Wilde on 19/04/2015.
//  Copyright (c) 2015 Morgan Wilde. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "MWData.h"
#import "MWDataContainer.h"

@interface MWDataContainerTests : XCTestCase

@end

@implementation MWDataContainerTests

//
// Min value
//

- (void)testMinValueMixed
{
    NSArray *array = @[[MWData dataWithValue:0 goal:0 date:nil],
                       [MWData dataWithValue:-10 goal:0 date:nil],
                       [MWData dataWithValue:20 goal:0 date:nil],
                       [MWData dataWithValue:34 goal:0 date:nil],
                       [MWData dataWithValue:-11 goal:0 date:nil],
                       [MWData dataWithValue:-23 goal:0 date:nil],
                       [MWData dataWithValue:98 goal:0 date:nil],
                       [MWData dataWithValue:1 goal:0 date:nil]];
    MWDataContainer *dataContainer = [[MWDataContainer alloc] initWithDataArray:array];
    
    XCTAssertEqual(dataContainer.minValue, -23, @"DataContainer minValue is wrong");
}

- (void)testMinValuePositive
{
    NSArray *array = @[[MWData dataWithValue:5 goal:0 date:nil],
                       [MWData dataWithValue:10 goal:0 date:nil],
                       [MWData dataWithValue:20 goal:0 date:nil],
                       [MWData dataWithValue:34 goal:0 date:nil],
                       [MWData dataWithValue:11 goal:0 date:nil],
                       [MWData dataWithValue:23 goal:0 date:nil],
                       [MWData dataWithValue:98 goal:0 date:nil],
                       [MWData dataWithValue:1 goal:0 date:nil]];
    MWDataContainer *dataContainer = [[MWDataContainer alloc] initWithDataArray:array];
    
    XCTAssertEqual(dataContainer.minValue, 1, @"DataContainer minValue is wrong");
}

- (void)testMinValueNegative
{
    NSArray *array = @[[MWData dataWithValue:-5 goal:0 date:nil],
                       [MWData dataWithValue:-10 goal:0 date:nil],
                       [MWData dataWithValue:-20 goal:0 date:nil],
                       [MWData dataWithValue:-34 goal:0 date:nil],
                       [MWData dataWithValue:-11 goal:0 date:nil],
                       [MWData dataWithValue:-23 goal:0 date:nil],
                       [MWData dataWithValue:-98 goal:0 date:nil],
                       [MWData dataWithValue:-1 goal:0 date:nil]];
    MWDataContainer *dataContainer = [[MWDataContainer alloc] initWithDataArray:array];
    
    XCTAssertEqual(dataContainer.minValue, -98, @"DataContainer minValue is wrong");
}

//
// Max value
//

- (void)testMaxValueMixed
{
    NSArray *array = @[[MWData dataWithValue:0 goal:0 date:nil],
                       [MWData dataWithValue:-10 goal:0 date:nil],
                       [MWData dataWithValue:20 goal:0 date:nil],
                       [MWData dataWithValue:34 goal:0 date:nil],
                       [MWData dataWithValue:-11 goal:0 date:nil],
                       [MWData dataWithValue:-23 goal:0 date:nil],
                       [MWData dataWithValue:98 goal:0 date:nil],
                       [MWData dataWithValue:1 goal:0 date:nil]];
    MWDataContainer *dataContainer = [[MWDataContainer alloc] initWithDataArray:array];
    
    XCTAssertEqual(dataContainer.maxValue, 98, @"DataContainer maxValue is wrong");
}

- (void)testMaxValuePositive
{
    NSArray *array = @[[MWData dataWithValue:5 goal:0 date:nil],
                       [MWData dataWithValue:10 goal:0 date:nil],
                       [MWData dataWithValue:20 goal:0 date:nil],
                       [MWData dataWithValue:34 goal:0 date:nil],
                       [MWData dataWithValue:11 goal:0 date:nil],
                       [MWData dataWithValue:23 goal:0 date:nil],
                       [MWData dataWithValue:98 goal:0 date:nil],
                       [MWData dataWithValue:1 goal:0 date:nil]];
    MWDataContainer *dataContainer = [[MWDataContainer alloc] initWithDataArray:array];
    
    XCTAssertEqual(dataContainer.maxValue, 98, @"DataContainer maxValue is wrong");
}

- (void)testMaxValueNegative
{
    NSArray *array = @[[MWData dataWithValue:-5 goal:0 date:nil],
                       [MWData dataWithValue:-10 goal:0 date:nil],
                       [MWData dataWithValue:-20 goal:0 date:nil],
                       [MWData dataWithValue:-34 goal:0 date:nil],
                       [MWData dataWithValue:-11 goal:0 date:nil],
                       [MWData dataWithValue:-23 goal:0 date:nil],
                       [MWData dataWithValue:-98 goal:0 date:nil],
                       [MWData dataWithValue:-1 goal:0 date:nil]];
    MWDataContainer *dataContainer = [[MWDataContainer alloc] initWithDataArray:array];
    
    // This will be zero, because goal lines are always positive and the default goal is 0
    XCTAssertEqual(dataContainer.maxValue, 0, @"DataContainer maxValue is wrong");
}

//
// Range
//

- (void)testRangeMixed
{
    NSArray *array = @[[MWData dataWithValue:0 goal:0 date:nil],
                       [MWData dataWithValue:-10 goal:0 date:nil],
                       [MWData dataWithValue:20 goal:0 date:nil],
                       [MWData dataWithValue:34 goal:0 date:nil],
                       [MWData dataWithValue:-11 goal:0 date:nil],
                       [MWData dataWithValue:-23 goal:0 date:nil],
                       [MWData dataWithValue:98 goal:0 date:nil],
                       [MWData dataWithValue:1 goal:0 date:nil]];
    MWDataContainer *dataContainer = [[MWDataContainer alloc] initWithDataArray:array];
    
    XCTAssertEqual(dataContainer.valueRange, 121, @"DataContainer valueRange is wrong");
}

- (void)testRangePositive
{
    NSArray *array = @[[MWData dataWithValue:5 goal:0 date:nil],
                       [MWData dataWithValue:10 goal:0 date:nil],
                       [MWData dataWithValue:20 goal:0 date:nil],
                       [MWData dataWithValue:34 goal:0 date:nil],
                       [MWData dataWithValue:11 goal:0 date:nil],
                       [MWData dataWithValue:23 goal:0 date:nil],
                       [MWData dataWithValue:98 goal:0 date:nil],
                       [MWData dataWithValue:1 goal:0 date:nil]];
    MWDataContainer *dataContainer = [[MWDataContainer alloc] initWithDataArray:array];
    
    XCTAssertEqual(dataContainer.valueRange, 98, @"DataContainer valueRange is wrong");
}

- (void)testRangeNegative
{
    NSArray *array = @[[MWData dataWithValue:-5 goal:0 date:nil],
                       [MWData dataWithValue:-10 goal:0 date:nil],
                       [MWData dataWithValue:-20 goal:0 date:nil],
                       [MWData dataWithValue:-34 goal:0 date:nil],
                       [MWData dataWithValue:-11 goal:0 date:nil],
                       [MWData dataWithValue:-23 goal:0 date:nil],
                       [MWData dataWithValue:-98 goal:0 date:nil],
                       [MWData dataWithValue:-1 goal:0 date:nil]];
    MWDataContainer *dataContainer = [[MWDataContainer alloc] initWithDataArray:array];
    
    XCTAssertEqual(dataContainer.valueRange, 98);
}

//
// Convenience methods
//

- (void)testDataCount
{
    NSArray *array = @[[MWData dataWithValue:-5 goal:0 date:nil],
                       [MWData dataWithValue:-10 goal:0 date:nil],
                       [MWData dataWithValue:-20 goal:0 date:nil],
                       [MWData dataWithValue:-34 goal:0 date:nil],
                       [MWData dataWithValue:-11 goal:0 date:nil],
                       [MWData dataWithValue:-23 goal:0 date:nil],
                       [MWData dataWithValue:-98 goal:0 date:nil],
                       [MWData dataWithValue:-1 goal:0 date:nil]];
    MWDataContainer *dataContainer = [[MWDataContainer alloc] initWithDataArray:array];
    
    XCTAssertEqual(dataContainer.dataCount, 8);
}

@end
