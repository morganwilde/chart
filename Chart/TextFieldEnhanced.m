//
//  TextFieldEnhanced.m
//  Chart
//
//  Created by Morgan Wilde on 06/05/2015.
//  Copyright (c) 2015 Morgan Wilde. All rights reserved.
//

#import "TextFieldEnhanced.h"
#import "DataViewController.h"

@implementation TextFieldEnhanced

- (void)deleteBackward
{
    [super deleteBackward];
    [(DataViewController *)self.delegate textFieldDidDelete:self];
}

@end
