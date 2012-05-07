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
#import "LoanManagerAttachLocationDelegate.h"

#import "RIOCachedLocationManager.h"
#import <CoreLocation/CoreLocation.h>

#import "TransactionsWaitingForLocationFetchRequest.h"
#import "NumberOfTransactionRequestsFetchRequest.h"
#import "FetchedHistoryController.h"
//#import "FetchedFriendsController.h"

#import "NSDecimalNumber+RIOAdditions.h"


@implementation LoanManager

@synthesize locationDelegate, backingStoreDelegate, attachLocationDelegate;
@synthesize cachedLocationManager = _cachedLocationManager;


static LoanManager *_sharedManager;


#pragma mark - Create loan manager

+ (id)sharedManager
{
    if (_sharedManager == nil) {
        _sharedManager = [[[self class] alloc] init];
    }
    
    return _sharedManager;
}

- (id)init
{
    self = [super init];
    if (self) {
        [self setUpCachedLocationManager];
    }
    return self;
}

- (void)handleApplicationDidBecomeActive
{
    BOOL needLocation = self.attachLocationValue;
    
    if ([[self transactionsWaitingForLocation] count] > 0) {
        if (_cachedLocationManager.location != nil) {
            [self updateLocationForQueuedTransactions:_cachedLocationManager.location];
        }
        else {
            needLocation = YES;
        }
    }
    
    if (needLocation == YES) {
        [self.cachedLocationManager setNeedsLocation:YES];
    }
}


#pragma mark - Transaction methods

- (Transaction *)addTransactionWithUpdateHandler:(void (^)(Transaction *transaction))updateHandler
{
    Transaction *transaction = [Transaction insertInManagedObjectContext:self.managedObjectContext];
    updateHandler(transaction);
    
    if (transaction.attachLocationValue == YES) {
        CLLocation *location = [self.cachedLocationManager location];
        if (location != nil) {
            [transaction setLocationWithLatitude:location.coordinate.latitude longitude:location.coordinate.longitude];
        }
    }
        
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
        transaction.friendID = friendID;
        
        transaction.amount = [debt decimalNumberByNegating];
        transaction.settledValue = YES;
        
        if ([bself attachLocationValue] == YES) {
            transaction.attachLocationValue = YES;
            CLLocation *location = [bself.cachedLocationManager location];
            if (location != nil) {
                [transaction setLocationWithLatitude:location.coordinate.latitude longitude:location.coordinate.longitude];
            }
        }
    }];
    
    return result;
}

- (void)updateLocationForQueuedTransactions:(CLLocation *)location
{
    NSArray *transactions = [self transactionsWaitingForLocation];
    
    for (Transaction *transaction in transactions) {
        [transaction setLocationWithLatitude:location.coordinate.latitude longitude:location.coordinate.longitude];
    }
    
    [self saveContext];
}

- (NSUInteger)getTransactionRequestCount
{
    // FIXME: Fix
    NSUInteger count = 0;//[NumberOfTransactionRequestsFetchRequest fetchFromManagedObjectContext:self.managedObjectContext];
    return count;
}

#pragma mark - RIOCachedLocationManagerDelegate methods

- (void)cachedLocationManager:(RIOCachedLocationManager *)locationManager didChangeAuthorizationStatus:(CLAuthorizationStatus)status
{
    NSLog(@"%s %d", (char *)_cmd, self.attachLocationValue);
    [self.attachLocationDelegate loanManager:self didChangeAttachLocationValue:self.attachLocationValue];
}

- (void)cachedLocationManager:(RIOCachedLocationManager *)locationManager didFailWithError:(NSError *)error
{
    NSLog(@"%s %@", (char *)_cmd, error);
    if (error.domain == kCLErrorDomain) {
        if (error.code == kCLErrorLocationUnknown) {
            // TODO: Add code?
        }
        else if (error.code == kCLErrorDenied) {
            [self.attachLocationDelegate loanManager:self didChangeAttachLocationValue:NO];
            
            if ([self.locationDelegate respondsToSelector:@selector(loanManagerNeedLocationServices:)]) {
                [self.locationDelegate loanManagerNeedLocationServices:self];
            }
        }
    }
}

- (void)cachedLocationManager:(RIOCachedLocationManager *)locationManager didRetrieveLocation:(CLLocation *)location
{
    NSLog(@"%s", (char *)_cmd);
    [self updateLocationForQueuedTransactions:location];
    
}

- (void)cachedLocationManagerDidExpireCachedLocation:(RIOCachedLocationManager *)locationManager
{
    NSLog(@"%s", (char *)_cmd);
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
    if ([CLLocationManager authorizationStatus] != kCLAuthorizationStatusAuthorized) {
        return NO;
    }
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    if ([userDefaults objectForKey:@"attachLocation"] == nil) {
        return YES;
    }
    
    BOOL status = [userDefaults boolForKey:@"attachLocation"];
    
    return status;
}

- (void)setAttachLocationValue:(BOOL)status
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setBool:status forKey:@"attachLocation"];
    [userDefaults synchronize];
    
    [self.cachedLocationManager setNeedsLocation:status];
}


#pragma mark - Private methods

// TODO: Move purpose to user interface?
- (void)setUpCachedLocationManager
{
    _cachedLocationManager = [[RIOCachedLocationManager alloc] init];
    _cachedLocationManager.delegate = self;
    _cachedLocationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters;
    _cachedLocationManager.distanceFilter = 500;
    _cachedLocationManager.accuracyFilter = 100;
    _cachedLocationManager.timeIntervalFilter = kTransactionLocationTimeLimit;
    _cachedLocationManager.purpose = NSLocalizedString(@"The location will help you remember where the loan took place.", @"The purpose of the location services");
}

- (NSArray *)transactionsWaitingForLocation
{
    return [TransactionsWaitingForLocationFetchRequest fetchFromManagedObjectContext:self.managedObjectContext];
}

@end
