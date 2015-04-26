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
    NSArray *array = @[[MWData createDataWithValue:0],
                       [MWData createDataWithValue:-10],
                       [MWData createDataWithValue:20],
                       [MWData createDataWithValue:34],
                       [MWData createDataWithValue:-11],
                       [MWData createDataWithValue:-23],
                       [MWData createDataWithValue:98],
                       [MWData createDataWithValue:1]];
    MWDataContainer *dataContainer = [[MWDataContainer alloc] initWithDataArray:array];
    
    XCTAssertEqual(dataContainer.minValue, -23, @"DataContainer minValue is wrong");
}

- (void)testMinValuePositive
{
    NSArray *array = @[[MWData createDataWithValue:5],
                       [MWData createDataWithValue:10],
                       [MWData createDataWithValue:20],
                       [MWData createDataWithValue:34],
                       [MWData createDataWithValue:11],
                       [MWData createDataWithValue:23],
                       [MWData createDataWithValue:98],
                       [MWData createDataWithValue:1]];
    MWDataContainer *dataContainer = [[MWDataContainer alloc] initWithDataArray:array];
    
    XCTAssertEqual(dataContainer.minValue, 1, @"DataContainer minValue is wrong");
}

- (void)testMinValueNegative
{
    NSArray *array = @[[MWData createDataWithValue:-5],
                       [MWData createDataWithValue:-10],
                       [MWData createDataWithValue:-20],
                       [MWData createDataWithValue:-34],
                       [MWData createDataWithValue:-11],
                       [MWData createDataWithValue:-23],
                       [MWData createDataWithValue:-98],
                       [MWData createDataWithValue:-1]];
    MWDataContainer *dataContainer = [[MWDataContainer alloc] initWithDataArray:array];
    
    XCTAssertEqual(dataContainer.minValue, -98, @"DataContainer minValue is wrong");
}

//
// Max value
//

- (void)testMaxValueMixed
{
    NSArray *array = @[[MWData createDataWithValue:0],
                       [MWData createDataWithValue:-10],
                       [MWData createDataWithValue:20],
                       [MWData createDataWithValue:34],
                       [MWData createDataWithValue:-11],
                       [MWData createDataWithValue:-23],
                       [MWData createDataWithValue:98],
                       [MWData createDataWithValue:1]];
    MWDataContainer *dataContainer = [[MWDataContainer alloc] initWithDataArray:array];
    
    XCTAssertEqual(dataContainer.maxValue, 98, @"DataContainer maxValue is wrong");
}

- (void)testMaxValuePositive
{
    NSArray *array = @[[MWData createDataWithValue:5],
                       [MWData createDataWithValue:10],
                       [MWData createDataWithValue:20],
                       [MWData createDataWithValue:34],
                       [MWData createDataWithValue:11],
                       [MWData createDataWithValue:23],
                       [MWData createDataWithValue:98],
                       [MWData createDataWithValue:1]];
    MWDataContainer *dataContainer = [[MWDataContainer alloc] initWithDataArray:array];
    
    XCTAssertEqual(dataContainer.maxValue, 98, @"DataContainer maxValue is wrong");
}

- (void)testMaxValueNegative
{
    NSArray *array = @[[MWData createDataWithValue:-5],
                       [MWData createDataWithValue:-10],
                       [MWData createDataWithValue:-20],
                       [MWData createDataWithValue:-34],
                       [MWData createDataWithValue:-11],
                       [MWData createDataWithValue:-23],
                       [MWData createDataWithValue:-98],
                       [MWData createDataWithValue:-1]];
    MWDataContainer *dataContainer = [[MWDataContainer alloc] initWithDataArray:array];
    
    // This will be zero, because goal lines are always positive and the default goal is 0
    XCTAssertEqual(dataContainer.maxValue, 0, @"DataContainer maxValue is wrong");
}

//
// Range
//

- (void)testRangeMixed
{
    NSArray *array = @[[MWData createDataWithValue:0],
                       [MWData createDataWithValue:-10],
                       [MWData createDataWithValue:20],
                       [MWData createDataWithValue:34],
                       [MWData createDataWithValue:-11],
                       [MWData createDataWithValue:-23],
                       [MWData createDataWithValue:98],
                       [MWData createDataWithValue:1]];
    MWDataContainer *dataContainer = [[MWDataContainer alloc] initWithDataArray:array];
    
    XCTAssertEqual(dataContainer.valueRange, 121, @"DataContainer valueRange is wrong");
}

- (void)testRangePositive
{
    NSArray *array = @[[MWData createDataWithValue:5],
                       [MWData createDataWithValue:10],
                       [MWData createDataWithValue:20],
                       [MWData createDataWithValue:34],
                       [MWData createDataWithValue:11],
                       [MWData createDataWithValue:23],
                       [MWData createDataWithValue:98],
                       [MWData createDataWithValue:1]];
    MWDataContainer *dataContainer = [[MWDataContainer alloc] initWithDataArray:array];
    
    XCTAssertEqual(dataContainer.valueRange, 98, @"DataContainer valueRange is wrong");
}

- (void)testRangeNegative
{
    NSArray *array = @[[MWData createDataWithValue:-5],
                       [MWData createDataWithValue:-10],
                       [MWData createDataWithValue:-20],
                       [MWData createDataWithValue:-34],
                       [MWData createDataWithValue:-11],
                       [MWData createDataWithValue:-23],
                       [MWData createDataWithValue:-98],
                       [MWData createDataWithValue:-1]];
    MWDataContainer *dataContainer = [[MWDataContainer alloc] initWithDataArray:array];
    
    XCTAssertEqual(dataContainer.valueRange, 98);
}

//
// Convenience methods
//

- (void)testDataCount
{
    NSArray *array = @[[MWData createDataWithValue:-5],
                       [MWData createDataWithValue:-10],
                       [MWData createDataWithValue:-20],
                       [MWData createDataWithValue:-34],
                       [MWData createDataWithValue:-11],
                       [MWData createDataWithValue:-23],
                       [MWData createDataWithValue:-98],
                       [MWData createDataWithValue:-1]];
    MWDataContainer *dataContainer = [[MWDataContainer alloc] initWithDataArray:array];
    
    XCTAssertEqual(dataContainer.dataCount, 8);
}

@end
