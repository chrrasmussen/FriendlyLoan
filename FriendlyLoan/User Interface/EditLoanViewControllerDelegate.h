//
//  EditLoanViewControllerDelegate.h
//  FriendlyLoan
//
//  Created by Christian Rasmussen on 19.09.11.
//  Copyright (c) 2011 Rasmussen I/O. All rights reserved.
//

#import <Foundation/Foundation.h>


@class EditLoanViewController;

@protocol EditLoanViewControllerDelegate <NSObject>

@optional
- (void)editLoanViewControllerDidCancel:(EditLoanViewController *)editLoanViewController;
- (void)editLoanViewControllerDidSave:(EditLoanViewController *)editLoanViewController;
- (void)editLoanViewControllerDidDeleteLoan:(EditLoanViewController *)editLoanViewController;

@end
