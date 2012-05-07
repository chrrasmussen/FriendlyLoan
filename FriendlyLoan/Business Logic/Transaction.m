//
//  Transaction.m
//  FriendlyLoan
//
//  Created by Christian Rasmussen on 10.09.11.
//  Copyright (c) 2011 Rasmussen I/O. All rights reserved.
//

#import "Transaction.h"
#import <CoreData/CoreData.h>

#import "NSDecimalNumber+RIOAdditions.h"
#import "RIORelativeDate.h"


const float kTransactionLocationTimeLimit = 10*60;


@implementation Transaction

#pragma mark - Managed object life-cycle methods

//- (void)awakeFromInsert
//{
//    [super awakeFromInsert];
//    NSLog(@"%s", (char *)_cmd);
//}
//
//- (void)awakeFromFetch
//{
//    [super awakeFromFetch];
//    NSLog(@"%s", (char *)_cmd);
//}


#pragma mark - Creating and saving transaction

+ (id)insertInManagedObjectContext:(NSManagedObjectContext *)context
{
    // Create a new transaction with default properties
    Transaction *transaction = [super insertInManagedObjectContext:context];
    transaction.createdAt = [NSDate date];
//    transaction.updatedAt = [NSDate date];
//    NSLog(@"%s", (char *)_cmd);
    
    return transaction;
}


#pragma mark - History methods

- (NSString *)historySectionName
{
    if (self.requestAcceptedValue == NO) {
        return [self.createdAt relativeDate];
    }
    else {
        return NSLocalizedString(@"Incoming Loans", @"Section name for transaction requests in History tab");
    }
}

//#pragma mark - Location status methods
//
//- (TransactionLocationStatus)locationStatus
//{
//    if (self.location != nil)
//        return kTransactionLocationStatusFound;
//    else if ([self isLocating] == YES)
//        return kTransactionLocationStatusLocating;
//    else if ([self hasFailedToLocate] == YES)
//        return kTransactionLocationStatusNotFound;
//    else
//        return kTransactionLocationStatusNoLocation;
//}


#pragma mark - Lent methods

- (BOOL)lentValue
{
    return ([self.amount isNegative] == NO);
}

- (NSDecimalNumber *)absoluteAmount
{
    return ([self lentValue] == YES) ? self.amount : [self.amount decimalNumberByNegating];
}


//#pragma mark - Private methods
//
//- (BOOL)isLocating
//{
//    return ([self needLocation] && [self isRecentlyCreated]);
//}
//
//- (BOOL)hasFailedToLocate
//{
//    return ([self needLocation] && ![self isRecentlyCreated]);
//}
//
//- (BOOL)needLocation
//{
//    BOOL attachLocation = [self attachLocationValue];
//    BOOL hasLocation = (self.location != nil);
//    
//    return (attachLocation && !hasLocation);
//}
//
//- (BOOL)isRecentlyCreated
//{
//    NSTimeInterval timeInterval = [[NSDate date] timeIntervalSinceDate:self.createdAt];
//    BOOL isRecentlyCreated = (abs(timeInterval) < kTransactionLocationTimeLimit);
//    
//    return isRecentlyCreated;
//}

@end
