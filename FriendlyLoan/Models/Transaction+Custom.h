//
//  Transaction+CustomMethods.h
//  FriendlyLoan
//
//  Created by Christian Rasmussen on 10.09.11.
//  Copyright (c) 2011 Rasmussen I/O. All rights reserved.
//

#import "Transaction.h"


@interface Transaction (Custom) <NSCopying>

- (id)copyWithZone:(NSZone *)zone;

- (NSString *)historySectionName;

- (BOOL)lent;
- (NSDecimalNumber *)absoluteAmount;
- (NSString *)lentDescriptionString;
- (NSString *)lentPrepositionString;

@end