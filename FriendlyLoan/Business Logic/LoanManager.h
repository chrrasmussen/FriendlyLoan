//
//  LoanManager.h
//  FriendlyLoan
//
//  Created by Christian Rasmussen on 09.02.12.
//  Copyright (c) 2012 Rasmussen I/O. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Models.h"

#import "RIOCachedLocationManagerDelegate.h"


@class PersistentStore;
@class RIOCachedLocationManager;
@protocol LoanManagerLocationServicesDelegate;

@interface LoanManager : NSObject <RIOCachedLocationManagerDelegate>

@property (nonatomic, strong, readonly) PersistentStore *persistentStore;
@property (nonatomic, strong, readonly) RIOCachedLocationManager *cachedLocationManager;

@property (nonatomic, weak) id locationServicesDelegate;

@property (nonatomic) BOOL attachLocationValue;
@property (nonatomic, readonly) BOOL calculatedAttachLocationValue;

@property (nonatomic) BOOL shareLoanValue;
@property (nonatomic, readonly) BOOL calculatedShareLoanValue;


// Create loan manager
+ (id)sharedManager;
- (id)initWithPersistentStore:(PersistentStore *)persistentStore;

// Controlling loan manager
- (void)handleApplicationDidBecomeActive;
//- (void)start;
//- (void)initiate/initialize // If there are some outstanding locations, start location services
//- (void)terminate // Do something useful when quitting?

// Transaction methods
- (Loan *)addTransactionWithUpdateHandler:(void (^)(Loan *transaction))updateHandler;
- (void)updateTransaction:(Loan *)transaction withUpdateHandler:(void (^)(Loan *transaction))updateHandler;
- (Loan *)settleDebt:(NSDecimalNumber *)debt forFriendID:(NSNumber *)friendID;

//- (BOOL)hasUnlocatedTransactions;
//- (NSArray *)remainingTransactions;

// Backing store proxy methods
- (NSManagedObjectContext *)managedObjectContext;


- (NSUInteger)getTransactionRequestCount;

// Fetched results controller
//- (NSFetchedResultsController *)fetchedHistoryControllerWithFriendID:(NSNumber *)friendID;
//- (NSFetchedResultsController *)fetchedFriendsController;


@end
