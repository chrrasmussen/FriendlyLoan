//
//  LoanRequestViewController.h
//  FriendlyLoan
//
//  Created by Christian Rasmussen on 11.05.12.
//  Copyright (c) 2012 Rasmussen I/O. All rights reserved.
//

#import "AbstractLoanViewController.h"


@interface LoanRequestViewController : AbstractLoanViewController

//@property (nonatomic, weak) id<LoanRequestViewControllerDelegate> delegate;

@property (nonatomic, strong) Loan *loan;

@property (nonatomic, strong) IBOutlet UIBarButtonItem *rejectBarButtonItem;
@property (nonatomic, strong) IBOutlet UIBarButtonItem *acceptBarButtonItem;
@property (nonatomic, strong) IBOutlet UISegmentedControl *lentSegmentedControl;
@property (nonatomic, strong) IBOutlet UIButton *decideLaterButton;

- (IBAction)reject:(id)sender;
- (IBAction)accept:(id)sender;
- (IBAction)changeLentState:(id)sender;
- (IBAction)decideLater:(id)sender;

@end
