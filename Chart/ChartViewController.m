//
//  ViewController.m
//  Chart
//
//  Created by Morgan Wilde on 19/04/2015.
//  Copyright (c) 2015 Morgan Wilde. All rights reserved.
//

#import "ChartViewController.h"
#import "MWChartView.h"
#import "MWChartContainerView.h"

#import "MWConstants.h"

@interface ChartViewController ()

@property (nonatomic) MWChartContainerView *chartContainerView;
@property (nonatomic) MWChartContainerView *chartContainerView2;

@end

@implementation ChartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSDateComponents *dateComponentNow = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:[NSDate date]];
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    [dateComponents setYear:dateComponentNow.year];
    [dateComponents setMonth:dateComponentNow.month];
    [dateComponents setDay:1];
    
    NSDateComponents *dateComponentsNext = [dateComponentNow copy];
    [dateComponentsNext setMonth:dateComponentNow.month + 1];
    
    NSDate *date = [[NSCalendar currentCalendar] dateFromComponents:dateComponents];
    NSTimeInterval day = 60 * 60 * 24;
    
    NSArray *dataArray = @[[MWData dataWithValue:10 goal:20 date:[date dateByAddingTimeInterval:0*day]],
                           [MWData dataWithValue:20 goal:30 date:[date dateByAddingTimeInterval:1*day]],
                           [MWData dataWithValue:30 goal:20 date:[date dateByAddingTimeInterval:2*day]],
                           [MWData dataWithValue:-40 goal:20 date:[date dateByAddingTimeInterval:3*day]],
                           [MWData dataWithValue:40 goal:70 date:[date dateByAddingTimeInterval:4*day]],
                           [MWData dataWithValue:40 goal:70 date:[date dateByAddingTimeInterval:5*day]],
                           [MWData dataWithValue:108 goal:60 date:[date dateByAddingTimeInterval:6*day]],
                           [MWData dataWithValue:10 goal:60 date:[date dateByAddingTimeInterval:7*day]],
                           [MWData dataWithValue:30 goal:60 date:[date dateByAddingTimeInterval:8*day]],
                           [MWData dataWithValue:40 goal:60 date:[date dateByAddingTimeInterval:9*day]],
                           [MWData dataWithValue:40 goal:60 date:[date dateByAddingTimeInterval:10*day]],
                           [MWData dataWithValue:20 goal:30 date:[date dateByAddingTimeInterval:11*day]],
                           [MWData dataWithValue:20 goal:30 date:[date dateByAddingTimeInterval:12*day]],
                           [MWData dataWithValue:20 goal:30 date:[date dateByAddingTimeInterval:13*day]],
                           [MWData dataWithValue:50 goal:80 date:[date dateByAddingTimeInterval:14*day]],
                           [MWData dataWithValue:50 goal:80 date:[date dateByAddingTimeInterval:15*day]],
                           [MWData dataWithValue:50 goal:80 date:[date dateByAddingTimeInterval:16*day]],
                           [MWData dataWithValue:50 goal:80 date:[date dateByAddingTimeInterval:17*day]],
                           [MWData dataWithValue:50 goal:80 date:[date dateByAddingTimeInterval:18*day]],
                           [MWData dataWithValue:50 goal:80 date:[date dateByAddingTimeInterval:19*day]],
                           [MWData dataWithValue:50 goal:80 date:[date dateByAddingTimeInterval:20*day]],
                           [MWData dataWithValue:50 goal:80 date:[date dateByAddingTimeInterval:21*day]],
                           [MWData dataWithValue:50 goal:80 date:[date dateByAddingTimeInterval:22*day]],
                           [MWData dataWithValue:50 goal:80 date:[date dateByAddingTimeInterval:23*day]],
                           [MWData dataWithValue:50 goal:80 date:[date dateByAddingTimeInterval:24*day]],
                           [MWData dataWithValue:50 goal:80 date:[date dateByAddingTimeInterval:25*day]],
                           [MWData dataWithValue:50 goal:60 date:[date dateByAddingTimeInterval:26*day]],
                           [MWData dataWithValue:50 goal:60 date:[date dateByAddingTimeInterval:27*day]],
                           [MWData dataWithValue:10 goal:80 date:[date dateByAddingTimeInterval:28*day]],
                           [MWData dataWithValue:00 goal:80 date:[date dateByAddingTimeInterval:29*day]],];
    
    
    // Creates the view and puts it on the screen
    MWDataContainer *dataContainer = [[MWDataContainer alloc] initWithDataArray:dataArray];
    MWChart *chart = [[MWChart alloc] initWithDataContainer:dataContainer
                                                     height:[MWConstants chartHeight]
                                             dateComponents:dateComponentNow];
    [chart createChart];
    MWChart *chart2 = [[MWChart alloc] initWithDataContainer:dataContainer
                                                      height:[MWConstants chartHeight]
                                              dateComponents:dateComponentsNext];
    [chart2 createChart];
    
    CGPoint chartPosition = CGPointMake(0, 0);
    self.chartContainerView = [[MWChartContainerView alloc] initWithPosition:chartPosition chart:chart];
    
    CGPoint chart2Position = CGPointMake(self.chartContainerView.frame.origin.x + self.chartContainerView.frame.size.width, 0);
    
    self.chartContainerView2 = [[MWChartContainerView alloc] initWithPosition:chart2Position chart:chart2];
    
    
    CGRect scrollViewFrame = CGRectMake(0,
                                        self.view.frame.origin.y + self.view.frame.size.height/2 - self.chartContainerView.frame.size.height/2,
                                        self.view.frame.size.width,
                                        self.chartContainerView.frame.size.height);
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:scrollViewFrame];
    scrollView.delegate = self;
    scrollView.contentSize = CGSizeMake(self.chartContainerView.frame.size.width * 2, self.chartContainerView.frame.size.height);
    scrollView.backgroundColor = [MWConstants chartBackgroundColor];
    
    [scrollView addSubview:self.chartContainerView];
    [scrollView addSubview:self.chartContainerView2];
    
    [self.view addSubview:scrollView];
}

# pragma mark - ScrollView delegate methods

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    self.chartContainerView.visibleFromX = scrollView.contentOffset.x;
    self.chartContainerView2.visibleFromX = scrollView.contentOffset.x;
}

@end
