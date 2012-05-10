//
//  LoanManagerLocationDelegate.h
//  FriendlyLoan
//
//  Created by Christian Rasmussen on 25.02.12.
//  Copyright (c) 2012 Rasmussen I/O. All rights reserved.
//

#import <Foundation/Foundation.h>


@class LoanManager;


@protocol LoanManagerLocationServicesDelegate <NSObject>

@optional
- (void)loanManagerNeedLocationServices:(LoanManager *)loanManager;
- (void)loanManagerNeedLocationServicesForThisApp:(LoanManager *)loanManager;

@end
