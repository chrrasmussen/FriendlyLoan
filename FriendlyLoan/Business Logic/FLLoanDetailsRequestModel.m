//
//  FLLoanDetailsRequestModel.m
//  FriendlyLoan
//
//  Created by Christian Rasmussen on 04.07.12.
//  Copyright (c) 2012 Rasmussen I/O. All rights reserved.
//

#import "FLLoanDetailsRequestModel.h"

@implementation FLLoanDetailsRequestModel

- (NSString *)description
{
    return [NSString stringWithFormat:@"<%@: %x> loanID:%@", NSStringFromClass([self class]), (NSUInteger)self, self.loanID];
}

@end
