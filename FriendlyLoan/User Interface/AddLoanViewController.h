//
//  AddLoanViewController.h
//  FriendlyLoan
//
//  Created by Christian Rasmussen on 09.09.11.
//  Copyright (c) 2011 Rasmussen I/O. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AbstractLoanViewController.h"


@protocol FLLoanManager;


@interface AddLoanViewController : AbstractLoanViewController

@property (nonatomic, strong) IBOutlet UIBarButtonItem *borrowBarButtonItem;
@property (nonatomic, strong) IBOutlet UIBarButtonItem *lendBarButtonItem;
@property (nonatomic, strong) IBOutlet UISwitch *addLocationSwitch;
@property (nonatomic, strong) IBOutlet UISwitch *shareLoanSwitch;

@property (nonatomic, strong) id<FLLoanManager> loanManager;

- (void)popToBlankViewControllerAnimated:(BOOL)animated;

- (IBAction)textFieldDidBeginEditing:(id)sender;
- (IBAction)borrow:(id)sender;
- (IBAction)lend:(id)sender;

- (IBAction)changeAddLocationValue:(UISwitch *)sender;
- (IBAction)changeShareLoanValue:(UISwitch *)sender;
- (IBAction)detailsViewControllerAdd:(id)sender;

@end
