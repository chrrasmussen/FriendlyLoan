//
//  Transaction+CustomMethods.h
//  FriendlyLoan
//
//  Created by Christian Rasmussen on 10.09.11.
//  Copyright (c) 2011 Rasmussen I/O. All rights reserved.
//

#import "Transaction.h"
#import "MapKit/MapKit.h"


@interface Transaction (Custom) <MKAnnotation>

- (NSString *)historySectionName;

+ (NSString *)personNameForID:(int)personID;
- (NSString *)personName;

- (BOOL)lent;
- (NSDecimalNumber *)absoluteAmount;

- (BOOL)hasLocation;

@end
