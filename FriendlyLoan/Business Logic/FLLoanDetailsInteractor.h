//
//  FLLoanDetailsInteractor.h
//  FriendlyLoan
//
//  Created by Christian Rasmussen on 04.07.12.
//  Copyright (c) 2012 Rasmussen I/O. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FLLoanDetailsRequestBoundary.h"

@interface FLLoanDetailsInteractor : NSObject <FLLoanDetailsRequestBoundary>

- (id)initWithManagedObjectContext:(NSManagedObjectContext *)context;

@end
