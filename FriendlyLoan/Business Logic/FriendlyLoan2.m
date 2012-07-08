//
//  FriendlyLoan.m
//  FriendlyLoan
//
//  Created by Christian Rasmussen on 05.07.12.
//  Copyright (c) 2012 Rasmussen I/O. All rights reserved.
//

#import "FriendlyLoan2.h"
#import <CoreLocation/CoreLocation.h>
#import "FLAddLoanRequestBoundary.h"
#import "FLAddLoanInteractor.h"
#import "FLLoanDetailsRequestBoundary.h"
#import "FLLoanDetailsInteractor.h"

@implementation FriendlyLoan2 {
    NSManagedObjectContext *_context;
    id<FLAddLoanRequestBoundary> _addLoan;
    id<FLLoanDetailsRequestBoundary> _loanDetails;
}

- (id)initWithManagedObjectContext:(NSManagedObjectContext *)context
{
    self = [super init];
    if (self) {
        _context = context;
        _addLoan = [[FLAddLoanInteractor alloc] initWithManagedObjectContext:context];
        _loanDetails = [[FLLoanDetailsInteractor alloc] initWithManagedObjectContext:context];
    }
    return self;
}

- (void)addLoan:(FLAddLoanRequestModel *)request completion:(void (^)(FLAddLoanResponseModel *))response
{
//    [_addLoan addLoanWithRequest:request delegate:self];
}

- (void)getLoan:(FLLoanDetailsRequestModel *)request completion:(void (^)(FLLoanDetailsResponseModel *))response
{
//    [_loanDetails getLoanWithRequest:request delegate:self];
}

@end
