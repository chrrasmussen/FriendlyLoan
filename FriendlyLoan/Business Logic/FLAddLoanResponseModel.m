//
//  FLAddLoanResponseModel.m
//  FriendlyLoan
//
//  Created by Christian Rasmussen on 04.07.12.
//  Copyright (c) 2012 Rasmussen I/O. All rights reserved.
//

#import "FLAddLoanResponseModel.h"

@implementation FLAddLoanResponseModel

- (NSString *)description
{
    return [NSString stringWithFormat:@"<%@: %x> loanID:%@ error:%@", NSStringFromClass([self class]), (NSUInteger)self, self.loanID, self.error];
}

@end
