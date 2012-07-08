//
//  FriendlyLoan.h
//  FriendlyLoan
//
//  Created by Christian Rasmussen on 09.07.12.
//  Copyright (c) 2012 Rasmussen I/O. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FLLoanManager.h"
#import "FLLoan.h"

@interface FriendlyLoan : NSObject

@property (nonatomic, strong, readonly) id<FLLoanManager> loanManager;
@property (nonatomic, strong, readonly) id<FLHistoryController> history;

@end
