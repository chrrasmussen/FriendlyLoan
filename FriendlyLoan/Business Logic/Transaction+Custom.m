//
//  Transaction+Custom.m
//  FriendlyLoan
//
//  Created by Christian Rasmussen on 10.09.11.
//  Copyright (c) 2011 Rasmussen I/O. All rights reserved.
//

#import "Transaction+Custom.h"
#import <CoreData/CoreData.h>

#import "Friend+Custom.h"
#import "Location+Custom.h"

#import "NSDecimalNumber+RIOAdditions.h"
#import "RIORelativeDate.h"


@implementation Transaction (Custom)

#pragma mark - Creating and saving transaction

+ (id)insertNewTransactionInManagedObjectContext:(NSManagedObjectContext *)context
{
    // Create a new transaction with default properties
    Transaction *transaction = [NSEntityDescription insertNewObjectForEntityForName:@"Transaction" inManagedObjectContext:context];
    transaction.createdTimestamp = [NSDate date];
    
    return transaction;
}

- (void)addFriendID:(NSNumber *)friendID
{
    if (self.friend == nil)
        self.friend = [NSEntityDescription insertNewObjectForEntityForName:@"Friend" inManagedObjectContext:self.managedObjectContext];
    
    [self.friend populateFieldsWithFriendID:friendID];
}

- (void)addCurrentLocation
{
    // FIXME: Fix this code
    // - Rename to updateCurrentLocation
    // - Add a method to remove location? May not be necessary
    if (self.location == nil)
    {
//        self.location = [NSEntityDescription insertNewObjectForEntityForName:@"Location" inManagedObjectContext:self.managedObjectContext];
//        [self.location updateLocation];
    }
    
    NSLog(@"Added location for transaction");
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
    return (self.lent == YES) ? self.amount: [self.amount decimalNumberByNegating];
}

@end
