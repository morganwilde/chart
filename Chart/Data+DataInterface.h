//
//  Data+DataInterface.h
//  Chart
//
//  Created by Morgan Wilde on 06/05/2015.
//  Copyright (c) 2015 Morgan Wilde. All rights reserved.
//

#import "Data.h"
#import "MWEnums.h"

@interface Data (DataInterface)

- (NSString *)dateFormatted;

+ (NSArray *)fetchDataForMonth:(MWMonth)month year:(NSInteger)year;
+ (Data *)oldestData;
+ (Data *)youngestData;
+ (Data *)todaysData;

- (BOOL)isEqual:(Data *)data;

@end
