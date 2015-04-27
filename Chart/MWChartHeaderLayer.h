//
//  MWChartHeaderLayer.h
//  Chart
//
//  Created by Morgan Wilde on 27/04/2015.
//  Copyright (c) 2015 Morgan Wilde. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
@import UIKit;

@interface MWChartHeaderLayer : CALayer

@property (nonatomic) NSAttributedString *string;
@property (nonatomic) CGSize labelSize;
@property (nonatomic) CGRect rect;
@property (nonatomic) CGFloat visibleFromX;

@end
