//
//  MWDataContainer.h
//  Chart
//
//  Created by Morgan Wilde on 19/04/2015.
//  Copyright (c) 2015 Morgan Wilde. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MWData.h"

@interface MWDataContainer : NSObject

@property (nonatomic) NSArray *dataArray;
// Values
@property (nonatomic) NSInteger minValue;
@property (nonatomic) NSInteger maxValue;
@property (nonatomic) NSInteger valueRange;
// Goals
@property (nonatomic) NSInteger maxGoal;

- (instancetype)initWithDataArray:(NSArray *)dataArray;

- (NSUInteger)dataCount;
- (MWData *)firstDataItem;
- (MWData *)lastDataItem;

@end
