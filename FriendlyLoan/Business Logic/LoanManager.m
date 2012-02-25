//
//  LoanManager.m
//  FriendlyLoan
//
//  Created by Christian Rasmussen on 09.02.12.
//  Copyright (c) 2012 Rasmussen I/O. All rights reserved.
//

#import "LoanManager.h"

#import "LoanManagerBackingStoreDelegate.h"
#import "LoanManagerLocationDelegate.h"

#import "RIOTimedLocationManager.h"

#import "TransactionsWaitingForLocationFetchRequest.h"
#import "FetchedHistoryController.h"
//#import "FetchedFriendsController.h"

#import "NSDecimalNumber+RIOAdditions.h"


@implementation LoanManager

@synthesize locationDelegate, backingStoreDelegate;
@synthesize timedLocationManager = _timedLocationManager;


static LoanManager *_sharedManager;


#pragma mark - Create loan manager

+ (id)sharedManager
{
    if (_sharedManager == nil)
        _sharedManager = [[[self class] alloc] init];
    
    return _sharedManager;
}

- (id)init
{
    self = [super init];
    if (self) {
        [self setUpTimedLocationManager];
    }
    return self;
}

- (void)startUp
{
    if (self.attachLocationValue == YES)
        [self.timedLocationManager startUpdatingLocation];
}


#pragma mark - Transaction methods

- (Transaction *)addTransactionWithUpdateHandler:(void (^)(Transaction *transaction))updateHandler
{
    Transaction *transaction = [Transaction insertInManagedObjectContext:self.managedObjectContext];
    updateHandler(transaction);
    
    if (transaction.attachLocationValue == YES)
        [transaction updateLocation:[self.timedLocationManager location]];
    
    [self saveContext];
    
    return transaction;
}

- (void)updateTransaction:(Transaction *)transaction withUpdateHandler:(void (^)(Transaction *transaction))updateHandler
{
    updateHandler(transaction);
    
    [self saveContext];
}

// TODO: Remove the need for the debt-parameter
- (Transaction *)settleDebt:(NSDecimalNumber *)debt forFriendID:(NSNumber *)friendID
{
    __block typeof(self) bself = self;
    Transaction *result = [self addTransactionWithUpdateHandler:^(Transaction *transaction) {
        [transaction updateFriendID:friendID];
        
        transaction.amount = [debt decimalNumberByNegating];
        transaction.settledValue = YES;
        
        if ([bself attachLocationValue] == YES)
        {
            transaction.attachLocationValue = YES;
            [transaction updateLocation:[bself.timedLocationManager location]];
        }
    }];
    
    return result;
}

- (void)updateLocationForQueuedTransactions:(CLLocation *)location
{
    NSArray *transactions = [self transactionsWaitingForLocation];
    
    for (Transaction *transaction in transactions)
    {
        [transaction updateLocation:location];
    }
    
    [self saveContext];
}


#pragma mark - RIOTimedLocationManagerDelegate methods

- (void)timedLocationManager:(RIOTimedLocationManager *)locationManager didChangeAuthorizationStatus:(CLAuthorizationStatus)status
{
    NSLog(@"%s %d", (char *)_cmd, self.attachLocationValue);
    
    if (self.attachLocationValue == YES)
        [self.timedLocationManager startUpdatingLocation];
    else
        [self.timedLocationManager stopUpdatingLocation];
    
    [self willChangeValueForKey:@"attachLocationValue"];
    [self didChangeValueForKey:@"attachLocationValue"];
}

- (void)timedLocationManager:(RIOTimedLocationManager *)locationManager didRetrieveLocation:(CLLocation *)location
{
    NSLog(@"%s", (char *)_cmd);
    [self updateLocationForQueuedTransactions:location];
    
}

- (void)timedLocationManager:(RIOTimedLocationManager *)locationManager didFailWithError:(NSError *)error
{
    NSLog(@"%s %@", (char *)_cmd, error);
    if (error.domain == kCLErrorDomain)
    {
        if (error.code == kCLErrorLocationUnknown)
        {
            // TODO: Add code?
        }
        else if (error.code == kCLErrorDenied)
        {
            if ([self.locationDelegate respondsToSelector:@selector(loanManagerNeedLocationServices:)])
                [self.locationDelegate loanManagerNeedLocationServices:self];
        }
    }
}


#pragma mark - Backing store proxy methods

- (NSManagedObjectContext *)managedObjectContext
{
    return backingStoreDelegate.managedObjectContext;
}

- (void)saveContext
{
    [backingStoreDelegate saveContext];
}


#pragma mark - Attach location accessor methods

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

- (void)setAttachLocationValue:(BOOL)status
{
    [self willChangeValueForKey:@"attachLocationValue"];
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setBool:status forKey:@"attachLocation"];
    [userDefaults synchronize];
    
    if (status == YES)
        [self.timedLocationManager startUpdatingLocation];
    else
        [self.timedLocationManager stopUpdatingLocation];
    
    [self didChangeValueForKey:@"attachLocationValue"];
}


#pragma mark - Private methods

- (void)setUpTimedLocationManager
{
    _timedLocationManager = [[RIOTimedLocationManager alloc] init];
    _timedLocationManager.delegate = self;
    _timedLocationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters;
    _timedLocationManager.distanceFilter = 500;
    _timedLocationManager.accuracyFilter = 100;
    _timedLocationManager.timeIntervalFilter = kTransactionLocationTimeLimit;
    _timedLocationManager.maximumLocatingDuration = 3 * 60;
    _timedLocationManager.purpose = NSLocalizedString(@"The location will help you remember where the loan took place.", @"The purpose of the location services");
}

- (NSArray *)transactionsWaitingForLocation
{
    return [TransactionsWaitingForLocationFetchRequest fetchFromManagedObjectContext:self.managedObjectContext];
}

@end
