//
//  EditLoanViewController.m
//  FriendlyLoan
//
//  Created by Christian Rasmussen on 19.09.11.
//  Copyright (c) 2011 Rasmussen I/O. All rights reserved.
//

#import "EditLoanViewController.h"
#import "EditLoanViewControllerDelegate.h"

#import "AppDelegate.h"
#import "Models.h"


enum {
    kBorrowSegmentIndex = 0,
    kLendSegmentIndex
};


@interface EditLoanViewController ()

- (void)editTransaction;
- (void)updateViewInfo;

@end


@implementation EditLoanViewController

@synthesize delegate;
@synthesize saveBarButtonItem, lentSegmentedControl;

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - Override methods

- (void)setSaveButtonsEnabledState:(BOOL)enabled
{
    self.saveBarButtonItem.enabled = enabled;
}

- (void)updateTransactionBasedOnViewInfo:(Transaction *)theTransaction
{
    [super updateTransactionBasedOnViewInfo:theTransaction];
    
    theTransaction.modifiedTimestamp = [NSDate date];
}

#pragma mark - Actions

- (IBAction)cancel:(id)sender
{
    if ([self.delegate respondsToSelector:@selector(editLoanViewControllerDidCancel:)])
        [self.delegate editLoanViewControllerDidCancel:self];
}

- (IBAction)save:(id)sender
{
    [self editTransaction];
    
    if ([self.delegate respondsToSelector:@selector(editLoanViewControllerDidSave:)])
        [self.delegate editLoanViewControllerDidSave:self];
}

- (IBAction)changeLentState:(id)sender
{
    self.lentState = ([self.lentSegmentedControl selectedSegmentIndex] == kLendSegmentIndex);
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
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
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

#pragma mark - Private methods

- (void)editTransaction
{
    [self updateTransactionBasedOnViewInfo:self.transaction];
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [appDelegate saveContext];
}

- (void)updateViewInfo
{
    // Update internal state
    self.lentState = self.transaction.lent;
    [self updateSelectedFriendID:self.transaction.friend.friendID];
    [self updateSelectedCategoryID:self.transaction.categoryID];
    
    // Update GUI
    self.amountTextField.text = [self.transaction.absoluteAmount stringValue];
    self.lentSegmentedControl.selectedSegmentIndex = (self.lentState == YES) ? kLendSegmentIndex : kBorrowSegmentIndex;
    self.noteTextField.text = self.transaction.note;
}

@end
