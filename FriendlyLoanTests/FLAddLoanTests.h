//
//  FLAddLoanTests.h
//  FriendlyLoan
//
//  Created by Christian Rasmussen on 04.07.12.
//  Copyright (c) 2012 Rasmussen I/O. All rights reserved.
//

#import <SenTestingKit/SenTestingKit.h>
#import "FLAddLoanInteractor.h"

@interface FLAddLoanTests : SenTestCase <FLAddLoanResponseBoundary>

@property (nonatomic, strong) id<FLAddLoanRequestBoundary> addLoanInteractor;
@end
