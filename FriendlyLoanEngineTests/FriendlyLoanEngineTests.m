//
//  FriendlyLoanEngineTests.m
//  FriendlyLoanEngineTests
//
//  Created by Christian Rasmussen on 14.06.11.
//  Copyright 2011 Rasmussen I/O. All rights reserved.
//

#import "FriendlyLoanEngineTests.h"
#import "FriendlyLoan.h"
#import "FriendlyLoanStore.h"


@implementation FriendlyLoanEngineTests

- (void)setUp
{
    [super setUp];
    
    // Set-up code here.
    FriendlyLoanStore *store = [[FriendlyLoanStore alloc] initWithType:NSInMemoryStoreType];
    friendlyLoan = [[FriendlyLoan alloc] initWithModel:store];
}

- (void)tearDown
{
    // Tear-down code here.
    
    [super tearDown];
}

- (void)testSharedInstance
{
    id initialSharedInstance = [FriendlyLoan sharedInstance];
    STAssertNotNil(initialSharedInstance, nil);
    
    id newSharedInstance = [[FriendlyLoan alloc] init];
    STAssertNotNil(newSharedInstance, nil);
    
    STAssertTrue(initialSharedInstance != newSharedInstance, nil);
    
    [FriendlyLoan setSharedInstance:newSharedInstance];
    STAssertTrue([FriendlyLoan sharedInstance] != initialSharedInstance, nil);
}

@end
