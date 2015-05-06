//
//  MWConstants.m
//  Chart
//
//  Created by Morgan Wilde on 30/04/2015.
//  Copyright (c) 2015 Morgan Wilde. All rights reserved.
//

#import "MWConstants.h"

@implementation MWConstants

// Colors - fill and stroke

+ (UIColor *)chartBackgroundColor
{
    return [UIColor colorWithRed:238/255.0 green:199/255.0 blue:101/255.0 alpha:1];
}
+ (UIColor *)goodBarFillColor
{
    return [UIColor colorWithRed:230/255.0 green:56/255.0 blue:62/255.0 alpha:1.0];
}
+ (UIColor *)badBarFillColor
{
    return [[MWConstants goodBarFillColor] colorWithAlphaComponent:0.5];
}
+ (UIColor *)markerLineFillColor
{
    return [UIColor colorWithRed:230/255.0 green:56/255.0 blue:62/255.0 alpha:1.0];
}
+ (UIColor *)zeroMarkerLineFillColor
{
    return [MWConstants markerLineFillColor];
}
+ (UIColor *)goalLineFillColor
{
    return [UIColor blackColor];
}
+ (UIColor *)goalLineStrokeColor
{
    return [[MWConstants goalLineFillColor] colorWithAlphaComponent:0.5];
}
+ (UIColor *)goalLineStartCapFillColor
{
    // TODO: not used yet
    return [UIColor blackColor];
}
+ (UIColor *)goalLineEndCapStrokeColor
{
    // TODO: not used yet
    return [MWConstants goalLineStartCapFillColor];
}

// Colors - font

+ (UIColor *)barLabelFontColor
{
    return [UIColor blackColor];
}
+ (UIColor *)dayLabelDayForegroundColor
{
    return [UIColor blackColor];
}
+ (UIColor *)dayLabelWeekdayForegroundColor
{
    return [UIColor blackColor];
}
+ (UIColor *)monthLabelForegroundColor
{
    return [UIColor blackColor];
}

// Fonts - font names

+ (NSString *)barLabelFontName { return @"Comfortaa-Bold"; }
+ (NSString *)dayLabelDayFontName { return @"Comfortaa-Bold"; }
+ (NSString *)dayLabelWeekdayFontName { return @"Comfortaa-Regular"; }
+ (NSString *)monthLabelFontName { return @"Comfortaa-Bold"; }

// Fonts - font sizes

+ (CGFloat)barLabelFontSize { return 17; }
+ (CGFloat)dayLabelDayFontSize { return 16; }
+ (CGFloat)dayLabelWeekdayFontSize { return 11; }
+ (CGFloat)monthLabelFontSize { return 11; }

// Sizes

+ (CGFloat)chartHeight { return 240; }
+ (CGFloat)barWidth { return 20; }
+ (CGFloat)barPadding { return 10; }
+ (CGFloat)zeroMarkerLineHeight { return 2; }
+ (CGFloat)markerLineHeight { return 0.5; }
+ (CGSize)goalLineEndCapSize { return CGSizeMake(4, 4); }
+ (NSString *)goalLineDashPatternString { return @"------  "; }
+ (CGFloat)dayLabelTopPadding { return 6; }
+ (CGFloat)dayLabelMiddlePadding { return 1; }
+ (CGFloat)dayLabelBottomPadding { return 6; }

@end
