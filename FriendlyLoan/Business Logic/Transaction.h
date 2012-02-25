//
//  Transaction.h
//  FriendlyLoan
//
//  Created by Christian Rasmussen on 10.09.11.
//  Copyright (c) 2011 Rasmussen I/O. All rights reserved.
//

#import "_Transaction.h"


extern const float kTransactionLocationTimeLimit;

//typedef enum {
//    kTransactionLocationStatusNoLocation = 0,
//    kTransactionLocationStatusLocating,
//    kTransactionLocationStatusFound,
//    kTransactionLocationStatusNotFound = -1
//} TransactionLocationStatus;


@class CLLocation;


@interface Transaction : _Transaction

//@property (nonatomic, readonly) TransactionLocationStatus locationStatus;

+ (id)insertInManagedObjectContext:(NSManagedObjectContext *)context;
- (void)updateFriendID:(NSNumber *)friendID;
- (void)updateLocation:(CLLocation *)location;

- (NSString *)historySectionName;

- (BOOL)lentValue;
- (NSDecimalNumber *)absoluteAmount;


@end
