//
//  MWDataTests.m
//  Chart
//
//  Created by Morgan Wilde on 19/04/2015.
//  Copyright (c) 2015 Morgan Wilde. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "MWData.h"

@interface MWDataTests : XCTestCase

@end

@implementation MWDataTests

- (void)testInitialiser {
    MWData *data0 = [[MWData alloc] initWithValue:0];
    MWData *data1 = [[MWData alloc] initWithValue:-1];
    MWData *data2 = [[MWData alloc] initWithValue:1];
    
    XCTAssertEqual(data0.value, 0, @"data value not equal");
    XCTAssertEqual(data1.value, -1, @"data value not equal");
    XCTAssertEqual(data2.value, 1, @"data value not equal");
}

@end
