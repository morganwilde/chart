//
//  Data.h
//  Chart
//
//  Created by Morgan Wilde on 05/05/2015.
//  Copyright (c) 2015 Morgan Wilde. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Data : NSManagedObject

@property (nonatomic, retain) NSDate * date;
@property (nonatomic, retain) NSNumber * goal;
@property (nonatomic, retain) NSNumber * value;

@end
