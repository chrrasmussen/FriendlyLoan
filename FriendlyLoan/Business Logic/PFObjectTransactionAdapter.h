//
//  TransactionPFObjectAdapter.h
//  FriendlyLoan
//
//  Created by Christian Rasmussen on 06.05.12.
//  Copyright (c) 2012 Rasmussen I/O. All rights reserved.
//

#import "Transaction.h"


@class PFObject;


@interface PFObjectTransactionAdapter : Transaction

- (id)initWithPFObject:(PFObject *)pfObject;

@end
