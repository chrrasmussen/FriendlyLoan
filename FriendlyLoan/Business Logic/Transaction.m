//
//  Transaction.m
//  FriendlyLoan
//
//  Created by Christian Rasmussen on 10.09.11.
//  Copyright (c) 2011 Rasmussen I/O. All rights reserved.
//

#import "Transaction.h"
#import <CoreData/CoreData.h>

#import "Friend.h"
#import "Location.h"

#import "NSDecimalNumber+RIOAdditions.h"
#import "RIORelativeDate.h"


const float kTransactionLocationTimeLimit = 0.5*60; // FIXME: 10 instead of 0.5


@implementation Transaction


#pragma mark - Managed object life-cycle methods

//- (void)awakeFromInsert
//{
//    [super awakeFromInsert];
//    NSLog(@"%s", (char *)_cmd);
//}
//
//- (void)awakeFromFetch
//{
//    [super awakeFromFetch];
//    NSLog(@"%s", (char *)_cmd);
//}


#pragma mark - Creating and saving transaction

+ (id)insertInManagedObjectContext:(NSManagedObjectContext *)context
{
    // Create a new transaction with default properties
    Transaction *transaction = [super insertInManagedObjectContext:context];
    transaction.createdTimestamp = [NSDate date];
//    NSLog(@"%s", (char *)_cmd);
    
    return transaction;
}

- (void)updateFriendID:(NSNumber *)friendID
{
    if (friendID == nil)
        return;
    
    if (self.friend == nil)
    {
        self.friend = [Friend insertInManagedObjectContext:self.managedObjectContext];
    }
    
    [self.friend populateFieldsWithFriendID:friendID];
}

- (void)updateLocation:(CLLocation *)location
{
    if (location == nil)
        return;
    
    if (self.location == nil)
    {
//        [self willChangeValueForKey:@"locationStatus"];
        self.location = [Location insertInManagedObjectContext:self.managedObjectContext];
//        [self didChangeValueForKey:@"locationStatus"];
    }
    
    [self.location updateLocation:location];
}


#pragma mark - History methods

- (NSString *)historySectionName
{
    return [self.createdTimestamp relativeDate];
}

//#pragma mark - Location status methods
//
//- (TransactionLocationStatus)locationStatus
//{
//    if (self.location != nil)
//        return kTransactionLocationStatusFound;
//    else if ([self isLocating] == YES)
//        return kTransactionLocationStatusLocating;
//    else if ([self hasFailedToLocate] == YES)
//        return kTransactionLocationStatusNotFound;
//    else
//        return kTransactionLocationStatusNoLocation;
//}


#pragma mark - Lent methods

- (BOOL)lentValue
{
    return ([self.amount isNegative] == NO);
}

- (NSDecimalNumber *)absoluteAmount
{
    return ([self lentValue] == YES) ? self.amount : [self.amount decimalNumberByNegating];
}


#pragma mark - Private methods

- (BOOL)isLocating
{
    return ([self needLocation] && [self isRecentlyCreated]);
}

- (BOOL)hasFailedToLocate
{
    return ([self needLocation] && ![self isRecentlyCreated]);
}

- (BOOL)needLocation
{
    BOOL attachLocation = [self attachLocationValue];
    BOOL hasLocation = (self.location != nil);
    
    return (attachLocation && !hasLocation);
}

- (BOOL)isRecentlyCreated
{
    NSTimeInterval timeInterval = [[NSDate date] timeIntervalSinceDate:self.createdTimestamp];
    BOOL isRecentlyCreated = (abs(timeInterval) < kTransactionLocationTimeLimit);
    
    return isRecentlyCreated;
}

@end
