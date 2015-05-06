//
//  TableViewEnhanced.m
//  Chart
//
//  Created by Morgan Wilde on 06/05/2015.
//  Copyright (c) 2015 Morgan Wilde. All rights reserved.
//

#import "TableViewEnhanced.h"

@implementation TableViewEnhanced

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    [self.nextResponder touchesBegan:touches withEvent:event];
}

@end
