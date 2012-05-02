//
//  Transaction+Custom.h
//  FriendlyLoan
//
//  Created by Christian Rasmussen on 10.09.11.
//  Copyright (c) 2011 Rasmussen I/O. All rights reserved.
//

#import "Transaction.h"


@interface Transaction (Custom)

+ (id)newTransaction;
- (void)addFriendID:(NSNumber *)friendID;
- (void)addCurrentLocation;
- (void)save;

- (NSString *)historySectionName;

- (BOOL)lent;
- (NSDecimalNumber *)absoluteAmount;

@end
