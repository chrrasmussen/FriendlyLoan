//
//  FLAddLoanRequestBoundary.h
//  FriendlyLoan
//
//  Created by Christian Rasmussen on 04.07.12.
//  Copyright (c) 2012 Rasmussen I/O. All rights reserved.
//

#import <Foundation/Foundation.h>

//typedef void(^FLAddLoanCompletionBlock)(NSDictionary *data);

@protocol FLAddLoanResponseBoundary;
@class FLAddLoanRequestModel;


@protocol FLAddLoanRequestBoundary <NSObject>

- (void)addLoanWithRequest:(FLAddLoanRequestModel *)request delegate:(id<FLAddLoanResponseBoundary>)delegate;

// completion:(FLAddLoanCompletionBlock)completion;
//- (void)addLoanWithData:(NSDictionary *)data delegate:(id<FLAddLoanDelegate>)delegate;

@end
