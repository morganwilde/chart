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

@end
