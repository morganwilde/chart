//
//  Data+DataInterface.m
//  Chart
//
//  Created by Morgan Wilde on 06/05/2015.
//  Copyright (c) 2015 Morgan Wilde. All rights reserved.
//

#import "Data+DataInterface.h"

@implementation Data (DataInterface)

- (NSString *)dateFormatted
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd";
    return [formatter stringFromDate:self.date];
}

@end
