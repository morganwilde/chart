//
//  MWChartsManager.m
//  Chart
//
//  Created by Morgan Wilde on 09/05/2015.
//  Copyright (c) 2015 Morgan Wilde. All rights reserved.
//

#import "MWChartsManager.h"
#import "Data.h"
#import "Data+DataInterface.h"

@implementation MWChartsManager

- (instancetype)init
{
    self = [super init];
    if (self) {
        Data *oldestData = [Data oldestData];
        Data *youngestData = [Data youngestData];
        Data *todaysData = [Data todaysData];
        
        if (!oldestData && !youngestData && !todaysData) {
            NSLog(@"First visit ever");
        } else if ([todaysData isEqual:oldestData] && [todaysData isEqual:youngestData]) {
            NSLog(@"Today is the first day");
        }
        
        NSLog(@"oldestData: %@", oldestData);
        NSLog(@"youngestData: %@", youngestData);
    }
    return self;
}

@end
