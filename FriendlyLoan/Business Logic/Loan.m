//
//  Loan.m
//  FriendlyLoan
//
//  Created by Christian Rasmussen on 15.07.12.
//  Copyright (c) 2012 Rasmussen I/O. All rights reserved.
//

#import "Loan.h"
#import <CoreLocation/CoreLocation.h>
#import <CoreData/CoreData.h>

#import "NSDecimalNumber+RIOAdditions.h"
//#import "RIORelativeDate.h" // TODO: Remove dependency?

//#import "FriendList.h" // TODO: Remove dependency?
//#import "CurrencyList.h" // TODO: Remove dependency?


@implementation Loan

@synthesize category;

#pragma mark - Creating and saving loans


- (void)awakeFromInsert
{
    // FIXME: Remove readonly?
//    [super setCreatedAt:[NSDate date]];
}

- (NSDecimalNumber *)absoluteAmount
{
    NSDecimalNumber *amount = (self.lent == YES) ? self.amount : [self.amount decimalNumberByNegating];
    return amount;
}

- (void)setAbsoluteAmount:(NSDecimalNumber *)amount
{
    NSDecimalNumber *absoluteAmount = [amount absoluteDecimalNumber];
    self.amount = (self.lent == YES) ? absoluteAmount : [absoluteAmount decimalNumberByNegating];
}

- (BOOL)isLent
{
    BOOL isLent = ([self.amount isNegative] == NO);
    return isLent;
}

- (void)setLent:(BOOL)lent
{
    if (self.lent != lent) {
        self.amount = [self.amount decimalNumberByNegating];
    }
}


#pragma mark - Location properties

// TODO: Implement
- (CLLocation *)location
{
    return nil;
}

// TODO: Implement
- (void)setLocation:(CLLocation *)location
{
    
}


#pragma mark - Actions

- (void)save
{
    self.updatedAt = [NSDate date];
    
    // TODO: Save
}

- (void)remove
{
    // TODO: Is this allowed?
//    [self.managedObjectContext delete:self];
}

//#pragma mark - History properties
//
//- (NSString *)historySectionName
//{
//    return [self.createdAt relativeDate];
//}

//#pragma mark - Amount properties
//
//- (NSDecimalNumber *)absoluteAmount
//{
//    return ([[self lent] isEqualToNumber:@YES]) ? self.amount : [self.amount decimalNumberByNegating];
//}
//
//- (NSString *)amountPresentation
//{
//    return [[CurrencyList currentCurrencyFormatter] stringFromNumber:[self absoluteAmount]];
//}

//#pragma mark - Creating and saving loans
//
//+ (id)insertInManagedObjectContext:(NSManagedObjectContext *)context
//{
//    // Create a new loans with default properties
//    Loan2 *loan = [super insertInManagedObjectContext:context];
//    loan.createdAt = [NSDate date];
//    //    loan.updatedAt = [NSDate date];
//
//    return loan;
//}
//
////- (void)setNote:(NSString *)note
////{
////    if ([note length] > 0) {
////        [super setNote:note];
////    }
////}
//
//+ (id)settleDebtForFriendID:(NSNumber *)friendID
//{
//    return nil;
//}
//
//
//#pragma mark - History methods
//
//- (NSString *)historySectionName
//{
//    return [self.createdAt relativeDate];
//}
//
//
//#pragma mark - Lent methods
//
//- (BOOL)lentValue
//{
//    return ([self.amount isNegative] == NO);
//}
//
//- (NSDecimalNumber *)absoluteAmount
//{
//    return ([self lentValue] == YES) ? self.amount : [self.amount decimalNumberByNegating];
//}
//
//- (NSString *)amountPresentation
//{
//    return [[CurrencyList currentCurrencyFormatter] stringFromNumber:[self absoluteAmount]];
//}

@end