//
//  FLLoan.h
//  FriendlyLoan
//
//  Created by Christian Rasmussen on 08.07.12.
//  Copyright (c) 2012 Rasmussen I/O. All rights reserved.
//

#import <Foundation/Foundation.h>


@class CLLocation;


@protocol FLLoan <NSObject>

@property (nonatomic, strong) NSDecimalNumber *amount;
@property (nonatomic, strong) NSNumber *friendID;
@property (nonatomic, strong) NSNumber *categoryID;
@property (nonatomic, strong) NSString *note;
@property (nonatomic, strong) CLLocation *location;

@property (nonatomic, strong) NSNumber *settled;
@property (nonatomic, strong, readonly) NSDate *createdAt;
@property (nonatomic, strong) NSDate *updatedAt;

// History methods
- (NSString *)historySectionName;

// Lent methods
- (BOOL)lent;
- (NSDecimalNumber *)absoluteAmount;
- (NSString *)amountPresentation;

@end
