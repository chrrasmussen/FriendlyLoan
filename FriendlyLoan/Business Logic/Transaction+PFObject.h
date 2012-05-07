//
//  Transaction+PFObject.h
//  FriendlyLoan
//
//  Created by Christian Rasmussen on 02.05.12.
//  Copyright (c) 2012 Rasmussen I/O. All rights reserved.
//

#import "Transaction.h"


@class PFObject;

@interface Transaction (PFObject)

- (PFObject *)PFObjectForValues;
- (void)setValuesForPFObject:(PFObject *)pfObject;

@end
