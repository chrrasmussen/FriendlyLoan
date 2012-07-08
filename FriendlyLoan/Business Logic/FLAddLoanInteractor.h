//
//  FLAddLoanInteractor.h
//  FriendlyLoan
//
//  Created by Christian Rasmussen on 04.07.12.
//  Copyright (c) 2012 Rasmussen I/O. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FLAddLoanRequestBoundary.h"
#import "FLAddLoanResponseBoundary.h"
#import "FLAddLoanRequestModel.h"
#import "FLAddLoanResponseModel.h"

@interface FLAddLoanInteractor : NSObject <FLAddLoanRequestBoundary>

- (id)initWithManagedObjectContext:(NSManagedObjectContext *)context;

@end
