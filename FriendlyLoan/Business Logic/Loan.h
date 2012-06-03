//
//  Loan.h
//  FriendlyLoan
//
//  Created by Christian Rasmussen on 10.09.11.
//  Copyright (c) 2011 Rasmussen I/O. All rights reserved.
//

#import "_Loan.h"


extern const float kLoanLocationTimeLimit;


@interface Loan : _Loan

// Creating and saving loans
+ (id)insertInManagedObjectContext:(NSManagedObjectContext *)context;

// History methods
- (NSString *)historySectionName;

// Lent methods
- (BOOL)lentValue;
- (NSDecimalNumber *)absoluteAmount;
- (NSString *)amountPresentation;

@end
