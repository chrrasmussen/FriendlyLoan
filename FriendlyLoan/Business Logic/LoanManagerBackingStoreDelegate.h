//
//  LoanManagerBackingStoreDelegate.h
//  FriendlyLoan
//
//  Created by Christian Rasmussen on 09.02.12.
//  Copyright (c) 2012 Rasmussen I/O. All rights reserved.
//

#import <Foundation/Foundation.h>


@class NSManagedObjectContext;

@protocol LoanManagerBackingStoreDelegate <NSObject>

- (NSManagedObjectContext *)managedObjectContext;

@end
