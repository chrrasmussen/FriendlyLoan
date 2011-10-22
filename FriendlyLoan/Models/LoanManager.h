//
//  Loan.h
//  FriendlyLoan
//
//  Created by Christian Rasmussen on 06.10.11.
//  Copyright (c) 2011 Rasmussen I/O. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

#import "Models.h"
#import "LocationManagerDelegate.h"


@class LocationManager;

@interface LoanManager : NSObject <LocationManagerDelegate>

@property (nonatomic, strong, readonly) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, strong, readonly) NSManagedObjectContext *locationManagedObjectContext;

@property (nonatomic, strong, readonly) LocationManager *locationManager;
@property (nonatomic, strong, readonly) NSMutableSet *transactionsWaitingForLocation;

+ (id)sharedManager;
+ (void)setSharedManager:(LoanManager *)manager;

- (id)initWithManagedObjectContext:(NSManagedObjectContext *)context;

- (Transaction *)newTransaction;
- (void)addFriendID:(NSNumber *)friendID forTransaction:(Transaction *)transaction;
- (void)addCurrentLocationForTransaction:(Transaction *)transaction;

- (void)saveContext;

- (void)startUpdatingLocation;
- (void)stopUpdatingLocation;

@end
