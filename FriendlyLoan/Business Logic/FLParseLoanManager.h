//
//  FLParseLoanManager.h
//  FriendlyLoan
//
//  Created by Christian Rasmussen on 15.07.12.
//  Copyright (c) 2012 Rasmussen I/O. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FLLoanManager.h"


@protocol FLShareLoanDelegate;


@interface FLParseLoanManager : NSObject <FLLoanManager>

@property (nonatomic, weak) id<FLShareLoanDelegate> shareLoanDelegate;

- (id)initWithLoanManager:(id<FLLoanManager>)loanManager;

@end
