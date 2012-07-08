//
//  FLAddLoanResponseModel.h
//  FriendlyLoan
//
//  Created by Christian Rasmussen on 04.07.12.
//  Copyright (c) 2012 Rasmussen I/O. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FLAddLoanResponseModel : NSObject

@property (nonatomic, strong) NSManagedObjectID *loanID;
@property (nonatomic, strong) NSError *error;

@end
