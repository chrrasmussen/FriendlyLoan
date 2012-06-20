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

enum {
    kActionSheetDeleteLoanButtonIndex = 0,
    kActionSheetCancelButtonIndex
};


@implementation EditLoanViewController

@synthesize delegate;
@synthesize loan;
@synthesize saveBarButtonItem, lentSegmentedControl;


#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self addObserver:self forKeyPath:@"lentStatus" options:NSKeyValueObservingOptionNew context:NULL];
    
    [self updateViewInfo];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
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

#pragma mark - Observers

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    
    if ([keyPath isEqualToString:@"lentStatus"]) {
        self.lentSegmentedControl.selectedSegmentIndex = (self.lentStatus == YES) ? kLendSegmentIndex : kBorrowSegmentIndex;
    }
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

- (IBAction)deleteLoan:(id)sender
{
    NSString *cancelTitle = NSLocalizedString(@"Cancel", @"Cancel button title in action sheet in edit loan view controller");
    NSString *deleteTitle = NSLocalizedString(@"Delete Loan", @"Delete button title in action sheet in edit loan view controller");
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:cancelTitle destructiveButtonTitle:deleteTitle otherButtonTitles:nil];
    [actionSheet showInView:self.view];
}


#pragma mark - UIActionSheetDelegate methods

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == kActionSheetDeleteLoanButtonIndex) {
        [[LoanManager sharedManager] deleteLoan:self.loan];
        
        if ([self.delegate respondsToSelector:@selector(editLoanViewControllerDidDeleteLoan:)]) {
            [self.delegate editLoanViewControllerDidDeleteLoan:self];
        }
    }
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
    self.selectedFriendID = self.loan.friendID;
    self.selectedCategoryID = self.loan.categoryID;
    
    // Update GUI
    self.amountTextField.text = [[self.loan absoluteAmount] stringValue];
    self.noteTextField.text = self.loan.note;
}

@end
