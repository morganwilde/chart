//
//  MWData.h
//  Chart
//
//  Created by Morgan Wilde on 19/04/2015.
//  Copyright (c) 2015 Morgan Wilde. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MWData : NSObject

@property (nonatomic) NSInteger value;
@property (nonatomic) NSInteger goal;
@property (nonatomic) NSDate *date;

- (instancetype)initWithValue:(NSInteger)value goal:(NSInteger)goal date:(NSDate *)date;
- (instancetype)initWithValue:(NSInteger)value goal:(NSInteger)goal;
- (instancetype)initWithValue:(NSInteger)value;
+ (MWData *)dataWithValue:(NSInteger)value goal:(NSInteger)goal;
+ (MWData *)dataWithValue:(NSInteger)value;
+ (MWData *)createDataWithValue:(NSInteger)value;
+ (MWData *)dataWithValue:(NSInteger)value goal:(NSInteger)goal date:(NSDate *)date;

@end
