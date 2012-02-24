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


const float kLocationTimeLimit = 15*60; // TODO: Set as a global constant


@interface Transaction ()

- (BOOL)needLocation;
- (BOOL)isRecentlyCreated;

@end


@implementation Transaction

#pragma mark - Creating and saving transaction

+ (id)insertInManagedObjectContext:(NSManagedObjectContext *)context
{
    // Create a new transaction with default properties
    Transaction *transaction = [super insertInManagedObjectContext:context];
    transaction.createdTimestamp = [NSDate date];
    
    return transaction;
}

- (void)addFriendID:(NSNumber *)friendID
{
    if (friendID == nil)
        return;
    
    if ([self hasFriend] == NO)
    {
        self.friend = [Friend insertInManagedObjectContext:self.managedObjectContext];
    }
    
    [self.friend populateFieldsWithFriendID:friendID];
}

- (void)addLocation:(CLLocation *)location
{
    if (location == nil)
        return;
    
    if ([self hasLocation] == NO)
    {
        self.location = [Location insertInManagedObjectContext:self.managedObjectContext];
    }
    
    [self.location updateLocation:location];
}


#pragma mark - History methods

- (NSString *)historySectionName
{
    return [self.createdTimestamp relativeDate];
}


#pragma mark - Lent methods

- (BOOL)lent
{
    return ([self.amount isNegative] == NO);
}

- (NSDecimalNumber *)absoluteAmount
{
    return ([self lent] == YES) ? self.amount : [self.amount decimalNumberByNegating];
}


#pragma mark - Friend methods

- (BOOL)hasFriend
{
    BOOL hasFriend = (self.friend != nil);
    return hasFriend;
}


#pragma mark - Location methods

- (BOOL)hasLocation
{
    BOOL hasLocation = (self.location != nil);
    return hasLocation;
}

- (BOOL)isLocating
{
    return ([self needLocation] && [self isRecentlyCreated]);
}

- (BOOL)hasFailedToLocate
{
    return ([self needLocation] && ![self isRecentlyCreated]);
}


#pragma mark - Private methods

- (BOOL)needLocation
{
    BOOL attachLocation = [self attachLocationValue];
    BOOL hasLocation = (self.location != nil);
    
    return (attachLocation && !hasLocation);
}

- (BOOL)isRecentlyCreated
{
    NSTimeInterval timeInterval = [[NSDate date] timeIntervalSinceDate:self.createdTimestamp];
    BOOL isRecentlyCreated = (abs(timeInterval) < kLocationTimeLimit);
    
    return isRecentlyCreated;
}

@end
