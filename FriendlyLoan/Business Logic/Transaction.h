//
//  Transaction.h
//  FriendlyLoan
//
//  Created by Christian Rasmussen on 08.11.11.
//  Copyright (c) 2011 Rasmussen I/O. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Friend, Location;

@interface Transaction : NSManagedObject

@property (nonatomic, retain) NSDecimalNumber * amount;
@property (nonatomic, retain) NSNumber * categoryID;
@property (nonatomic, retain) NSDate * createdTimestamp;
@property (nonatomic, retain) NSDate * modifiedTimestamp;
@property (nonatomic, retain) NSString * note;
@property (nonatomic, retain) NSNumber * settled;
@property (nonatomic, retain) Friend *friend;
@property (nonatomic, retain) Location *location;

@end
