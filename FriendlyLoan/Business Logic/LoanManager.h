//
//  LoanManager.h
//  FriendlyLoan
//
//  Created by Christian Rasmussen on 09.02.12.
//  Copyright (c) 2012 Rasmussen I/O. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Models.h"


@protocol LoanManagerLocationDelegate, LoanManagerBackingStoreDelegate;

@interface LoanManager : NSObject

@property (nonatomic, weak) id<LoanManagerLocationDelegate> locationDelegate;
@property (nonatomic, weak) id<LoanManagerBackingStoreDelegate> backingStoreDelegate;

- (void)startUpdatingLocation;
- (void)stopUpdatingLocation;
- (void)cancelWaitingList;

@end
