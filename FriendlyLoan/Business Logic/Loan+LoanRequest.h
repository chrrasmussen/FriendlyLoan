//
//  Loan+LoanRequest.h
//  FriendlyLoan
//
//  Created by Christian Rasmussen on 02.05.12.
//  Copyright (c) 2012 Rasmussen I/O. All rights reserved.
//

#import "Loan.h"
#import "LoanRequest.h"


@interface Loan (LoanRequest)

- (LoanRequest *)loanRequestForValues;
- (void)setValuesForLoanRequest:(LoanRequest *)loanRequest;

@end
