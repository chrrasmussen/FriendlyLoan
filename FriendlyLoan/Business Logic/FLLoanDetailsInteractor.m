//
//  FLLoanDetailsInteractor.m
//  FriendlyLoan
//
//  Created by Christian Rasmussen on 04.07.12.
//  Copyright (c) 2012 Rasmussen I/O. All rights reserved.
//

#import "FLLoanDetailsInteractor.h"
#import "FLLoanDetailsResponseBoundary.h"
#import "FLLoanDetailsRequestModel.h"
#import "FLLoanDetailsResponseModel.h"

@implementation FLLoanDetailsInteractor {
    NSManagedObjectContext *_context;
}

- (id)initWithManagedObjectContext:(NSManagedObjectContext *)context
{
    self = [super init];
    if (self) {
        _context = context;
    }
    return self;
}

- (void)getLoanWithRequest:(FLLoanDetailsRequestModel *)request delegate:(id<FLLoanDetailsResponseBoundary>)delegate
{
    NSLog(@"%@", NSStringFromSelector(_cmd));
}

@end
