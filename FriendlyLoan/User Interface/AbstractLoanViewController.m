//
//  AbstractLoanViewController.m
//  FriendlyLoan
//
//  Created by Christian Rasmussen on 19.09.11.
//  Copyright (c) 2011 Rasmussen I/O. All rights reserved.
//

#import "AbstractLoanViewController.h"
#import <AddressBookUI/AddressBookUI.h>

#import "FriendlyLoan.h"

#import "FriendList.h"
#import "CategoryList.h"

#import "FriendViewController.h"
#import "CategoryViewController.h"
#import "DetailsViewController.h"

#import "NSDecimalNumber+RIOAdditions.h"


const NSInteger kDefaultCategoryID = 0;


@interface AbstractLoanViewController () <ABPeoplePickerNavigationControllerDelegate>

@end


@implementation AbstractLoanViewController

@dynamic amount, note;


#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
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


#pragma mark - Table view

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%s", __PRETTY_FUNCTION__);
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (cell == self.friendCell) {
        [self showFriends:tableView];
    }
}


#pragma mark - Accessors/mutators

- (NSDecimalNumber *)amount
{
    NSString *amountText = self.amountTextField.text;
    
    if (amountText == nil) {
        return [NSDecimalNumber zero];
    }
    
    return [NSDecimalNumber decimalNumberWithString:amountText];
}

- (void)setAmount:(NSDecimalNumber *)amount
{
    self.amountTextField.text = [amount stringValue];
}

- (void)setSelectedFriendID:(NSNumber *)selectedFriendID
{
    _selectedFriendID = selectedFriendID;
    
    NSString *friendName = [FriendList nameForFriendID:self.selectedFriendID];
    if (friendName == nil) {
        friendName = NSLocalizedString(@"None Selected", @"Placeholder when no friends are selected in Add Loan-tab");
    }
    
    self.friendValueLabel.text = friendName;
    
    [self validateAmountAndFriend];
}

- (void)setSelectedCategoryID:(NSNumber *)selectedCategoryID
{
    _selectedCategoryID = selectedCategoryID;
    
    self.categoryValueLabel.text = [CategoryList nameForCategoryID:self.selectedCategoryID];
}

- (NSString *)note
{
    return self.noteTextField.text;
}

- (void)setNote:(NSString *)note
{
    self.noteTextField.text = note;
}


#pragma mark - Helper methods for subclasses

- (void)hideKeyboard
{
    [self.tableView endEditing:YES];
}

- (void)validateAmountAndFriend
{
    BOOL enabled = ([self.amount doubleValue] > 0 && self.selectedFriendID != nil);
    [self setSaveButtonsEnabledState:enabled];
}


#pragma mark - Override methods

- (void)setSaveButtonsEnabledState:(BOOL)enabled
{

}

- (void)updateLoanBasedOnViewInfo:(id<FLLoan>)loan
{
    // FIXME: Fix code
//    loan.amount = (self.lentStatus == YES) ? self.amount : [self.amount decimalNumberByNegating];
    loan.absoluteAmount = self.amount;
//    loan.friendID = self.selectedFriendID;
//    loan.categoryID = self.selectedCategoryID;
    loan.note = self.note;
}

- (void)resetFields
{
    self.amount = nil;
    self.selectedFriendID = nil;
    
    self.selectedCategoryID = @(kDefaultCategoryID);
    self.note = nil;
}


#pragma mark - Actions

- (IBAction)amountTextFieldDidChange:(id)sender
{
    [self validateAmountAndFriend];
}

- (IBAction)showFriends:(id)sender
{
    ABPeoplePickerNavigationController *peoplePickerNavigationController = [[ABPeoplePickerNavigationController alloc] init];
    peoplePickerNavigationController.peoplePickerDelegate = self;
    [self presentViewController:peoplePickerNavigationController animated:YES completion:NULL];
}


#pragma mark - Storyboard

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    [super prepareForSegue:segue sender:sender];
    
//    if ([segue.identifier isEqualToString:@"FriendSegue"]) {
//        [self hideKeyboard];
//        
//        FriendViewController *friendViewController = [segue destinationViewController];
//        friendViewController.delegate = self;
//        friendViewController.selectedFriendID = self.selectedFriendID;
//    }
    if ([segue.identifier isEqualToString:@"CategorySegue"]) {
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


#pragma mark - ABPeoplePickerNavigationControllerDelegate

- (BOOL)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker shouldContinueAfterSelectingPerson:(ABRecordRef)person
{
    NSLog(@"%s", __PRETTY_FUNCTION__);
    self.selectedFriendID = @(ABRecordGetRecordID(person));
    [self dismissViewControllerAnimated:YES completion:NULL];
    
    return NO;
}

- (BOOL)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker shouldContinueAfterSelectingPerson:(ABRecordRef)person property:(ABPropertyID)property identifier:(ABMultiValueIdentifier)identifier
{
    NSLog(@"%s", __PRETTY_FUNCTION__);
    return NO;
}

- (void)peoplePickerNavigationControllerDidCancel:(ABPeoplePickerNavigationController *)peoplePicker
{
    NSLog(@"%s", __PRETTY_FUNCTION__);
    [self dismissViewControllerAnimated:YES completion:NULL];
}

//#pragma mark - FriendViewControllerDelegate methods
//
//- (void)friendViewController:(FriendViewController *)friendViewController didSelectFriendID:(NSNumber *)friendID
//{
//    [self.navigationController popViewControllerAnimated:YES];
//    
//    self.selectedFriendID = friendID;
//}


#pragma mark - CategoryViewControllerDelegate methods

- (void)categoryViewController:(CategoryViewController *)categoryViewController didSelectCategoryID:(NSNumber *)categoryID
{
    [self.navigationController popViewControllerAnimated:YES];
    
    self.selectedCategoryID = categoryID;
}

@end
