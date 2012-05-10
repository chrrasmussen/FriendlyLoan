//
//  Loan+PFObject.h
//  FriendlyLoan
//
//  Created by Christian Rasmussen on 02.05.12.
//  Copyright (c) 2012 Rasmussen I/O. All rights reserved.
//

#import "Loan.h"


@class PFObject;

@interface Loan (PFObject)

- (PFObject *)PFObjectForValues;
- (void)setValuesForPFObject:(PFObject *)pfObject;

@end
