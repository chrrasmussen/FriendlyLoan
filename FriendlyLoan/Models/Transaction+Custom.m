//
//  Transaction+CustomMethods.m
//  FriendlyLoan
//
//  Created by Christian Rasmussen on 10.09.11.
//  Copyright (c) 2011 Rasmussen I/O. All rights reserved.
//

#import "Transaction+Custom.h"
#import "NSDecimalNumber+RIOAdditions.h"

@implementation Transaction (Custom)

- (id)copyWithZone:(NSZone *)zone
{
    Transaction *copy = [[self class] allocWithZone:zone];
    
    
    return copy;
}

#pragma mark - Fix

// TODO: Replace with RIORelativeTime
- (NSString *)historySectionName
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"d MMMM yyyy"];
    NSString *formattedDateString = [formatter stringFromDate:self.createdTimestamp];
    
    return formattedDateString;
}

#pragma mark - Lent methods

- (BOOL)lent
{
    return ([self.amount isNegative] == NO);
}

- (NSDecimalNumber *)absoluteAmount
{
    return (self.lent == YES) ? self.amount: [self.amount decimalNumberByNegating];
}

- (NSString *)lentDescriptionString
{
    return (self.lent == YES) ? NSLocalizedString(@"Lent", nil) : NSLocalizedString(@"Borrowed", nil);
}

- (NSString *)lentPrepositionString
{
    return (self.lent == YES) ? NSLocalizedString(@"To", nil) : NSLocalizedString(@"From", nil);
}

@end
