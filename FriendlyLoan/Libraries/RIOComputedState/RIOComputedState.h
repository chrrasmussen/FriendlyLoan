//
//  RIOComputedState.h
//  FriendlyLoan
//
//  Created by Christian Rasmussen on 10.05.12.
//  Copyright (c) 2012 Rasmussen I/O. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef id (^RIOComputedStateHandler)(id userState, id systemState);


@interface RIOComputedState : NSObject

@property (nonatomic) id userState;
@property (nonatomic) id systemState;
@property (nonatomic, readonly) id computedState;

- (id)initWithInitialUserState:(id)userState initialSystemState:(id)systemState computedStateHandler:(RIOComputedStateHandler)computedStateHandler;
- (id)initWithComputedStateHandler:(RIOComputedStateHandler)computedStateHandler;

@end
