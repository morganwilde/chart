//
//  MWData.m
//  Chart
//
//  Created by Morgan Wilde on 19/04/2015.
//  Copyright (c) 2015 Morgan Wilde. All rights reserved.
//

#import "MWData.h"

@implementation MWData

- (instancetype)initWithValue:(NSInteger)value goal:(NSInteger)goal date:(NSDate *)date
{
    self = [super init];
    if (self) {
        self.value = value;
        self.goal = goal;
        self.date = date;
    }
    return self;
}

+ (MWData *)dataWithValue:(NSInteger)value goal:(NSInteger)goal date:(NSDate *)date
{
    return [[MWData alloc] initWithValue:value goal:goal date:date];
}

#pragma mark - Convenience methods

- (NSInteger)dayNumber
{
    return [[NSCalendar currentCalendar] component:NSCalendarUnitDay fromDate:self.date];
}

@end
