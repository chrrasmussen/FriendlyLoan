//
//  FLAddLoanResponseBoundary.h
//  FriendlyLoan
//
//  Created by Christian Rasmussen on 04.07.12.
//  Copyright (c) 2012 Rasmussen I/O. All rights reserved.
//

#import <Foundation/Foundation.h>

@class FLAddLoanResponseModel;

@protocol FLAddLoanResponseBoundary <NSObject>

- (void)didAddLoanWithResponse:(FLAddLoanResponseModel *)response;

@end
