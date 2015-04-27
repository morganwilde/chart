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

@property (nonatomic) MWChartContainerView *chartContainerView;

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
                           [MWData dataWithValue:0 goal:60 date:[date dateByAddingTimeInterval:5*day]],
                           [MWData dataWithValue:0 goal:60 date:[date dateByAddingTimeInterval:6*day]],
                           [MWData dataWithValue:10 goal:60 date:[date dateByAddingTimeInterval:7*day]],
                           [MWData dataWithValue:30 goal:60 date:[date dateByAddingTimeInterval:8*day]],
                           [MWData dataWithValue:40 goal:60 date:[date dateByAddingTimeInterval:9*day]],
                           [MWData dataWithValue:40 goal:60 date:[date dateByAddingTimeInterval:10*day]],
                           [MWData dataWithValue:20 goal:30 date:[date dateByAddingTimeInterval:11*day]],
                           [MWData dataWithValue:20 goal:30 date:[date dateByAddingTimeInterval:12*day]],
                           [MWData dataWithValue:20 goal:30 date:[date dateByAddingTimeInterval:13*day]],
                           [MWData dataWithValue:50 goal:20 date:[date dateByAddingTimeInterval:14*day]],];
    
    
    // Creates the view and puts it on the screen
    MWDataContainer *dataContainer = [[MWDataContainer alloc] initWithDataArray:dataArray];
    MWChart *chart = [[MWChart alloc] initWithDataContainer: dataContainer height:CHART_HEIGHT dateComponents:dateComponentNow];
    [chart createChart];
    
    CGPoint chartPosition = CGPointMake(0, 0);
    self.chartContainerView = [[MWChartContainerView alloc] initWithPosition:chartPosition chart:chart];
    
    CGRect scrollViewFrame = CGRectMake(0,
                                        self.view.frame.origin.y + self.view.frame.size.height/2 - self.chartContainerView.frame.size.height/2,
                                        self.view.frame.size.width,
                                        self.chartContainerView.frame.size.height);
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:scrollViewFrame];
    scrollView.delegate = self;
    scrollView.contentSize = CGSizeMake(self.chartContainerView.frame.size.width * 2, self.chartContainerView.frame.size.height);
    
    [scrollView addSubview:self.chartContainerView];
    
    [self.view addSubview:scrollView];
}

- (NSArray *)createDataArrayFromNumberArray:(NSArray *)array
{
    NSMutableArray *dataArray = [NSMutableArray array];
    
    for (NSNumber *number in array) {
        [dataArray addObject:[MWData createDataWithValue:[number integerValue]]];
    }
    
    return dataArray;
}

# pragma mark - ScrollView delegate methods

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    self.chartContainerView.visibleFromX = scrollView.contentOffset.x;
    NSLog(@"scrollView.contentOffset: %@", NSStringFromCGPoint(scrollView.contentOffset));
}

@end
