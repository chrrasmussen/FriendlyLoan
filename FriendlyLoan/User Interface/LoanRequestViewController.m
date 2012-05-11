//
//  LoanRequestViewController.m
//  FriendlyLoan
//
//  Created by Christian Rasmussen on 11.05.12.
//  Copyright (c) 2012 Rasmussen I/O. All rights reserved.
//

#import "LoanRequestViewController.h"

#import "LoanManager.h"


enum {
    kBorrowSegmentIndex = 0,
    kLendSegmentIndex
};


@implementation LoanRequestViewController

//@synthesize delegate;
@synthesize loan;
@synthesize rejectBarButtonItem, acceptBarButtonItem, lentSegmentedControl, decideLaterButton;

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    [self updateViewInfo];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


#pragma mark - Override methods

- (void)setSaveButtonsEnabledState:(BOOL)enabled
{
    self.rejectBarButtonItem.enabled = enabled;
    self.acceptBarButtonItem.enabled = enabled;
}

- (void)updateLoanBasedOnViewInfo:(Loan *)theLoan
{
    [super updateLoanBasedOnViewInfo:theLoan];
    
    theLoan.updatedAt = [NSDate date];
}


#pragma mark - Actions

- (IBAction)reject:(id)sender
{
    NSLog(@"%@", NSStringFromSelector(_cmd));
}

- (IBAction)accept:(id)sender
{
    NSLog(@"%@", NSStringFromSelector(_cmd));
}

- (IBAction)changeLentState:(id)sender
{
    self.lentStatus = ([self.lentSegmentedControl selectedSegmentIndex] == kLendSegmentIndex);
}

- (IBAction)decideLater:(id)sender
{
    NSLog(@"%@", NSStringFromSelector(_cmd));
}


#pragma mark - Private methods

- (void)editLoan
{
//    [[LoanManager sharedManager] updateLoan:self.loan withUpdateHandler:^(Loan *theLoan) {
//        [self updateLoanBasedOnViewInfo:theLoan];
//    }];
}

- (void)updateViewInfo
{
//    // Update internal state
//    self.lentStatus = [self.loan lentValue];
//    [self updateSelectedFriendID:self.loan.friendID];
//    [self updateSelectedCategoryID:self.loan.categoryID];
//    
//    // Update GUI
//    self.amountTextField.text = [self.loan.absoluteAmount stringValue];
//    self.lentSegmentedControl.selectedSegmentIndex = (self.lentStatus == YES) ? kLendSegmentIndex : kBorrowSegmentIndex;
//    self.noteTextField.text = self.loan.note;
}

@end
