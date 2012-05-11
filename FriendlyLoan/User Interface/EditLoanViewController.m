//
//  EditLoanViewController.m
//  FriendlyLoan
//
//  Created by Christian Rasmussen on 19.09.11.
//  Copyright (c) 2011 Rasmussen I/O. All rights reserved.
//

#import "EditLoanViewController.h"
#import "EditLoanViewControllerDelegate.h"

#import "LoanManager.h"


enum {
    kBorrowSegmentIndex = 0,
    kLendSegmentIndex
};


@implementation EditLoanViewController

@synthesize delegate;
@synthesize loan;
@synthesize saveBarButtonItem, lentSegmentedControl;


- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}


#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self updateViewInfo];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


#pragma mark - Override methods

- (void)setSaveButtonsEnabledState:(BOOL)enabled
{
    self.saveBarButtonItem.enabled = enabled;
}

- (void)updateLoanBasedOnViewInfo:(Loan *)theLoan
{
    [super updateLoanBasedOnViewInfo:theLoan];
    
    theLoan.updatedAt = [NSDate date];
}

#pragma mark - Actions

- (IBAction)cancel:(id)sender
{
    if ([self.delegate respondsToSelector:@selector(editLoanViewControllerDidCancel:)]) {
        [self.delegate editLoanViewControllerDidCancel:self];
    }
}

- (IBAction)save:(id)sender
{
    [self editLoan];
    
    if ([self.delegate respondsToSelector:@selector(editLoanViewControllerDidSave:)]) {
        [self.delegate editLoanViewControllerDidSave:self];
    }
}

- (IBAction)changeLentState:(id)sender
{
    self.lentStatus = ([self.lentSegmentedControl selectedSegmentIndex] == kLendSegmentIndex);
}


#pragma mark - Private methods

- (void)editLoan
{
    [[LoanManager sharedManager] updateLoan:self.loan withUpdateHandler:^(Loan *theLoan) {
        [self updateLoanBasedOnViewInfo:theLoan];
    }];
}

- (void)updateViewInfo
{
    // Update internal state
    self.lentStatus = [self.loan lentValue];
    [self updateSelectedFriendID:self.loan.friendID];
    [self updateSelectedCategoryID:self.loan.categoryID];
    
    // Update GUI
    self.amountTextField.text = [self.loan.absoluteAmount stringValue];
    self.lentSegmentedControl.selectedSegmentIndex = (self.lentStatus == YES) ? kLendSegmentIndex : kBorrowSegmentIndex;
    self.noteTextField.text = self.loan.note;
}

@end
