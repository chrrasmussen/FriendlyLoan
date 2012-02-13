//
//  LoanManager.m
//  FriendlyLoan
//
//  Created by Christian Rasmussen on 09.02.12.
//  Copyright (c) 2012 Rasmussen I/O. All rights reserved.
//

#import "LoanManager.h"
//#import <CoreData/CoreData.h>

#import "LoanManagerLocationDelegate.h"
#import "LoanManagerBackingStoreDelegate.h"
#import "LoanManagerAttachLocationDelegate.h"

#import "TransactionsWaitingForLocationFetchRequest.h"


@implementation LoanManager

@synthesize locationDelegate, backingStoreDelegate, attachLocationDelegate;


static LoanManager *_sharedManager;


#pragma mark - Create loan manager

+ (id)sharedManager
{
    if (_sharedManager == nil)
        _sharedManager = [[[self class] alloc] init];
    
    return _sharedManager;
}


#pragma mark - Control location

- (void)startUpdatingLocation
{
    [locationDelegate startUpdatingLocation];
}

- (void)stopUpdatingLocation
{
    [locationDelegate stopUpdatingLocation];
}

- (CLLocation *)location
{
    return [locationDelegate location];
}

- (void)updateLocation:(CLLocation *)location
{
    NSArray *transactions = [TransactionsWaitingForLocationFetchRequest fetchFromManagedObjectContext:self.managedObjectContext];
    
    for (Transaction *transaction in transactions)
    {
        [transaction addLocation:location];
    }
    
    [self saveContext];
}

- (NSManagedObjectContext *)managedObjectContext
{
    return backingStoreDelegate.managedObjectContext;
}

- (void)saveContext
{
    [backingStoreDelegate saveContext];
}

- (void)setAttachLocationStatus:(BOOL)attachLocation
{
    [attachLocationDelegate setAttachLocationStatus:attachLocation];
}

@end
