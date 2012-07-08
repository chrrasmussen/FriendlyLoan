//
//  FLLoanDetailsResponseModel.m
//  FriendlyLoan
//
//  Created by Christian Rasmussen on 04.07.12.
//  Copyright (c) 2012 Rasmussen I/O. All rights reserved.
//

#import "FLLoanDetailsResponseModel.h"

@implementation FLLoanDetailsResponseModel

- (NSString *)description
{
    return [NSString stringWithFormat:@"<%@: %x> lent:%@ amount:%@ friendID:%@ categoryID:%@ note:%@ createdAt:%@ updatedAt:%@", NSStringFromClass([self class]), (NSUInteger)self, self.lent, self.amount, self.friendID, self.categoryID, self.note, self.createdAt, self.updatedAt];
}

@end
