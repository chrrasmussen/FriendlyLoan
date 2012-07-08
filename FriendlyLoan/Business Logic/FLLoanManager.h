//
//  FLLoanManager.h
//  FriendlyLoan
//
//  Created by Christian Rasmussen on 09.07.12.
//  Copyright (c) 2012 Rasmussen I/O. All rights reserved.
//

#import <Foundation/Foundation.h>


@protocol FLLoan;
//@protocol FLHistory
@class CLLocation;

@protocol FLLoanManager <NSObject>

- (void)addLoanWithAmount:(NSDecimalNumber *)amount friendID:(NSString *)friendID categoryID:(NSNumber *)categoryID note:(NSString *)note location:(CLLocation *)location completion:(void (^)(void))completion;

- (void)settleWithFriendID:(NSString *)friendID completion:(void (^)(void))completion;

// Use save in FLLoan instead?
//- (void)updateLoan:(id<FLLoan>)loan

- (void)deleteLoan:(id<FLLoan>)loan;

//- (void)getSingleLoanWithParameters:

//- (void)getLoansWithParameters:



@end
