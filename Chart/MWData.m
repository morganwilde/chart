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
        
        NSLog(@"dayNumber: %ld", [self dayNumber]);
    }
    return self;
}

- (instancetype)initWithValue:(NSInteger)value goal:(NSInteger)goal
{
    return [self initWithValue:value goal:goal date:nil];
}

- (instancetype)initWithValue:(NSInteger)value
{
    return [self initWithValue:value goal:0];
}

+ (MWData *)createDataWithValue:(NSInteger)value
{
    return [[MWData alloc] initWithValue:value];
}

+ (MWData *)dataWithValue:(NSInteger)value
{
    return [[MWData alloc] initWithValue:value goal:0];
}

+ (MWData *)dataWithValue:(NSInteger)value goal:(NSInteger)goal
{
    return [[MWData alloc] initWithValue:value goal:goal];
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
