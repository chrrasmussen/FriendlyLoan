//
//  FLLoanManagerTests.m
//  FriendlyLoan
//
//  Created by Christian Rasmussen on 04.07.12.
//  Copyright (c) 2012 Rasmussen I/O. All rights reserved.
//

#import "LoanManagerTests.h"

#import <CoreLocation/CoreLocation.h>
#import "FriendlyLoan.h"
#import "LocationDelegateMock.h"
#import "PersonMock.h"
#import "CategoryMock.h"

// FIXME: Temp
#define MR_SHORTHAND 1
#define MR_ENABLE_ACTIVE_RECORD_LOGGING 0
#import "CoreData+MagicalRecord.h"


@implementation LoanManagerTests

- (void)setUp
{
    [super setUp];
    
    [MagicalRecord setupCoreDataStackWithInMemoryStore];
    NSManagedObjectContext *context = [NSManagedObjectContext defaultContext];
    
    // TODO: Fix latitude/longitude
    self.locationDelegate = [[LocationDelegateMock alloc] init];
    self.locationDelegate.location = [[CLLocation alloc] initWithLatitude:0 longitude:0];
    
    LoanManager *loanManager = [[LoanManager alloc] initWithManagedObjectContext:context];
    loanManager.locationDelegate = self.locationDelegate;
    
    self.person = [[PersonMock alloc] init];
    self.category = [[CategoryMock alloc] init];
    
    self.loanManager = loanManager;
}

- (void)tearDown
{
    self.loanManager = nil;
    
    [MagicalRecord cleanUp];
    
    [super tearDown];
}


#pragma mark - Tests

//- (void)testAddLoan
//{
//    NSDecimalNumber *amount = [NSDecimalNumber decimalNumberWithString:@"37.0"];
//    NSNumber *friendID = @5;
//    NSNumber *categoryID = @0;
//    NSString *note = @"Note";
//    
//    id<FLLoan> loan = [self.loanManager addLoanWithAmount:amount friendID:friendID categoryID:categoryID note:note];
//    
//    STAssertEqualObjects(loan.amount, amount, @"bad amount");
////    STAssertEqualObjects(loan.friendID, friendID, @"bad friendID");
////    STAssertEqualObjects(loan.categoryID, categoryID, @"bad categoryID");
//    STAssertEqualObjects(loan.note, note, @"bad note");
//}

- (void)testSettleDebt
{
//    NSDecimalNumber *amount = [NSDecimalNumber decimalNumberWithString:@"37.0"];
//    NSNumber *friendID = @5;
//    NSNumber *categoryID = @0;
//    NSString *note = @"Note";
//    
//    id<FLLoan> addedLoan = [self.loanManager addLoanWithAmount:amount friendID:friendID categoryID:categoryID note:note];
//    
//    id<FLLoan> settledLoan = [self.loanManager settleDebtForFriendID:friendID];
    NSLog(@"Test");
}

- (void)testNote
{
    NSString *note = @"Test Note";
    
    id<FLLoan> loan = [self.loanManager lendAmount:nil toPerson:nil inCategory:nil withNote:note];
    
    STAssertEqualObjects(loan.note, note, @"bad note");
}

- (void)testLendAmount
{
    NSDecimalNumber *positiveAmount = [NSDecimalNumber decimalNumberWithString:@"37.0"];
    
    id<FLLoan> loan = [self.loanManager lendAmount:positiveAmount toPerson:nil inCategory:nil withNote:nil];
    
    STAssertEqualObjects(loan.amount, positiveAmount, @"bad amount");
    STAssertEqualObjects(loan.absoluteAmount, positiveAmount, @"bad absoluteAmount");
    STAssertEquals(loan.lent, YES, @"bad lent");
}

- (void)testBorrowAmount
{
    NSDecimalNumber *positiveAmount = [NSDecimalNumber decimalNumberWithString:@"37.0"];
    NSDecimalNumber *negativeAmount = [NSDecimalNumber decimalNumberWithString:@"-37.0"];
    
    id<FLLoan> loan = [self.loanManager borrowAmount:positiveAmount fromPerson:nil inCategory:nil withNote:nil];
    
    STAssertEqualObjects(loan.amount, negativeAmount, @"bad amount");
    STAssertEqualObjects(loan.absoluteAmount, positiveAmount, @"bad absoluteAmount");
    STAssertEquals(loan.lent, NO, @"bad lent");
}

- (void)testAmount
{
    NSDecimalNumber *positiveAmount = [NSDecimalNumber decimalNumberWithString:@"37.0"];
    NSDecimalNumber *negativeAmount = [NSDecimalNumber decimalNumberWithString:@"-37.0"];
    
    id<FLLoan> loan = [self.loanManager lendAmount:positiveAmount toPerson:nil inCategory:nil withNote:nil];
    
    loan.amount = negativeAmount;
    
    STAssertEqualObjects(loan.amount, negativeAmount, @"bad amount");
    STAssertEqualObjects(loan.absoluteAmount, positiveAmount, @"bad absoluteAmount");
    STAssertEquals(loan.lent, NO, @"bad lent");
}

- (void)testAbsoluteAmount
{
    NSDecimalNumber *positiveAmount = [NSDecimalNumber decimalNumberWithString:@"37.0"];
    NSDecimalNumber *negativeAmount = [NSDecimalNumber decimalNumberWithString:@"-37.0"];
    
    id<FLLoan> loan = [self.loanManager lendAmount:positiveAmount toPerson:nil inCategory:nil withNote:nil];
    
    loan.absoluteAmount = negativeAmount;
    
    STAssertEqualObjects(loan.amount, positiveAmount, @"bad amount");
    STAssertEqualObjects(loan.absoluteAmount, positiveAmount, @"bad absoluteAmount");
    STAssertEquals(loan.lent, YES, @"bad lent");
}

- (void)testLentFlag
{
    NSDecimalNumber *positiveAmount = [NSDecimalNumber decimalNumberWithString:@"37.0"];
    NSDecimalNumber *negativeAmount = [NSDecimalNumber decimalNumberWithString:@"-37.0"];
    
    id<FLLoan> loan = [self.loanManager lendAmount:positiveAmount toPerson:nil inCategory:nil withNote:nil];
    
    loan.lent = NO;
    
    STAssertEqualObjects(loan.amount, negativeAmount, @"bad amount");
    STAssertEqualObjects(loan.absoluteAmount, positiveAmount, @"bad absoluteAmount");
    STAssertEquals(loan.lent, NO, @"bad lent");
}

//- (void)testLocation
//{
//    
//}


@end
