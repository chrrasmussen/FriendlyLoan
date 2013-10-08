//
//  FLLoanManagerTests.h
//  FriendlyLoan
//
//  Created by Christian Rasmussen on 04.07.12.
//  Copyright (c) 2012 Rasmussen I/O. All rights reserved.
//

#import <SenTestingKit/SenTestingKit.h>


@protocol FLLoanManager;
@class LocationDelegateMock;
@class PersonMock;
@class CategoryMock;


@interface LoanManagerTests : SenTestCase

@property (nonatomic, strong) id<FLLoanManager> loanManager;

@property (nonatomic, strong) LocationDelegateMock *locationDelegate;
@property (nonatomic, strong) PersonMock *person;
@property (nonatomic, strong) CategoryMock *category;

@end
