//
//  MWBar.m
//  Chart
//
//  Created by Morgan Wilde on 19/04/2015.
//  Copyright (c) 2015 Morgan Wilde. All rights reserved.
//

#import "MWChartBar.h"

@interface MWChartBar ()



@end

@implementation MWChartBar

- (instancetype)initWithSize:(CGSize)size position:(CGPoint)position positive:(BOOL)positive title:(NSString *)title;
{
    self = [super init];
    if (self) {
        // Default colors
        self.fillColor = [UIColor colorWithRed:230/255.0 green:56/255.0 blue:62/255.0 alpha:1.0];
        self.negativeFillColor = [self.fillColor colorWithAlphaComponent:0.5];
        
        self.size = size;
        self.position = position;
        self.positive = positive;
        
        // Bar label
        _labelString = title;
        _labelFontName = BAR_LABEL_FONT_NAME;
        _labelFontSize = BAR_LABEL_FONT_SIZE;
        self.labelColor = [UIColor blackColor];
        // Update the label attributed string and it's bounding size
        [self updateLabelString];
    }
    return self;
}

#pragma mark - Setters

- (void)setLabelFontName:(NSString *)labelFontName
{
    _labelFontName = labelFontName;
    [self updateLabelString];
}
- (void)setLabelFontSize:(CGFloat)labelFontSize
{
    _labelFontSize = labelFontSize;
    [self updateLabelString];
}
- (void)setLabelString:(NSString *)labelString
{
    _labelString = labelString;
    [self updateLabelString];
}
- (void)setLabelColor:(UIColor *)labelColor
{
    _labelColor = labelColor;
    [self updateLabelString];
}

- (void)setPositive:(BOOL)positive
{
    _positive = positive;
    if (!_positive) {
        self.fillColor = self.negativeFillColor;
    }
}

#pragma mark - Label related

- (void)updateLabelString
{
    UIFont *font = [UIFont fontWithName:self.labelFontName size:self.labelFontSize];
    
    NSDictionary *attributes = @{NSFontAttributeName: font,
                                 NSForegroundColorAttributeName: self.labelColor};
    
    self.labelAttributedString = [[NSAttributedString alloc] initWithString:self.labelString
                                                                 attributes:attributes];
    self.labelSize = [self.labelAttributedString size];
}

#pragma mark - Convenience methods

- (CGRect)frame
{
    return CGRectMake(self.position.x, self.position.y, self.size.width, self.size.height);
}

- (CGRect)labelFrame
{
    CGRect rect = [self frame];
    CGFloat labelYPadding = 0;
    if (self.positive) {
        labelYPadding = rect.origin.y - self.labelSize.height;
    } else {
        labelYPadding = rect.origin.y + rect.size.height;
    }
    
    CGRect labelRect = CGRectMake(rect.origin.x + rect.size.width/2 - self.labelSize.width/2,
                                  labelYPadding,
                                  self.labelSize.width,
                                  self.labelSize.height);
    if (labelRect.size.width <= rect.size.width) {
        return labelRect;
    } else {
        self.labelFontSize--;
        [self updateLabelString];
        return [self labelFrame];
    }
}

+ (CGFloat)labelHeight
{
    UIFont *font = [UIFont fontWithName:BAR_LABEL_FONT_NAME size:BAR_LABEL_FONT_SIZE];
    
    NSDictionary *attributes = @{NSFontAttributeName: font};
    
    NSAttributedString *string = [[NSAttributedString alloc] initWithString:@"0123456789"
                                                                 attributes:attributes];
    return [string size].height;
}

@end
