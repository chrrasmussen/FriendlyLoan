//
//  FLAddLoanTests.m
//  FriendlyLoan
//
//  Created by Christian Rasmussen on 04.07.12.
//  Copyright (c) 2012 Rasmussen I/O. All rights reserved.
//

#import "FLAddLoanTests.h"

@implementation FLAddLoanTests

- (void)setUp
{
    [super setUp];
    
    [MagicalRecord setupCoreDataStackWithInMemoryStore];
    NSManagedObjectContext *context = [NSManagedObjectContext defaultContext];
    
    self.addLoanInteractor = [[FLAddLoanInteractor alloc] initWithManagedObjectContext:context];
}

- (void)tearDown
{
    self.addLoanInteractor = nil;
    
    [MagicalRecord cleanUp];
    
    [super tearDown];
}

- (void)testAddLoan
{
    FLAddLoanRequestModel *request = [[FLAddLoanRequestModel alloc] init];
    request.amount = [NSDecimalNumber decimalNumberWithString:@"42.0"];
    request.friendID = @"friend1";
    request.categoryID = @1;
    request.note = @"note";
    
    [self.addLoanInteractor addLoanWithRequest:request delegate:self];
}

- (void)didAddLoanWithResponse:(FLAddLoanResponseModel *)response
{
    NSLog(@"%@%@", NSStringFromSelector(_cmd), response);
    STFail(@"Failes");
}

@end
