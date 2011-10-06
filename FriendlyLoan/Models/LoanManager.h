//
//  Loan.h
//  FriendlyLoan
//
//  Created by Christian Rasmussen on 06.10.11.
//  Copyright (c) 2011 Rasmussen I/O. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

#import "Models.h"


@interface LoanManager : NSObject

@property (nonatomic, strong, readonly) NSManagedObjectContext *managedObjectContext;

+ (id)sharedManager;
+ (void)setSharedManager:(id)manager;

- (id)initWithManagedObjectContext:(NSManagedObjectContext *)context;

- (Transaction *)newTransaction;
- (Friend *)newFriend;
- (Location *)newLocation;

- (void)saveContext;

@end
