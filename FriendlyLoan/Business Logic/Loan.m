//
//  Loan.m
//  FriendlyLoan
//
//  Created by Christian Rasmussen on 10.09.11.
//  Copyright (c) 2011 Rasmussen I/O. All rights reserved.
//

#import "Loan.h"
#import <CoreData/CoreData.h>

#import "NSDecimalNumber+RIOAdditions.h"
#import "RIORelativeDate.h"


// TODO: Is this used?
const float kLoanLocationTimeLimit = 10*60;


@implementation Loan

#pragma mark - Creating and saving loans

+ (id)insertInManagedObjectContext:(NSManagedObjectContext *)context
{
    // Create a new loans with default properties
    Loan *loan = [super insertInManagedObjectContext:context];
    loan.createdAt = [NSDate date];
//    loan.updatedAt = [NSDate date];
    
    return loan;
}


#pragma mark - History methods

- (NSString *)historySectionName
{
    if (self.requestAcceptedValue == NO) {
        return [self.createdAt relativeDate];
    }
    else {
        return NSLocalizedString(@"Incoming Loans", @"Section name for loan requests in History tab");
    }
}


#pragma mark - Lent methods

- (BOOL)lentValue
{
    return ([self.amount isNegative] == NO);
}

- (NSDecimalNumber *)absoluteAmount
{
    return ([self lentValue] == YES) ? self.amount : [self.amount decimalNumberByNegating];
}

@end
