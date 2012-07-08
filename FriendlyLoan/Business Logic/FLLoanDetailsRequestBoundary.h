//
//  FLLoanDetailsRequestBoundary.h
//  FriendlyLoan
//
//  Created by Christian Rasmussen on 04.07.12.
//  Copyright (c) 2012 Rasmussen I/O. All rights reserved.
//

#import <Foundation/Foundation.h>

@class FLLoanDetailsRequestModel;
@protocol FLLoanDetailsResponseBoundary;

@protocol FLLoanDetailsRequestBoundary <NSObject>

- (void)getLoanWithRequest:(FLLoanDetailsRequestModel *)request delegate:(id<FLLoanDetailsResponseBoundary>)delegate;

@end
