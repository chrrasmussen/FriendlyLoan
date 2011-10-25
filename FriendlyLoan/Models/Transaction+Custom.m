//
//  Transaction+CustomMethods.m
//  FriendlyLoan
//
//  Created by Christian Rasmussen on 10.09.11.
//  Copyright (c) 2011 Rasmussen I/O. All rights reserved.
//

#import "Transaction+Custom.h"
#import "NSDecimalNumber+RIOAdditions.h"

#import "Friend+Custom.h"
#import "Location+Custom.h"

#import "RIORelativeDate.h"
#import "LocationManager.h" // TODO: Move to Location+Custom.h
#import "AppDelegate.h"


@implementation Transaction (Custom)

#pragma mark - Creating and saving transaction

+ (Transaction *)newTransaction
{
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    return [NSEntityDescription insertNewObjectForEntityForName:@"Transaction" inManagedObjectContext:appDelegate.managedObjectContext];
}

- (void)addFriendID:(NSNumber *)friendID
{
    if (self.friend == nil)
        self.friend = [NSEntityDescription insertNewObjectForEntityForName:@"Friend" inManagedObjectContext:self.managedObjectContext];
    
    [self.friend populateFieldsWithFriendID:friendID];
}

- (void)addCurrentLocation
{
    if (self.location == nil)
    {
        self.location = [NSEntityDescription insertNewObjectForEntityForName:@"Location" inManagedObjectContext:self.managedObjectContext];
        self.location.status = [NSNumber numberWithInt:kLocationStatusLocating];
    }
    
    CLLocationCoordinate2D lastKnownLocation = [[[LocationManager sharedManager] qualifiedLocation] coordinate];
    self.location.latitude = [NSNumber numberWithDouble:lastKnownLocation.latitude];
    self.location.longitude = [NSNumber numberWithDouble:lastKnownLocation.longitude];
    
    NSLog(@"Added location for transaction");
}

- (void)save
{
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    [appDelegate saveContext];
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
