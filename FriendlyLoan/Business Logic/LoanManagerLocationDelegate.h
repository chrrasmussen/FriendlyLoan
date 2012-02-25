//
//  LoanManagerLocationDelegate.h
//  FriendlyLoan
//
//  Created by Christian Rasmussen on 25.02.12.
//  Copyright (c) 2012 Rasmussen I/O. All rights reserved.
//

#import <Foundation/Foundation.h>


@class LoanManager;


@protocol LoanManagerLocationDelegate <NSObject>

@optional
- (void)loanManagerNeedLocationServices:(LoanManager *)loanManager;

@end
