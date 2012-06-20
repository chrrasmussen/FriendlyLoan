//
//  Loan+Friend.m
//  FriendlyLoan
//
//  Created by Christian Rasmussen on 06.10.11.
//  Copyright (c) 2011 Rasmussen I/O. All rights reserved.
//

#import "Loan+Friend.h"

#import "FriendList.h"


@implementation Loan (Friend)

- (NSString *)friendFullName
{
    return [FriendList nameForFriendID:self.friendID];
}

@end
