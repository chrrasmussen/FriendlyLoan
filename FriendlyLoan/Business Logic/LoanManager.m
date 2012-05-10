//
//  LoanManager.m
//  FriendlyLoan
//
//  Created by Christian Rasmussen on 09.02.12.
//  Copyright (c) 2012 Rasmussen I/O. All rights reserved.
//

#import "LoanManager.h"

#import "PersistentStore.h"
#import "RIOCachedLocationManager.h"
#import <CoreLocation/CoreLocation.h>

#import "LoanManagerLocationServicesDelegate.h"

#import "RIOComputedState.h"

#import "LoansWaitingForLocationFetchRequest.h"
#import "NumberOfLoanRequestsFetchRequest.h"
#import "FetchedHistoryController.h"
//#import "FetchedFriendsController.h"

#import "NSDecimalNumber+RIOAdditions.h"


@interface LoanManager ()

@property (nonatomic, strong) RIOComputedState *attachLocationState;
@property (nonatomic, strong) RIOComputedState *shareLoanState;

@end


@implementation LoanManager

static LoanManager *_sharedManager;

@synthesize persistentStore = _persistentStore;
@synthesize cachedLocationManager = _cachedLocationManager;
@synthesize locationServicesDelegate;
@synthesize attachLocationState, shareLoanState;


#pragma mark - Create loan manager

+ (id)sharedManager
{
    return _sharedManager;
}

- (id)initWithPersistentStore:(PersistentStore *)aPersistentStore
{
    self = [super init];
    if (self) {
        _sharedManager = self;
        
        _persistentStore = aPersistentStore;
        [self setUpCachedLocationManager];
        
        [self setUpAttachLocationState];
        [self setUpShareLoanState];
    }
    return self;
}

