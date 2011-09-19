//
//  AbstractLoanViewController.m
//  FriendlyLoan
//
//  Created by Christian Rasmussen on 19.09.11.
//  Copyright (c) 2011 Rasmussen I/O. All rights reserved.
//

#import "AbstractLoanViewController.h"

#import "DetailsViewController.h"
#import "CategoriesViewController.h"
#import "Models.h"


@implementation AbstractLoanViewController

@synthesize lent, selectedPersonID, selectedCategoryID;
@synthesize amountTextField, personValueLabel, categoryValueLabel, noteTextField;

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)updateTransaction:(Transaction *)transaction
{
    NSDecimalNumber *preliminaryAmount = [[NSDecimalNumber alloc] initWithString:self.amountTextField.text];
    transaction.amount = (self.lent == YES) ? preliminaryAmount : [preliminaryAmount decimalNumberByNegating];
    transaction.personID = [NSNumber numberWithInt:self.selectedPersonID];
    
    transaction.categoryID = [NSNumber numberWithInt:self.selectedCategoryID];
    transaction.note = self.noteTextField.text;
    
    transaction.createdTimeStamp = [NSDate date];
    transaction.location = @"Current Location";
    
    [self saveContext];
}

- (void)updateSelectedPersonID:(int)personID
{
    self.selectedPersonID = personID;
    
    // Update GUI
    self.personValueLabel.text = [Transaction personNameForID:personID];
}

- (void)updateSelectedCategoryID:(int)categoryID
{
    self.selectedCategoryID = categoryID;
    
    // Update GUI
    self.categoryValueLabel.text = [NSString stringWithFormat:@"#%d", categoryID];
}

- (void)hideKeyboard
{
    [self.amountTextField resignFirstResponder];
    [self.noteTextField resignFirstResponder];
}

- (void)showPeoplePickerController
{
    [self hideKeyboard];
    
	ABPeoplePickerNavigationController *picker = [[ABPeoplePickerNavigationController alloc] init];
    picker.peoplePickerDelegate = self;
	[self presentModalViewController:picker animated:YES];
}

- (void)validateAmountAndPerson
{
    BOOL enabled = (self.amountTextField.text.length > 0 && self.selectedPersonID > 0);
    [self setSaveButtonsEnabledState:enabled];
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Set correct keyboard type
//    self.amountTextField.keyboardType = UIKeyboardTypeDecimalPad; // WORKAROUND: Can't choose decimal pad as keyboard type in Interface Builder
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
    
    [self validateAmountAndPerson];
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
    // Override
}

#pragma mark - Actions

- (IBAction)amountTextFieldDidChange:(id)sender
{
    [self validateAmountAndPerson];
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
    }
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([indexPath isEqual:[NSIndexPath indexPathForRow:1 inSection:0]])
        [self showPeoplePickerController];
}

#pragma mark - UITextFieldDelegate methods

// Sent from noteTextField
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    return YES;
}

#pragma mark - Core Data stack

- (NSManagedObjectContext *)managedObjectContext
{
    id appDelegate = [[UIApplication sharedApplication] delegate];
    return [appDelegate managedObjectContext];
}

- (void)saveContext
{
    id appDelegate = [[UIApplication sharedApplication] delegate];
    [appDelegate saveContext];
}

#pragma mark - ABPeoplePickerNavigationControllerDelegate methods

// Displays the information of a selected person
- (BOOL)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker shouldContinueAfterSelectingPerson:(ABRecordRef)thePerson
{
    int personID = (int)ABRecordGetRecordID(thePerson);
    [self updateSelectedPersonID:personID];
    
    [self validateAmountAndPerson];
    
    [self dismissModalViewControllerAnimated:YES];
    
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
	[self dismissModalViewControllerAnimated:YES];
}

@end
