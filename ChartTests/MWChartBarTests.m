//
//  MWChartBarTests.m
//  Chart
//
//  Created by Morgan Wilde on 19/04/2015.
//  Copyright (c) 2015 Morgan Wilde. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "MWChartBar.h"

@interface MWChartBarTests : XCTestCase

@end

@implementation MWChartBarTests

- (void)testInitialiser
{
    MWChartBar *chartBar = [[MWChartBar alloc] initWithSize:CGSizeMake(100, 101)
                                                   position:CGPointMake(10, 12)
                                                   positive:YES
                                                      title:@"0"];
    
    XCTAssertEqual(chartBar.size.width, CGSizeMake(100, 101).width);
    XCTAssertEqual(chartBar.size.height, CGSizeMake(100, 101).height);
    XCTAssertEqual(chartBar.position.x, CGPointMake(10, 12).x);
    XCTAssertEqual(chartBar.position.y, CGPointMake(10, 12).y);
}

- (void)testLabelHeight
{
    CGFloat labelHeight = [MWChartBar labelHeight];
    CGFloat chartHeight = 100;
    CGFloat relativeHeight = labelHeight / chartHeight;
    
    XCTAssertEqualWithAccuracy(relativeHeight, 0.212, 0.001);
    
    NSInteger chartValueRange = 100;
    NSInteger labelValueEquivalent = round(chartValueRange * relativeHeight);
    
    XCTAssertEqual(labelValueEquivalent, 21);
}

@end
