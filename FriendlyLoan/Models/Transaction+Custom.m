//
//  Transaction+CustomMethods.m
//  FriendlyLoan
//
//  Created by Christian Rasmussen on 10.09.11.
//  Copyright (c) 2011 Rasmussen I/O. All rights reserved.
//

#import "Transaction+Custom.h"
#import "NSDecimalNumber+RIOAdditions.h"

#import "LoanManager.h"
#import "RIORelativeDate.h"


@implementation Transaction (Custom)

#pragma mark - History methods

// TODO: Replace with RIORelativeDate
- (NSString *)historySectionName
{
//    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//    [formatter setDateFormat:@"d MMMM yyyy"];
//    NSString *formattedDateString = [formatter stringFromDate:self.createdTimestamp];
    return [self.createdTimestamp relativeDate];
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

#pragma mark - Convenience methods

- (void)addFriendID:(NSNumber *)friendID
{
    [[LoanManager sharedManager] addFriendID:friendID forTransaction:self];
}

- (void)addCurrentLocation
{
    [[LoanManager sharedManager] addCurrentLocationForTransaction:self];
}

@end
