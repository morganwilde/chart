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

@end
