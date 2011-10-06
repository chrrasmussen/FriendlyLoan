//
//  AbstractLoanViewController.m
//  FriendlyLoan
//
//  Created by Christian Rasmussen on 19.09.11.
//  Copyright (c) 2011 Rasmussen I/O. All rights reserved.
//

#import "AbstractLoanViewController.h"

#import "LoanManager.h"

#import "NSDecimalNumber+RIOAdditions.h"
#import "DetailsViewController.h"
#import "CategoriesViewController.h"
#import "Category.h"


const NSInteger kDefaultCategoryID = 0;


@implementation AbstractLoanViewController

@synthesize lentState, selectedFriendID, selectedCategoryID;
@synthesize amountTextField, friendValueLabel, categoryValueLabel, noteTextField, friendCell;

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)updateSelectedFriendID:(NSNumber *)friendID
{
    self.selectedFriendID = friendID;
    
    // Update GUI
    NSString *friendName = [Friend friendNameForFriendID:friendID];
    if (friendName == nil)
        friendName = NSLocalizedString(@"None", nil);
    
    self.friendValueLabel.text = friendName;
}

- (void)updateSelectedCategoryID:(NSNumber *)categoryID
{
    self.selectedCategoryID = categoryID;
    
    // Update GUI
    Category *category = [Category categoryForCategoryID:categoryID];
    if (category == nil)
        category = [Category unknownCategory];
    
    self.categoryValueLabel.text = category.categoryName;
}

- (void)hideKeyboard
{
    [self.tableView endEditing:YES];
}

- (void)showPeoplePickerController
{
    [self hideKeyboard];
    
	ABPeoplePickerNavigationController *picker = [[ABPeoplePickerNavigationController alloc] init];
    picker.peoplePickerDelegate = self;
	[self presentViewController:picker animated:YES completion:NULL];
}

- (void)validateAmountAndFriend
{
    BOOL enabled = (self.amountTextField.text.length > 0 && self.selectedFriendID > 0);
    [self setSaveButtonsEnabledState:enabled];
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Set correct keyboard type
//    self.amountTextField.keyboardType = UIKeyboardTypeDecimalPad; // WORKAROUND: Can't choose decimal pad as keyboard type in Interface Builder
    
    // Reset fields
    [self resetFields];
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

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Override methods

// FIXME: Check all input values against a prototype (Empty or Transaction)
- (BOOL)hasChanges
{
    return NO;
}

- (void)setSaveButtonsEnabledState:(BOOL)enabled
{

}

- (void)updateTransactionBasedOnViewInfo:(Transaction *)theTransaction
{
    NSDecimalNumber *preliminaryAmount = [[NSDecimalNumber alloc] initWithString:self.amountTextField.text];
    theTransaction.amount = (self.lentState == YES) ? preliminaryAmount : [preliminaryAmount decimalNumberByNegating];
    
    theTransaction.categoryID = self.selectedCategoryID;
    theTransaction.note = self.noteTextField.text;
    
    // Add friend
    Friend *friend = [[LoanManager sharedManager] newFriend];
    friend.friendID = self.selectedFriendID;
    
    theTransaction.friend = friend;
}

- (void)resetFields
{
    self.amountTextField.text = @"";
    [self updateSelectedFriendID:0];
    
    [self updateSelectedCategoryID:[NSNumber numberWithInt:kDefaultCategoryID]];
    self.noteTextField.text = @"";
}

#pragma mark - Actions

- (IBAction)amountTextFieldDidChange:(id)sender
{
    [self validateAmountAndFriend];
}

#pragma mark - Storyboard methods

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    [super prepareForSegue:segue sender:sender];
    
    if ([[segue identifier] isEqualToString:@"CategoriesSegue"])
    {
        [self hideKeyboard];
        
        CategoriesViewController *categoriesViewController = [segue destinationViewController];
        categoriesViewController.delegate = self;
        categoriesViewController.selectedCategoryID = self.selectedCategoryID;
    }
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *selectedCell = [tableView cellForRowAtIndexPath:indexPath];
    if (selectedCell == self.friendCell)
        [self showPeoplePickerController];
}

#pragma mark - UITextFieldDelegate methods

// Sent from noteTextField
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    return YES;
}

#pragma mark - CategoriesViewControllerDelegate methods

- (void)categoriesViewController:(CategoriesViewController *)categoriesViewController didSelectCategoryID:(NSNumber *)categoryID
{
    [self.navigationController popViewControllerAnimated:YES];
    
    [self updateSelectedCategoryID:categoryID];
}

#pragma mark - ABPeoplePickerNavigationControllerDelegate methods

// Displays the information of a selected person
- (BOOL)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker shouldContinueAfterSelectingPerson:(ABRecordRef)thePerson
{
    ABRecordID recordID = ABRecordGetRecordID(thePerson);
    [self updateSelectedFriendID:[NSNumber numberWithInt:recordID]];
    
    [self validateAmountAndFriend];
    
    [self dismissViewControllerAnimated:YES completion:NULL];
    
	return NO;
}

// Does not allow users to perform default actions such as dialing a phone number, when they select a person property
- (BOOL)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker shouldContinueAfterSelectingPerson:(ABRecordRef)person property:(ABPropertyID)property identifier:(ABMultiValueIdentifier)identifier
{
	return NO;
}

// Dismisses the people picker and shows the application when users tap Cancel
- (void)peoplePickerNavigationControllerDidCancel:(ABPeoplePickerNavigationController *)peoplePicker
{
	[self dismissViewControllerAnimated:YES completion:NULL];
}

@end
