//
//  FriendLookup.m
//  FriendlyLoan
//
//  Created by Christian Rasmussen on 29.05.12.
//  Copyright (c) 2012 Rasmussen I/O. All rights reserved.
//

#import "FriendLookup.h"


@implementation FriendLookup

@dynamic user, hashedEmail, hashedFacebookId;

+ (NSString *)databaseClassName
{
    return @"FriendLookup";
}

@end
