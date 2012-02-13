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

+ (id)sharedManager;

// Location
- (void)startUpdatingLocation;
- (void)stopUpdatingLocation;
- (CLLocation *)location;

- (void)updateLocation:(CLLocation *)location;

// Backing store
- (NSManagedObjectContext *)managedObjectContext;
- (void)saveContext;

// Attach location
- (void)setAttachLocationStatus:(BOOL)attachLocation;


//- (void)initiate/initialize // If there are some outstanding locations, start location services
//- (void)terminate // Do something useful when quitting?


//- (void)addTransaction:(Transaction *)transaction;
//- (void)updateTransaction:(Transaction *)transaction;
// --- OR ---
//- (void)addTransactionWithAmount:(NSNumber *)amount friendID:(NSNumber *)friendID categoryID:(NSNumber *)categoryID note:(NSString *)note attachLocation:(BOOL)attachLocation;
//- (void)updateTransactionWithID:(NSManagedObjectID *)objectID amount:(NSNumber *)amount friendID:(NSNumber *)friendID categoryID:(NSNumber *)categoryID note:(NSString *)note attachLocation:(BOOL)attachLocation;

@end
