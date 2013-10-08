//
//  FLCoreDataLoanManager.h
//  FriendlyLoan
//
//  Created by Christian Rasmussen on 15.07.12.
//  Copyright (c) 2012 Rasmussen I/O. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FLLoanManager.h"


@protocol FLLocationDelegate;


@interface LoanManager : NSObject <FLLoanManager>

- (id)initWithManagedObjectContext:(NSManagedObjectContext *)context;

@end