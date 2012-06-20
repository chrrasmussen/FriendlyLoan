//
//  RIOComputedState.m
//  FriendlyLoan
//
//  Created by Christian Rasmussen on 10.05.12.
//  Copyright (c) 2012 Rasmussen I/O. All rights reserved.
//

#import "RIOComputedState.h"


@implementation RIOComputedState {
    RIOComputedStateHandler _computedStateHandler; 
}


#pragma mark - Creating calculated state instance

// Designated initializer
- (id)initWithInitialUserState:(id)userState systemState:(id)systemState computedStateHandler:(RIOComputedStateHandler)computedStateHandler
{
    self = [super init];
    if (self) {
        _userState = userState;
        _systemState = systemState;
        _computedStateHandler = computedStateHandler;
    }
    return self;
}

- (id)initWithComputedStateHandler:(RIOComputedStateHandler)computedStateHandler
{
    return [self initWithInitialUserState:nil systemState:nil computedStateHandler:computedStateHandler];
}

- (id)init
{
    NSString *reason = [NSString stringWithFormat:@"-init is not a valid initializer for the class %@", [self class]];
    @throw [NSException exceptionWithName:NSInternalInconsistencyException reason:reason userInfo:nil];
}


#pragma mark - Computed state

+ (NSSet *)keyPathsForValuesAffectingComputedState
{
    return [NSSet setWithObjects:@"userState", @"systemState", nil];
}

- (id)computedState
{
    return _computedStateHandler(self.userState, self.systemState);
}

@end
