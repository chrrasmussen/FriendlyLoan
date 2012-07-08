//
//  FLAddLoanRequestModel.m
//  FriendlyLoan
//
//  Created by Christian Rasmussen on 04.07.12.
//  Copyright (c) 2012 Rasmussen I/O. All rights reserved.
//

#import "FLAddLoanRequestModel.h"

@implementation FLAddLoanRequestModel

- (NSString *)description
{
    return [NSString stringWithFormat:@"<%@: %x> lent:%@ amount:%@ friendID:%@ categoryID:%@ note:%@", NSStringFromClass([self class]), (NSUInteger)self, self.lent, self.amount, self.friendID, self.categoryID, self.note];
}

@end
