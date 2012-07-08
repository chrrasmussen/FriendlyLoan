//
//  FLLoanDetailsResponseBoundary.h
//  FriendlyLoan
//
//  Created by Christian Rasmussen on 04.07.12.
//  Copyright (c) 2012 Rasmussen I/O. All rights reserved.
//

#import <Foundation/Foundation.h>

@class FLLoanDetailsResponseModel;

@protocol FLLoanDetailsResponseBoundary <NSObject>

- (void)didGetLoanWithResponse:(FLLoanDetailsResponseModel *)response;

@end
