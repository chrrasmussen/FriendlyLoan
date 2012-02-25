//
//  LoanManager.h
//  FriendlyLoan
//
//  Created by Christian Rasmussen on 09.02.12.
//  Copyright (c) 2012 Rasmussen I/O. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Models.h"

#import "RIOTimedLocationManagerDelegate.h"


@class CLLocation, RIOTimedLocationManager;
@protocol LoanManagerLocationDelegate, LoanManagerBackingStoreDelegate;

@interface LoanManager : NSObject <RIOTimedLocationManagerDelegate>

@property (nonatomic, weak) id<LoanManagerLocationDelegate> locationDelegate;
@property (nonatomic, weak) id<LoanManagerBackingStoreDelegate> backingStoreDelegate;

@property (nonatomic, strong, readonly) RIOTimedLocationManager *timedLocationManager;

@property (nonatomic) BOOL attachLocationValue;


// Create loan manager
+ (id)sharedManager;

// Controlling loan manager
- (void)startUp;
//- (void)start;
//- (void)initiate/initialize // If there are some outstanding locations, start location services
//- (void)terminate // Do something useful when quitting?

// Transaction methods
- (Transaction *)addTransactionWithUpdateHandler:(void (^)(Transaction *transaction))updateHandler;
- (void)updateTransaction:(Transaction *)transaction withUpdateHandler:(void (^)(Transaction *transaction))updateHandler;
- (Transaction *)settleDebt:(NSDecimalNumber *)debt forFriendID:(NSNumber *)friendID;

//- (BOOL)hasUnlocatedTransactions;
//- (NSArray *)remainingTransactions;

// Backing store proxy methods
- (NSManagedObjectContext *)managedObjectContext;

// Fetched results controller
//- (NSFetchedResultsController *)fetchedHistoryControllerWithFriendID:(NSNumber *)friendID;
//- (NSFetchedResultsController *)fetchedFriendsController;


@end
