//
//  MWBar.h
//  Chart
//
//  Created by Morgan Wilde on 19/04/2015.
//  Copyright (c) 2015 Morgan Wilde. All rights reserved.
//

#import <Foundation/Foundation.h>
@import CoreGraphics;
@import UIKit;

@interface MWChartBar : NSObject

@property (nonatomic) CGSize size;
@property (nonatomic) CGPoint position;
@property (nonatomic) UIColor *fillColor;
@property (nonatomic) UIColor *negativeFillColor;
@property (nonatomic) BOOL positive;
// Bar label
@property (nonatomic) NSString *labelString;
@property (nonatomic) NSString *labelFontName;
@property (nonatomic) CGFloat labelFontSize;
@property (nonatomic) UIColor *labelColor;
@property (nonatomic) CGSize labelSize;
@property (nonatomic) NSAttributedString *labelAttributedString;

- (instancetype)initWithSize:(CGSize)size position:(CGPoint)position positive:(BOOL)positive title:(NSString *)title;

- (CGRect)frame;
- (CGRect)labelFrame;

+ (CGFloat)labelHeight;

@end
