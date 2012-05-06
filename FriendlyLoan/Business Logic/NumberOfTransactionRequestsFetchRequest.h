//
//  NumberOfTransactionRequestsFetchRequest.h
//  FriendlyLoan
//
//  Created by Christian Rasmussen on 06.05.12.
//  Copyright (c) 2012 Rasmussen I/O. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NumberOfTransactionRequestsFetchRequest : NSObject

+ (NSUInteger)fetchFromManagedObjectContext:(NSManagedObjectContext *)managedObjectContext;

@end
