//
//  MWDataContainer.m
//  Chart
//
//  Created by Morgan Wilde on 19/04/2015.
//  Copyright (c) 2015 Morgan Wilde. All rights reserved.
//

#import "MWDataContainer.h"
#import "Data.h"

@implementation MWDataContainer

- (instancetype)initWithDataArray:(NSArray *)dataArray
{
    self = [super init];
    if (self) {
        if (dataArray.count > 0) {
            NSMutableArray *array = [NSMutableArray arrayWithCapacity:dataArray.count];
            if ([dataArray[0] isKindOfClass:[Data class]]) {
                int index = 0;
                for (Data *data in dataArray) {
                    array[index] = [MWData dataWithData:data];
                    index++;
                }
                self.dataArray = array;
            } else {
                self.dataArray = dataArray;
            }
        }
        
        self.minValue = NSIntegerMax;
        self.maxValue = NSIntegerMin;
        self.valueRange = NSIntegerMax;
        self.maxGoal = NSIntegerMin;
    }
    return self;
}

#pragma mark - Getters

- (NSInteger)minValue
{
    if (_minValue == NSIntegerMax) {
        for (MWData *data in self.dataArray) {
            if (data.value < _minValue) {
                _minValue = data.value;
            }
        }
    }
    return _minValue;
}

- (NSInteger)maxValue
{
    if (_maxValue == NSIntegerMin) {
        for (MWData *data in self.dataArray) {
            if (data.value > _maxValue) {
                _maxValue = data.value;
            }
        }
    }
    if (_maxValue < self.maxGoal) {
        return self.maxGoal;
    }
    return _maxValue;
}

- (NSInteger)valueRange
{
    if (_valueRange == NSIntegerMax) {
        if (self.minValue < 0 && self.maxValue > 0) {
            _valueRange = labs(self.minValue) + labs(self.maxValue);
        } else {
            if (labs(self.minValue) < labs(self.maxValue)) {
                _valueRange = labs(self.maxValue);
            } else {
                _valueRange = labs(self.minValue);
            }
        }
    }
    return _valueRange;
}

- (NSInteger)maxGoal
{
    if (_maxGoal == NSIntegerMin) {
        for (MWData *data in self.dataArray) {
            if (data.goal > _maxGoal) {
                _maxGoal = data.goal;
            }
        }
    }
    return _maxGoal;
}

#pragma mark - Convenience methods

- (NSUInteger)dataCount
{
    return [self.dataArray count];
}

- (MWData *)firstDataItem
{
    return self.dataArray.firstObject;
}

- (MWData *)lastDataItem
{
    return self.dataArray.lastObject;
}

@end
