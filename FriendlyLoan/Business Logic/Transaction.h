//
//  Transaction.h
//  FriendlyLoan
//
//  Created by Christian Rasmussen on 10.09.11.
//  Copyright (c) 2011 Rasmussen I/O. All rights reserved.
//

#import "_Transaction.h"


extern const float kLocationTimeLimit;

@class NSManagadObjectContext, CLLocation;

@interface Transaction : _Transaction

+ (id)insertNewTransactionInManagedObjectContext:(NSManagedObjectContext *)context;
- (void)addFriendID:(NSNumber *)friendID;
//- (void)removeFriendID:(NSNumber *)friendID;
- (void)addLocation:(CLLocation *)location;

- (NSString *)historySectionName;

- (BOOL)lent;
- (NSDecimalNumber *)absoluteAmount;

- (BOOL)hasFriend;

- (BOOL)hasLocation;
- (BOOL)isLocating;
- (BOOL)hasFailedToLocate;


@end
