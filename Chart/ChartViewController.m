//
//  ViewController.m
//  Chart
//
//  Created by Morgan Wilde on 19/04/2015.
//  Copyright (c) 2015 Morgan Wilde. All rights reserved.
//

@import CoreData;
#import "AppDelegate.h"

#import "ChartViewController.h"
// Views
#import "MWChartView.h"
#import "MWChartContainerView.h"
#import "MWChartsManagerView.h"
#import "MWConstants.h"

@interface ChartViewController ()

@property (nonatomic) MWChartContainerView *chartContainerView;

// Core data properties
@property (nonatomic) NSManagedObjectContext *managedObjectContext;

@end

@implementation ChartViewController

#pragma mark - Getters

- (NSManagedObjectContext *)managedObjectContext
{
    if (!_managedObjectContext) {
        AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
        _managedObjectContext = appDelegate.managedObjectContext;
    }
    return _managedObjectContext;
}

- (NSArray *)dataArray
{
    if (!_dataArray) {
        NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
        NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"Data"
                                                             inManagedObjectContext:self.managedObjectContext];
        NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"date" ascending:true];
        fetchRequest.sortDescriptors = @[sortDescriptor];
        fetchRequest.entity = entityDescription;
        NSError *fetchError;
        _dataArray = [self.managedObjectContext executeFetchRequest:fetchRequest error:&fetchError];
    }
    return _dataArray;
}

- (MWChartsManager *)chartsManager
{
    if (!_chartsManager) {
        _chartsManager = [[MWChartsManager alloc] init];
    }
    return _chartsManager;
}

#pragma mark - View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.chartsManager;
    
    NSDateComponents *dateComponentNow = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:[NSDate date]];
    
    
    // Creates the view and puts it on the screen
    MWDataContainer *dataContainer = [[MWDataContainer alloc] initWithDataArray:self.dataArray];
    MWChart *chart = [[MWChart alloc] initWithDataContainer:dataContainer
                                                     height:[MWConstants chartHeight]
                                             dateComponents:dateComponentNow];
    [chart createChart];
    
    CGPoint chartPosition = CGPointMake(0, 0);
    self.chartContainerView = [[MWChartContainerView alloc] initWithPosition:chartPosition chart:chart];
    
    
    CGRect scrollViewFrame = CGRectMake(0,
                                        self.view.frame.origin.y + self.view.frame.size.height/2 - self.chartContainerView.frame.size.height/2,
                                        self.view.frame.size.width,
                                        self.chartContainerView.frame.size.height);
    MWChartsManagerView *scrollView = [[MWChartsManagerView alloc] initWithFrame:scrollViewFrame];
    scrollView.delegate = self;
    scrollView.contentSize = CGSizeMake(self.chartContainerView.frame.size.width * 2, self.chartContainerView.frame.size.height);
    scrollView.backgroundColor = [MWConstants chartBackgroundColor];
    
    [scrollView addSubview:self.chartContainerView];
    
    [self.view addSubview:scrollView];
}

# pragma mark - ScrollView delegate methods

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    self.chartContainerView.visibleFromX = scrollView.contentOffset.x;
}

@end
