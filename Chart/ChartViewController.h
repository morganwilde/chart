//
//  ViewController.h
//  Chart
//
//  Created by Morgan Wilde on 19/04/2015.
//  Copyright (c) 2015 Morgan Wilde. All rights reserved.
//

@import UIKit;
// Models
#import "MWChartsManager.h"

@interface ChartViewController : UIViewController <UIScrollViewDelegate>

@property (nonatomic) MWChartsManager *chartsManager;

@property (nonatomic) NSArray *dataArray;

@end

