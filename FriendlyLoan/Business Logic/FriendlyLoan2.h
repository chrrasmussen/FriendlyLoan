//
//  FriendlyLoan.h
//  FriendlyLoan
//
//  Created by Christian Rasmussen on 05.07.12.
//  Copyright (c) 2012 Rasmussen I/O. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FLAddLoanRequestModel.h"
#import "FLAddLoanResponseModel.h"
#import "FLLoanDetailsRequestModel.h"
#import "FLLoanDetailsResponseModel.h"


@class CLLocation;

@interface FriendlyLoan2 : NSObject

- (id)initWithManagedObjectContext:(NSManagedObjectContext *)context;

- (void)addLoan:(FLAddLoanRequestModel *)request completion:(void (^)(FLAddLoanResponseModel *))response;

- (void)getLoan:(FLLoanDetailsRequestModel *)request completion:(void (^)(FLLoanDetailsResponseModel *))response;

//- (void)settleLoanWithParameters:

//- (void)deleteLoanWithParameters:

//- (void)updateLoanWithParameters:

//- (void)getSingleLoanWithParameters:

//- (void)getLoansWithParameters:

//- (void)addLoanWithAmount:(NSDecimalNumber *)amount friendID:(NSString *)friendID categoryID:(NSNumber *)categoryID note:(NSString *)note location:(CLLocation *)location completion:(void (^)(void))completion;
//
//- (void)settleWithFriendID:(NSString *)friendID completion:(void (^)(void))completion;

@end
