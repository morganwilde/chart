//
//  MWConstants.h
//  Chart
//
//  Created by Morgan Wilde on 30/04/2015.
//  Copyright (c) 2015 Morgan Wilde. All rights reserved.
//

@import Foundation;
@import UIKit;

@interface MWConstants : NSObject

// Colors - fill and stroke
+ (UIColor *)chartBackgroundColor;
+ (UIColor *)goodBarFillColor;
+ (UIColor *)badBarFillColor;
+ (UIColor *)markerLineFillColor;
+ (UIColor *)zeroMarkerLineFillColor;
+ (UIColor *)goalLineFillColor;
+ (UIColor *)goalLineStrokeColor;
+ (UIColor *)goalLineStartCapFillColor;
+ (UIColor *)goalLineEndCapStrokeColor;
// Colors - font
+ (UIColor *)barLabelFontColor;
+ (UIColor *)dayLabelDayForegroundColor;
+ (UIColor *)dayLabelWeekdayForegroundColor;
+ (UIColor *)monthLabelForegroundColor;
// Fonts - font names
+ (NSString *)barLabelFontName;
+ (NSString *)dayLabelDayFontName;
+ (NSString *)dayLabelWeekdayFontName;
+ (NSString *)monthLabelFontName;
// Fonts - font sizes
+ (CGFloat)barLabelFontSize;
+ (CGFloat)dayLabelDayFontSize;
+ (CGFloat)dayLabelWeekdayFontSize;
+ (CGFloat)monthLabelFontSize;
// Sizes
+ (CGFloat)chartHeight;
+ (CGFloat)barWidth;
+ (CGFloat)barPadding;
+ (CGFloat)zeroMarkerLineHeight;
+ (CGFloat)markerLineHeight;
+ (CGSize)goalLineEndCapSize;
+ (NSString *)goalLineDashPatternString;
+ (CGFloat)dayLabelTopPadding;
+ (CGFloat)dayLabelMiddlePadding;
+ (CGFloat)dayLabelBottomPadding;

@end
