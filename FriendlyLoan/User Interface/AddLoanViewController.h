//
//  AddLoanViewController.h
//  FriendlyLoan
//
//  Created by Christian Rasmussen on 09.09.11.
//  Copyright (c) 2011 Rasmussen I/O. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AbstractLoanViewController.h"

#import "LoanManagerAttachLocationDelegate.h"


@interface AddLoanViewController : AbstractLoanViewController <LoanManagerAttachLocationDelegate>

@property (nonatomic, strong) IBOutlet UIBarButtonItem *borrowBarButtonItem;
@property (nonatomic, strong) IBOutlet UIBarButtonItem *lendBarButtonItem;
@property (nonatomic, strong) IBOutlet UISwitch *attachLocationSwitch;
@property (nonatomic, strong) IBOutlet UISwitch *shareLoanSwitch;

- (void)popToBlankViewControllerAnimated:(BOOL)animated;

- (IBAction)textFieldDidBeginEditing:(id)sender;
- (IBAction)borrow:(id)sender;
- (IBAction)lend:(id)sender;

- (IBAction)changeAttachLocationValue:(UISwitch *)sender;
- (IBAction)changeShareLoanValue:(UISwitch *)sender;
- (IBAction)detailsViewControllerAdd:(id)sender;

@end
