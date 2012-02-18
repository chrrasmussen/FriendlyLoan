//
//  LoanManagerAttachLocationDelegate.h
//  FriendlyLoan
//
//  Created by Christian Rasmussen on 10.02.12.
//  Copyright (c) 2012 Rasmussen I/O. All rights reserved.
//

#import <Foundation/Foundation.h>


@class LoanManager;

@protocol LoanManagerAttachLocationDelegate <NSObject>

- (void)loanManager:(LoanManager *)loanManager didChangeAttachLocationValue:(BOOL)attachLocation;

@end
