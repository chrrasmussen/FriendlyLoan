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
#import "FetchedHistoryController.h"
//#import "FetchedFriendsController.h"

#import "NSDecimalNumber+RIOAdditions.h"


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


//#pragma mark - Controlling loan manager
//
//- (void)start
//{
//    if ([[self transactionsWaitingForLocation] count] > 0)
//    {
//        if (self.location != nil)
//            [self updateLocationForCachedTransactions:self.location];
//    }
//}


#pragma mark - Transaction methods

- (Transaction *)addTransactionWithUpdateHandler:(void (^)(Transaction *transaction))updateHandler
{
    Transaction *transaction = [Transaction insertInManagedObjectContext:self.managedObjectContext];
    updateHandler(transaction);
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
        [transaction addFriendID:friendID];
        
        transaction.amount = [debt decimalNumberByNegating];
        transaction.settledValue = YES;
        
        if ([bself attachLocationValue] == YES)
        {
            transaction.attachLocationValue = YES;
            [transaction addLocation:[bself location]];
        }
    }];
    
    return result;
}

- (void)updateLocationForCachedTransactions:(CLLocation *)location
{
    NSArray *transactions = [self transactionsWaitingForLocation];
    
    for (Transaction *transaction in transactions)
    {
        [transaction addLocation:location];
    }
    
    [self saveContext];
}


#pragma mark - Location proxy methods

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


#pragma mark - Backing store proxy methods

- (NSManagedObjectContext *)managedObjectContext
{
    return backingStoreDelegate.managedObjectContext;
}

- (void)saveContext
{
    [backingStoreDelegate saveContext];
}


#pragma mark - Attach location methods

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


#pragma mark - Fetched results controller

//- (NSFetchedResultsController *)fetchedHistoryControllerWithFriendID:(NSNumber *)friendID
//{
//    
//}


#pragma mark - Private methods

- (NSArray *)transactionsWaitingForLocation
{
    return [TransactionsWaitingForLocationFetchRequest fetchFromManagedObjectContext:self.managedObjectContext];
}

@end
