//
//  FLLoanManager.h
//  FriendlyLoan
//
//  Created by Christian Rasmussen on 09.07.12.
//  Copyright (c) 2012 Rasmussen I/O. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FLLocationDelegate.h"


@protocol FLLoan, FLPerson, FLCategory;
@class CLLocation;


@protocol FLLoanManager <NSObject>

@property (nonatomic, weak) id<FLLocationDelegate> locationDelegate;

- (id<FLPerson>)personForRecordID:(NSNumber *)recordID;
//- (id<FLPerson>)personForPersonUUID:(NSString *)personUUID;
//- (id<FLPerson>)newPersonWithFirstName:(NSString *)firstName lastName:(NSString *)lastName;

- (id<FLCategory>)categoryForCategoryID:(NSNumber *)categoryID;

- (id<FLLoan>)lendAmount:(NSDecimalNumber *)amount toPerson:(id<FLPerson>)person inCategory:(id<FLCategory>)category withNote:(NSString *)note;

- (id<FLLoan>)borrowAmount:(NSDecimalNumber *)amount fromPerson:(id<FLPerson>)person inCategory:(id<FLCategory>)category withNote:(NSString *)note;

- (id<FLLoan>)settleDebtForPerson:(id<FLPerson>)person;

@end