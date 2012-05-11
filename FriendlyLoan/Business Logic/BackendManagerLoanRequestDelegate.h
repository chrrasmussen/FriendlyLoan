//
//  BackendManagerLoanRequestDelegate.h
//  FriendlyLoan
//
//  Created by Christian Rasmussen on 07.05.12.
//  Copyright (c) 2012 Rasmussen I/O. All rights reserved.
//

#import <Foundation/Foundation.h>


@class BackendManager;
@class Loan;


@protocol BackendManagerLoanRequestDelegate <NSObject>

@optional
- (void)backendManager:(BackendManager *)backendManager displayLoanRequest:(Loan *)loan;

@end
