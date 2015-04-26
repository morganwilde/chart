//
//  ViewController.m
//  Chart
//
//  Created by Morgan Wilde on 19/04/2015.
//  Copyright (c) 2015 Morgan Wilde. All rights reserved.
//

#import "ViewController.h"
#import "MWChartView.h"
#import "MWChartContainerView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSDateComponents *dateComponentNow = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:[NSDate date]];
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    [dateComponents setYear:dateComponentNow.year];
    [dateComponents setMonth:dateComponentNow.month];
    [dateComponents setDay:1];
    NSDate *date = [[NSCalendar currentCalendar] dateFromComponents:dateComponents];
    NSTimeInterval day = 60 * 60 * 24;
    
    NSArray *dataArray = @[[MWData dataWithValue:10 goal:80 date:[date dateByAddingTimeInterval:0*day]],
                           [MWData dataWithValue:20 goal:80 date:[date dateByAddingTimeInterval:1*day]],
                           [MWData dataWithValue:30 goal:60 date:[date dateByAddingTimeInterval:2*day]],
                           [MWData dataWithValue:40 goal:60 date:[date dateByAddingTimeInterval:3*day]],
                           [MWData dataWithValue:40 goal:60 date:[date dateByAddingTimeInterval:4*day]],
                           [MWData dataWithValue:40 goal:60 date:[date dateByAddingTimeInterval:5*day]],];
    
    
    // Creates the view and puts it on the screen
    MWDataContainer *dataContainer = [[MWDataContainer alloc] initWithDataArray:dataArray];
    MWChart *chart = [[MWChart alloc] initWithDataContainer: dataContainer height:CHART_HEIGHT dateComponents:dateComponentNow];
    [chart createChart];
    
    CGPoint chartPosition = CGPointMake(0, self.view.frame.size.height/2 - chart.height/2);
    
//    MWChartView *chartView = [[MWChartView alloc] initWithPosition:chartPosition chart:chart];
    MWChartContainerView *chartView = [[MWChartContainerView alloc] initWithPosition:chartPosition chart:chart];
    
    [self.view addSubview:chartView];
}

- (NSArray *)createDataArrayFromNumberArray:(NSArray *)array
{
    NSMutableArray *dataArray = [NSMutableArray array];
    
    for (NSNumber *number in array) {
        [dataArray addObject:[MWData createDataWithValue:[number integerValue]]];
    }
    
    return dataArray;
}

@end
