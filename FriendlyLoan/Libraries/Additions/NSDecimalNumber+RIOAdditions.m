//
//  NSDecimalNumber+RIOAdditions.m
//  FriendlyLoan
//
//  Created by Christian Rasmussen on 13.09.11.
//  Copyright (c) 2011 Rasmussen I/O. All rights reserved.
//

#import "NSDecimalNumber+RIOAdditions.h"

@implementation NSDecimalNumber (RIOAdditions)

- (NSDecimalNumber *)decimalNumberByNegating
{
    NSDecimalNumber *negativeOne = [[NSDecimalNumber alloc] initWithMantissa:1 exponent:0 isNegative:YES];
    return [self decimalNumberByMultiplyingBy:negativeOne];
}

- (BOOL)isNegative
{
    return ([self compare:[NSDecimalNumber zero]] == NSOrderedAscending);
}

@end
