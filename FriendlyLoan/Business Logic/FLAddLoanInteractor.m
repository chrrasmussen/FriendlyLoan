//
//  FLAddLoanInteractor.m
//  FriendlyLoan
//
//  Created by Christian Rasmussen on 04.07.12.
//  Copyright (c) 2012 Rasmussen I/O. All rights reserved.
//

#import "FLAddLoanInteractor.h"

@implementation FLAddLoanInteractor {
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


#pragma mark - FLAddLoanRequestBoundary

- (void)addLoanWithRequest:(FLAddLoanRequestModel *)request delegate:(id<FLAddLoanResponseBoundary>)delegate
{
    NSLog(@"Adding request:%@", request);
    
//    [self callback:delegate];
    [self performSelector:@selector(callback) withObject:delegate afterDelay:1.0];
}

- (void)callback:(id<FLAddLoanResponseBoundary>)delegate
{
    FLAddLoanResponseModel *response = [[FLAddLoanResponseModel alloc] init];
    response.loanID = nil;
    response.error = [NSError errorWithDomain:@"FLErrorDomain" code:0 userInfo:nil];
    
    [delegate didAddLoanWithResponse:response];
}

//- (void)addLoanWithData:(NSDictionary *)data completion:(FLAddLoanCompletionBlock)completion
//{
//    // TODO: Read data
//    // TODO: Validate loan
//    // TODO: Add loan as entity to database
//    // TODO: Return a loan object with all parameters (including full name, date etc.
//}

@end
