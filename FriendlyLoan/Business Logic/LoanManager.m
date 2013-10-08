//
//  FLCoreDataLoanManager.m
//  FriendlyLoan
//
//  Created by Christian Rasmussen on 15.07.12.
//  Copyright (c) 2012 Rasmussen I/O. All rights reserved.
//

#import "LoanManager.h"
#import "Loan.h"


@implementation LoanManager {
    NSManagedObjectContext *_managedObjectContext;
}

@synthesize locationDelegate;

- (id)initWithManagedObjectContext:(NSManagedObjectContext *)context 
{
    self = [super init];
    if (self) {
        _managedObjectContext = context;
    }
    return self;
}

- (id<FLPerson>)personForRecordID:(NSNumber *)recordID
{
    return nil;
}

- (id<FLCategory>)categoryForCategoryID:(NSNumber *)categoryID
{
    return nil;
}

- (id<FLLoan>)lendAmount:(NSDecimalNumber *)amount toPerson:(id<FLPerson>)person inCategory:(id<FLCategory>)category withNote:(NSString *)note
{
    Loan *loan = [self addLoanWithPerson:person category:category note:note];
    
    loan.absoluteAmount = amount;
    loan.lent = YES;
    
    return loan;
}

- (id<FLLoan>)borrowAmount:(NSDecimalNumber *)amount fromPerson:(id<FLPerson>)person inCategory:(id<FLCategory>)category withNote:(NSString *)note
{
    Loan *loan = [self addLoanWithPerson:person category:category note:note];
    
    loan.absoluteAmount = amount;
    loan.lent = NO;
    
    return loan;
}

- (id<FLLoan>)settleDebtForPerson:(id<FLPerson>)person
{
    // TODO: Get default category
    // TODO: Get debt for person
    
    Loan *loan = [self addLoanWithPerson:person category:nil note:nil];
    
    
    
    return loan;
}


#pragma mark - Private methods

- (Loan *)addLoanWithPerson:(id<FLPerson>)person category:(id<FLCategory>)category note:(NSString *)note
{
    Loan *loan = [Loan insertInManagedObjectContext:_managedObjectContext];
    
    // TODO: Fix person
    // TODO: Fix note
    
    loan.note = note;
    
    return loan;
}

@end