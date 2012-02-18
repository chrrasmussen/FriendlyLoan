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


@interface LoanManager ()

- (NSArray *)transactionsWaitingForLocation;

@end



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


#pragma mark - Controlling loan manager

- (void)start
{
    if ([[self transactionsWaitingForLocation] count] > 0)
    {
        if (self.location != nil)
            [self updateLocation:self.location];
        else
            [self startUpdatingLocation];
    }
}

//#pragma mark - 
//
//- (void)addTransaction:(Transaction *)transaction
//{
//    
//}
//
//- (void)editTransaction:(Transaction *)transaction
//{
//    
//}
//
//- (void)settleDebtForFriendID:(NSNumber *)friendID
//{
//    
//}


#pragma mark - Control location

- (void)startUpdatingLocation
{
    if ([self attachLocationValue] == YES)
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
    NSArray *transactions = [self transactionsWaitingForLocation];
    
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


#pragma mark - Attach location

- (BOOL)attachLocationValue
{
    if ([CLLocationManager authorizationStatus] != kCLAuthorizationStatusAuthorized)
        return NO;
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    if ([userDefaults objectForKey:@"attachLocation"] == nil)
        return YES;
    
    BOOL status = [userDefaults boolForKey:@"attachLocation"];
    
    return status;
}

- (void)saveAttachLocationValue:(BOOL)status
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setBool:status forKey:@"attachLocation"];
    [userDefaults synchronize];
}

- (void)updateAttachLocationSwitch:(BOOL)status
{
    BOOL attachLocation = [self attachLocationValue] && status;
    [attachLocationDelegate loanManager:self didChangeAttachLocationValue:attachLocation];
}


#pragma mark - Private methods

- (NSArray *)transactionsWaitingForLocation
{
    return [TransactionsWaitingForLocationFetchRequest fetchFromManagedObjectContext:self.managedObjectContext];
}

@end
