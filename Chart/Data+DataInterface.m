//
//  Data+DataInterface.m
//  Chart
//
//  Created by Morgan Wilde on 06/05/2015.
//  Copyright (c) 2015 Morgan Wilde. All rights reserved.
//

#import "Data+DataInterface.h"
#import "AppDelegate.h"

@implementation Data (DataInterface)

- (NSString *)dateFormatted
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd";
    return [formatter stringFromDate:self.date];
}

+ (NSDate *)normalizeDate:(NSDate *)date
{
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    formatter.numberStyle = NSNumberFormatterDecimalStyle;
    NSCalendar *calender = [NSCalendar currentCalendar];
    NSDateComponents *dateComponents = [calender components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:date];
    dateComponents.hour = 0;
    dateComponents.minute = 0;
    dateComponents.second = 0;
    
    return [calender dateFromComponents:dateComponents];
}

+ (NSManagedObjectContext *)managedObjectContext
{
    AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
    return appDelegate.managedObjectContext;
}

+ (NSArray *)fetchDataBetween:(NSDate *)dateFrom dateTo:(NSDate *)dateTo
{
    NSManagedObjectContext *context = [Data managedObjectContext];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"Data"
                                                         inManagedObjectContext:self.managedObjectContext];
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"date" ascending:true];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"date >= %@ AND date <= %@", dateFrom, dateTo];
    fetchRequest.sortDescriptors = @[sortDescriptor];
    fetchRequest.entity = entityDescription;
    fetchRequest.predicate = predicate;
    
    NSError *fetchError;
    return [context executeFetchRequest:fetchRequest error:&fetchError];
}

+ (NSArray *)fetchDataForMonth:(MWMonth)month year:(NSInteger)year
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    calendar.timeZone = [NSTimeZone localTimeZone];
    
    // First day of the month
    NSDateComponents *dateComponentsFrom = [[NSDateComponents alloc] init];
    dateComponentsFrom.year = year;
    dateComponentsFrom.month = month;
    dateComponentsFrom.day = 1;
    dateComponentsFrom.hour = 0;
    dateComponentsFrom.minute = 0;
    dateComponentsFrom.second = 0;
    NSDate *dateFrom = [calendar dateFromComponents:dateComponentsFrom];
    
    // Last day of the month
    NSDateComponents *dateComponentsTo = [[NSDateComponents alloc] init];
    dateComponentsTo.year = (month == MWDecember) ? year - 1 : year;
    dateComponentsTo.month = month + 1;
    dateComponentsTo.day = 0;
    dateComponentsTo.hour = 23;
    dateComponentsTo.minute = 59;
    dateComponentsTo.second = 59;
    NSDate *dateTo = [calendar dateFromComponents:dateComponentsTo];
    
    /*
    NSDateFormatter *formatter=[[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss a"];
    [formatter setTimeZone:[NSTimeZone systemTimeZone]];
    NSLog(@"Formatted dateFrom: %@", [formatter stringFromDate:dateFrom]);
    NSLog(@"Formatted dateTo: %@", [formatter stringFromDate:dateTo]);
     */
    
    return [Data fetchDataBetween:dateFrom dateTo:dateTo];
}

+ (Data *)oldestData
{
    NSManagedObjectContext *context = [Data managedObjectContext];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"Data"
                                                         inManagedObjectContext:self.managedObjectContext];
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"date" ascending:true];
    fetchRequest.sortDescriptors = @[sortDescriptor];
    fetchRequest.entity = entityDescription;
    fetchRequest.fetchLimit = 1;
    
    NSError *fetchError;
    NSArray *resultArray = [context executeFetchRequest:fetchRequest error:&fetchError];
    if (resultArray.count == 1) {
        return resultArray[0];
    }
    return nil;
}

+ (Data *)youngestData
{
    NSManagedObjectContext *context = [Data managedObjectContext];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"Data"
                                                         inManagedObjectContext:self.managedObjectContext];
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"date" ascending:false];
    fetchRequest.sortDescriptors = @[sortDescriptor];
    fetchRequest.entity = entityDescription;
    fetchRequest.fetchLimit = 1;
    
    NSError *fetchError;
    NSArray *resultArray = [context executeFetchRequest:fetchRequest error:&fetchError];
    if (resultArray.count == 1) {
        return resultArray[0];
    }
    return nil;
}

+ (Data *)todaysData
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    calendar.timeZone = [NSTimeZone localTimeZone];
    
    // First day of the month
    NSDateComponents *dateComponentsFrom = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:[NSDate date]];
    dateComponentsFrom.hour = 0;
    dateComponentsFrom.minute = 0;
    dateComponentsFrom.second = 0;
    NSDate *dateFrom = [calendar dateFromComponents:dateComponentsFrom];
    
    // Last day of the month
    NSDateComponents *dateComponentsTo = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:[NSDate date]];
    dateComponentsTo.hour = 23;
    dateComponentsTo.minute = 59;
    dateComponentsTo.second = 59;
    NSDate *dateTo = [calendar dateFromComponents:dateComponentsTo];
    
    // Interpret result
    NSArray *resultArray = [Data fetchDataBetween:dateFrom dateTo:dateTo];
    if (resultArray.count == 1) {
        return resultArray[0];
    }
    return nil;
}

#pragma mark - Meta

- (NSString *)description {
    return [NSString stringWithFormat:@"Data {value: %@; goal: %@; date: %@}",
            self.value,
            self.goal,
            self.date];
}

- (BOOL)isEqual:(Data *)data
{
    return (self.value == data.value &&
            self.goal == data.goal &&
            self.date == data.date);
    
}

@end
