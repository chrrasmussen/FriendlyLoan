//
//  FriendlyLoanTests.m
//  FriendlyLoanTests
//
//  Created by Christian Rasmussen on 09.09.11.
//  Copyright (c) 2011 Rasmussen I/O. All rights reserved.
//

#import "FriendlyLoanTests.h"
#import "Models.h"

@implementation FriendlyLoanTests

- (void)setUp
{
    [super setUp];
    
    [MagicalRecord setupCoreDataStackWithInMemoryStore];
}

- (void)tearDown
{
    [MagicalRecord cleanUp];
    
    [super tearDown];
}

- (void)testExample
{
    Loan *loan = [Loan createEntity];
    loan.note = @"Test";
    [loan.managedObjectContext saveErrorHandler:^(NSError *error) {
        STAssertNil(error, @"Error");
    }];
    
    STAssertEqualObjects(@"Test", loan.note, @"Mismatching note");
//    STFail(@"Unit tests are not implemented yet in FriendlyLoanTests");
}

- (void)testExample2
{
    Loan *loan = [Loan createEntity];
    loan.note = @"Test2";
    [loan.managedObjectContext saveErrorHandler:^(NSError *error) {
        STAssertNil(error, @"Error2");
    }];
    
    STAssertEqualObjects(@"Test2", loan.note, @"Mismatching note2");
}

@end
