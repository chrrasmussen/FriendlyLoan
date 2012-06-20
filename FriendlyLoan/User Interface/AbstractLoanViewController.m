//
//  AbstractLoanViewController.m
//  FriendlyLoan
//
//  Created by Christian Rasmussen on 19.09.11.
//  Copyright (c) 2011 Rasmussen I/O. All rights reserved.
//

#import "AbstractLoanViewController.h"

#import "LoanManager.h"

#import "FriendList.h"
#import "CategoryList.h"

#import "FriendViewController.h"
#import "CategoryViewController.h"
#import "DetailsViewController.h"

#import "NSDecimalNumber+RIOAdditions.h"


const NSInteger kDefaultCategoryID = 0;


@implementation AbstractLoanViewController

@synthesize lentStatus, selectedFriendID, selectedCategoryID;
@synthesize amountTextField, friendValueLabel, categoryValueLabel, noteTextField;


#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
//    [self addObserver:self forKeyPath:@"amount" options:NSKeyValueObservingOptionNew context:NULL];
    [self addObserver:self forKeyPath:@"selectedFriendID" options:NSKeyValueObservingOptionNew context:NULL];
    [self addObserver:self forKeyPath:@"selectedCategoryID" options:NSKeyValueObservingOptionNew context:NULL];
//    [self addObserver:self forKeyPath:@"" options:<#(NSKeyValueObservingOptions)#> context:<#(void *)#>]
    
    [self resetFields];
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
    
    [self validateAmountAndFriend];
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
    if ([keyPath isEqualToString:@"selectedFriendID"]) {
        NSString *friendName = [FriendList nameForFriendID:self.selectedFriendID];
        if (friendName == nil) {
            friendName = NSLocalizedString(@"None Selected", @"Placeholder when no friends are selected in Add Loan-tab");
        }
        
        self.friendValueLabel.text = friendName;
    }
    else if ([keyPath isEqualToString:@"selectedCategoryID"]) {
        self.categoryValueLabel.text = [CategoryList nameForCategoryID:self.selectedCategoryID];
    }
}


#pragma mark - Helper methods for subclasses

- (void)hideKeyboard
{
    [self.tableView endEditing:YES];
}

- (void)validateAmountAndFriend
{
    BOOL enabled = (self.amountTextField.text.length > 0 && self.selectedFriendID != nil);
    [self setSaveButtonsEnabledState:enabled];
}


#pragma mark - Override methods

- (void)setSaveButtonsEnabledState:(BOOL)enabled
{

}

- (void)updateLoanBasedOnViewInfo:(Loan *)loan
{
    NSDecimalNumber *preliminaryAmount = [[NSDecimalNumber alloc] initWithString:self.amountTextField.text];
    loan.amount = (self.lentStatus == YES) ? preliminaryAmount : [preliminaryAmount decimalNumberByNegating];
    loan.friendID = self.selectedFriendID;
    loan.categoryID = self.selectedCategoryID;
    loan.note = self.noteTextField.text;
}

- (void)resetFields
{
    self.amountTextField.text = nil;
    self.selectedFriendID = nil;
    
    self.selectedCategoryID = @(kDefaultCategoryID);
    self.noteTextField.text = nil;
    
    [self validateAmountAndFriend];
}

#pragma mark - Actions

- (IBAction)amountTextFieldDidChange:(id)sender
{
    [self validateAmountAndFriend];
}

#pragma mark - Storyboard

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    [super prepareForSegue:segue sender:sender];
    
    if ([[segue identifier] isEqualToString:@"FriendSegue"]) {
        [self hideKeyboard];
        
        FriendViewController *friendViewController = [segue destinationViewController];
        friendViewController.delegate = self;
        friendViewController.selectedFriendID = self.selectedFriendID;
    }
    else if ([[segue identifier] isEqualToString:@"CategorySegue"]) {
        [self hideKeyboard];
        
        CategoryViewController *categoryViewController = [segue destinationViewController];
        categoryViewController.delegate = self;
        categoryViewController.selectedCategoryID = self.selectedCategoryID;
    }
}


#pragma mark - UITextFieldDelegate methods

// Sent from noteTextField
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    return YES;
}


#pragma mark - FriendViewControllerDelegate methods

- (void)friendViewController:(FriendViewController *)friendViewController didSelectFriendID:(NSNumber *)friendID
{
    [self.navigationController popViewControllerAnimated:YES];
    
    self.selectedFriendID = friendID;
}


#pragma mark - CategoryViewControllerDelegate methods

- (void)categoryViewController:(CategoryViewController *)categoryViewController didSelectCategoryID:(NSNumber *)categoryID
{
    [self.navigationController popViewControllerAnimated:YES];
    
    self.selectedCategoryID = categoryID;
}

@end
