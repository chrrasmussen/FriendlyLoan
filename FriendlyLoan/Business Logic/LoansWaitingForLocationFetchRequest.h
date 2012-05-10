//
//  LoansWaitingForLocationFetchRequest.h
//  FriendlyLoan
//
//  Created by Christian Rasmussen on 10.02.12.
//  Copyright (c) 2012 Rasmussen I/O. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface LoansWaitingForLocationFetchRequest : NSObject

+ (NSArray *)fetchFromManagedObjectContext:(NSManagedObjectContext *)managedObjectContext;

@end
