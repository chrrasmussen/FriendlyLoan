//
//  Transaction.h
//  FriendlyLoan
//
//  Created by Christian Rasmussen on 06.10.11.
//  Copyright (c) 2011 Rasmussen I/O. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Location, Person;

@interface Transaction : NSManagedObject

@property (nonatomic, retain) NSDecimalNumber * amount;
@property (nonatomic, retain) NSNumber * categoryID;
@property (nonatomic, retain) NSDate * createdTimestamp;
@property (nonatomic, retain) NSDate * modifiedTimestamp;
@property (nonatomic, retain) NSString * note;
@property (nonatomic, retain) Location *location;
@property (nonatomic, retain) Person *friend;

@end
