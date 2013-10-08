//
//  Loan.h
//  FriendlyLoan
//
//  Created by Christian Rasmussen on 15.07.12.
//  Copyright (c) 2012 Rasmussen I/O. All rights reserved.
//

#import "_Loan.h"
#import "FLLoan.h"


@interface Loan : _Loan <FLLoan>

//+ (id)insertInManagedObjectContext:(NSManagedObjectContext *)context;

//@property (nonatomic, readonly) NSDecimalNumber *absoluteAmount;
//@property (nonatomic, readonly) NSString *amountPresentation;
//@property (nonatomic, readonly) NSNumber *lent;

//@property (nonatomic, readonly) NSString *historySectionName;

@end
