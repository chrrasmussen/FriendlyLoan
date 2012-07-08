//
//  FLAddLoanRequestModel.h
//  FriendlyLoan
//
//  Created by Christian Rasmussen on 04.07.12.
//  Copyright (c) 2012 Rasmussen I/O. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FLAddLoanRequestModel : NSObject

@property (nonatomic, strong) NSNumber *lent;
@property (nonatomic, strong) NSDecimalNumber *amount;
@property (nonatomic, strong) NSString *friendID;
@property (nonatomic, strong) NSNumber *categoryID;
@property (nonatomic, strong) NSString *note;

@end
