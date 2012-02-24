//
//  LoanManager.h
//  FriendlyLoan
//
//  Created by Christian Rasmussen on 09.02.12.
//  Copyright (c) 2012 Rasmussen I/O. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Models.h"


@class CLLocation;
@protocol LoanManagerLocationDelegate, LoanManagerBackingStoreDelegate, LoanManagerAttachLocationDelegate;

@interface LoanManager : NSObject

@property (nonatomic, weak) id<LoanManagerLocationDelegate> locationDelegate;
@property (nonatomic, weak) id<LoanManagerBackingStoreDelegate> backingStoreDelegate;
@property (nonatomic, weak) id<LoanManagerAttachLocationDelegate> attachLocationDelegate;

// Create loan manager
+ (id)sharedManager;

// Controlling loan manager
//- (void)start;
//- (void)initiate/initialize // If there are some outstanding locations, start location services
//- (void)terminate // Do something useful when quitting?

// Transaction methods
- (Transaction *)addTransactionWithUpdateHandler:(void (^)(Transaction *transaction))updateHandler;
- (void)updateTransaction:(Transaction *)transaction withUpdateHandler:(void (^)(Transaction *transaction))updateHandler;
- (Transaction *)settleDebt:(NSDecimalNumber *)debt forFriendID:(NSNumber *)friendID;
- (void)updateLocationForCachedTransactions:(CLLocation *)location;

// Location proxy methods
- (void)startUpdatingLocation;
- (void)stopUpdatingLocation;
- (CLLocation *)location;
//- (BOOL)hasUnlocatedTransactions;
//- (NSArray *)remainingTransactions;

// Backing store proxy methods
- (NSManagedObjectContext *)managedObjectContext;
//- (void)saveContext;

// Attach location methods
- (BOOL)attachLocationValue;
- (void)saveAttachLocationValue:(BOOL)attachLocation;
- (void)updateAttachLocationSwitch:(BOOL)attachLocation;


// Fetched results controller
//- (NSFetchedResultsController *)fetchedHistoryControllerWithFriendID:(NSNumber *)friendID;
//- (NSFetchedResultsController *)fetchedFriendsController;




@end
