//
//  LoanRequest.m
//  FriendlyLoan
//
//  Created by Christian Rasmussen on 07.05.12.
//  Copyright (c) 2012 Rasmussen I/O. All rights reserved.
//

#import "LoanRequest.h"


@implementation LoanRequest

@dynamic amount, categoryId, location, note, recipient, sender, settled;

+ (NSString *)databaseClassName
{
    return @"LoanRequest";
}

@end
