//
//  Transaction+Custom.h
//  FriendlyLoan
//
//  Created by Christian Rasmussen on 10.09.11.
//  Copyright (c) 2011 Rasmussen I/O. All rights reserved.
//

#import "Transaction.h"


@class NSManagadObjectContext, CLLocation;

@interface Transaction (Custom)

+ (id)insertNewTransactionInManagedObjectContext:(NSManagedObjectContext *)context;
- (void)addFriendID:(NSNumber *)friendID;
//- (void)removeFriendID:(NSNumber *)friendID;
- (void)updateLocation:(CLLocation *)location;

- (NSString *)historySectionName;

- (BOOL)lent;
- (NSDecimalNumber *)absoluteAmount;

@end
