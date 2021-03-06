//
//  MWChartContainerView.h
//  Chart
//
//  Created by Morgan Wilde on 26/04/2015.
//  Copyright (c) 2015 Morgan Wilde. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MWChart.h"

@interface MWChartContainerView : UIView

@property (nonatomic) CGFloat visibleFromX;

- (instancetype)initWithPosition:(CGPoint)position chart:(MWChart *)chart;

@end
