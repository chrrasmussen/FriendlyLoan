//
//  Transaction+CustomMethods.h
//  FriendlyLoan
//
//  Created by Christian Rasmussen on 10.09.11.
//  Copyright (c) 2011 Rasmussen I/O. All rights reserved.
//

#import "Transaction.h"


@interface Transaction (Custom)

- (NSString *)historySectionName;

+ (NSString *)friendNameForFriendID:(NSNumber *)friendID;
+ (UIImage *)friendImageForFriendID:(NSNumber *)friendID;
- (NSString *)friendName;

- (BOOL)lent;
- (NSDecimalNumber *)absoluteAmount;
- (NSString *)lentDescriptionString;
- (NSString *)lentPrepositionString;

- (BOOL)hasLocation;

@end
