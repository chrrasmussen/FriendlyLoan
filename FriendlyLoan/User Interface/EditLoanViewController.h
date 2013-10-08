//
//  EditLoanViewController.h
//  FriendlyLoan
//
//  Created by Christian Rasmussen on 19.09.11.
//  Copyright (c) 2011 Rasmussen I/O. All rights reserved.
//

#import "AddLoanViewController.h"


@protocol EditLoanViewControllerDelegate;
@protocol FLLoan;

@interface EditLoanViewController : AbstractLoanViewController <UIActionSheetDelegate>

@property (nonatomic, weak) id<EditLoanViewControllerDelegate> delegate;

@property (nonatomic, strong) id<FLLoan> loan;

@property (nonatomic, strong) IBOutlet UIBarButtonItem *saveBarButtonItem;
@property (nonatomic, strong) IBOutlet UISegmentedControl *lentSegmentedControl;

- (IBAction)cancel:(id)sender;
- (IBAction)save:(id)sender;
- (IBAction)changeLentState:(id)sender;
- (IBAction)deleteLoan:(id)sender;

@end
