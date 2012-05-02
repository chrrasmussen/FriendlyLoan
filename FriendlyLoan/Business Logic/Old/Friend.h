//
//  Friend.h
//  FriendlyLoan
//
//  Created by Christian Rasmussen on 06.02.12.
//  Copyright (c) 2012 Rasmussen I/O. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Transaction;

@interface Friend : NSManagedObject

@property (nonatomic, retain) NSNumber * friendID;
@property (nonatomic, retain) Transaction *transaction;

@end
