//
//  FLLoan.h
//  FriendlyLoan
//
//  Created by Christian Rasmussen on 09.07.12.
//  Copyright (c) 2012 Rasmussen I/O. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FLPerson.h"
#import "FLCategory.h"


@class CLLocation;


@protocol FLLoan <NSObject>

// Amount
@property (nonatomic, strong) NSDecimalNumber *amount;
@property (nonatomic, strong) NSDecimalNumber *absoluteAmount;
@property (nonatomic, getter = isLent) BOOL lent;

// Friend
@property (nonatomic, strong) NSNumber *personID;
@property (nonatomic, readonly) id<FLPerson> person;

// Category
@property (nonatomic, strong) NSNumber *categoryID;
@property (nonatomic, readonly) id<FLCategory> category;

// Note
@property (nonatomic, strong) NSString *note;

// Location
@property (nonatomic, readonly, getter = shouldAddLocation) BOOL addLocation;
@property (nonatomic, readonly) CLLocation *location;

// Metadata
@property (nonatomic, readonly, getter = isSettled) BOOL settled;
@property (nonatomic, readonly) NSDate *createdAt;
@property (nonatomic, readonly) NSDate *updatedAt;

// Actions
- (void)save;
- (void)remove;

@end
