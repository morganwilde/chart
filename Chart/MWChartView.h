//
//  MWChartView.h
//  Chart
//
//  Created by Morgan Wilde on 20/04/2015.
//  Copyright (c) 2015 Morgan Wilde. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MWChart.h"

@interface MWChartView : UIView

- (instancetype)initWithPosition:(CGPoint)position chart:(MWChart *)chart;

@end
