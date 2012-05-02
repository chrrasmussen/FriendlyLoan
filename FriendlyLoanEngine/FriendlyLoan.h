//
//  FriendlyLoan.h
//  FriendlyLoan
//
//  Created by Christian Rasmussen on 14.06.11.
//  Copyright 2011 Rasmussen I/O. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Transaction.h"


@class FriendlyLoanStore;

@interface FriendlyLoan : NSObject

- (id)initWithModel:(FriendlyLoanStore *)model;

+ (id)sharedInstance;
+ (void)setSharedInstance:(FriendlyLoan *)instance;

// Application logic
- (void)terminate;

- (Transaction *)newTransaction;
- (void)addTransaction:(Transaction *)transaction;//WithPerson:(NSString *)person value:(NSString *)value lent:(BOOL)lent;
- (NSArray *)fetchTransactions;

// TODO: Temp
- (void)tempReset;

@end