- (void)handleApplicationDidBecomeActive
{
    BOOL needLocation = self.attachLocationValue;
    
    if ([[self loansWaitingForLocation] count] > 0) {
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

- (Loan *)addTransactionWithUpdateHandler:(void (^)(Loan *transaction))updateHandler
{
    Loan *transaction = [Loan insertInManagedObjectContext:self.managedObjectContext];
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

- (void)updateTransaction:(Loan *)transaction withUpdateHandler:(void (^)(Loan *transaction))updateHandler
{
    updateHandler(transaction);
    
    [self saveContext];
}

// TODO: Remove the need for the debt-parameter
- (Loan *)settleDebt:(NSDecimalNumber *)debt forFriendID:(NSNumber *)friendID
{
    __block typeof(self) bself = self;
    Loan *result = [self addTransactionWithUpdateHandler:^(Loan *transaction) {
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
    NSArray *transactions = [self loansWaitingForLocation];
    
    for (Loan *transaction in transactions) {
        [transaction setLocationWithLatitude:location.coordinate.latitude longitude:location.coordinate.longitude];
    }
    
    [self saveContext];
}

- (NSUInteger)getTransactionRequestCount
{
    // FIXME: Fix
    NSUInteger count = 0;//[NumberOfLoanRequestsFetchRequest fetchFromManagedObjectContext:self.managedObjectContext];
    return count;
}

- (NSArray *)loansWaitingForLocation
{
    return [LoansWaitingForLocationFetchRequest fetchFromManagedObjectContext:self.managedObjectContext];
}


#pragma mark - RIOCachedLocationManagerDelegate methods

// TODO: Move purpose to user interface?
- (void)setUpCachedLocationManager
{
    _cachedLocationManager = [[RIOCachedLocationManager alloc] init];
    _cachedLocationManager.delegate = self;
    _cachedLocationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters;
    _cachedLocationManager.distanceFilter = 500;
    _cachedLocationManager.accuracyFilter = 100;
    _cachedLocationManager.timeIntervalFilter = kLoanLocationTimeLimit;
    _cachedLocationManager.purpose = NSLocalizedString(@"The location will help you remember where the loan took place.", @"The purpose of the location services");
}

- (void)cachedLocationManager:(RIOCachedLocationManager *)locationManager didChangeAuthorizationStatus:(CLAuthorizationStatus)status
{
    NSLog(@"%s %d", (char *)_cmd, self.attachLocationValue);
//    [self.attachLocationDelegate loanManager:self didChangeAttachLocationValue:self.attachLocationValue];
    self.attachLocationState.systemState = [NSNumber numberWithBool:(status == kCLAuthorizationStatusAuthorized)];
}

- (void)cachedLocationManager:(RIOCachedLocationManager *)locationManager didFailWithError:(NSError *)error
{
    NSLog(@"%s %@", (char *)_cmd, error);
    if (error.domain == kCLErrorDomain) {
        if (error.code == kCLErrorLocationUnknown) {
            // TODO: Add code?
        }
        else if (error.code == kCLErrorDenied) {
            self.attachLocationState.systemState = [NSNumber numberWithBool:NO];
//            [self.attachLocationDelegate loanManager:self didChangeAttachLocationValue:NO];
//            
//            if ([self.locationServicesDelegate respondsToSelector:@selector(loanManagerNeedLocationServices:)]) {
//                [self.locationServicesDelegate loanManagerNeedLocationServices:self];
//            }
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
    return _persistentStore.managedObjectContext;
}

- (void)saveContext
{
    [_persistentStore saveContext];
}


#pragma mark - Attach location methods

- (void)setUpAttachLocationState
{
    NSNumber *userState = [[NSUserDefaults standardUserDefaults] objectForKey:@"attachLocation"];
    NSNumber *systemState = [NSNumber numberWithBool:([CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorized)];
    self.attachLocationState = [[RIOComputedState alloc] initWithInitialUserState:userState systemState:systemState computedStateHandler:^id(id userState, id systemState) {
        BOOL available = ([userState boolValue] == YES && [systemState boolValue] == YES);
        return [NSNumber numberWithBool:available];
    }];
}

- (BOOL)attachLocationValue
{
    return [self.attachLocationState.userState boolValue];
}

- (void)setAttachLocationValue:(BOOL)status
{
    self.attachLocationState.userState = [NSNumber numberWithBool:status];
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setBool:status forKey:@"attachLocation"];
    [userDefaults synchronize];
    
    [self.cachedLocationManager setNeedsLocation:status];
}

- (BOOL)calculatedAttachLocationValue
{
    return [self.attachLocationState.computedState boolValue];
}

+ (NSSet *)keyPathsForValuesAffectingCalculatedAttachLocationValue
{
    return [NSSet setWithObject:@"attachLocationState.computedState"];
}


#pragma mark - Share loan methods

- (void)setUpShareLoanState
{
    NSNumber *userState = [[NSUserDefaults standardUserDefaults] objectForKey:@"shareLoan"];
    NSNumber *systemState = [NSNumber numberWithBool:YES]; // TODO: Fix this
    self.shareLoanState = [[RIOComputedState alloc] initWithInitialUserState:userState systemState:systemState computedStateHandler:^id(id userState, id systemState) {
        BOOL available = ([userState boolValue] == YES && [systemState boolValue] == YES);
        return [NSNumber numberWithBool:available];
    }];
}

- (BOOL)shareLoanValue
{
    return [self.shareLoanState.userState boolValue];
}

- (void)setShareLoanValue:(BOOL)status
{
    self.shareLoanState.userState = [NSNumber numberWithBool:status];
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setBool:status forKey:@"shareLoan"];
    [userDefaults synchronize];
}

- (BOOL)calculatedShareLoanValue
{
    return [self.shareLoanState.computedState boolValue];
}

+ (NSSet *)keyPathsForValuesAffectingCalculatedShareLoanValue
{
    return [NSSet setWithObject:@"shareLoanState.computedState"];
}

@end
