//
//  MWChartHeaderLayer.m
//  Chart
//
//  Created by Morgan Wilde on 27/04/2015.
//  Copyright (c) 2015 Morgan Wilde. All rights reserved.
//

#import "MWChartHeaderLayer.h"

@implementation MWChartHeaderLayer


- (void)drawLayer:(CALayer *)layer inContext:(CGContextRef)ctx
{
    NSLog(@"here2");
}

- (void)drawInContext:(CGContextRef)ctx
{
    CGFloat paddingY = self.rect.size.height/2 - self.labelSize.height/2;
    CGRect labelRect = CGRectMake(self.rect.origin.x + paddingY + self.visibleFromX,
                                  self.rect.origin.y + paddingY,
                                  self.labelSize.width,
                                  self.labelSize.height);
    
    //    UIBezierPath *labelPath = [UIBezierPath bezierPathWithRect:labelRect];
    //    [[UIColor greenColor] setFill];
    //    [labelPath fill];
    
    [self.string drawInRect:labelRect];
    NSLog(@"here");
}

+ (BOOL)needsDisplayForKey:(NSString *)key
{
    if ([key isEqualToString:@"visibleFromX"]) {
        return YES;
    }
    return [super needsDisplayForKey:key];
}

@end
