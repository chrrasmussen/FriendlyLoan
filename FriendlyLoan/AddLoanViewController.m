//
//  AddLoanViewController.m
//  FriendlyLoan
//
//  Created by Christian Rasmussen on 09.09.11.
//  Copyright (c) 2011 Rasmussen I/O. All rights reserved.
//

#import "AddLoanViewController.h"

#import "TransactionDetailsViewController.h"
#import "CategoriesViewController.h"
#import "Models.h"


// FIXME: Special case when lent status is undecided
// TODO: Use awaiting save
enum {
    kLentStatusUndecided = -1,
    kLentStatusBorrow = 0,
    kLentStatusLend = 1
};

@interface AddLoanViewController ()

- (void)updateSelectedPerson:(ABRecordRef)person;
- (void)updateLentStatus:(NSInteger)lent;
- (void)validateAmountAndPersonToEnableSave;
- (void)hideKeyboard;
- (void)showPeoplePickerController;

- (Transaction *)addTransaction;
- (void)resetViewController;

@end


@implementation AddLoanViewController {
    ABRecordRef _selectedPerson;
    NSInteger _selectedCategory;
    
    NSInteger _lentStatus;
    BOOL _awaitingSave;
}

@synthesize editTransaction;
@synthesize saveBarButtonItem;
@synthesize amountDescriptionLabel, amountTextField;
@synthesize personDescriptionLabel, personValueLabel;
@synthesize noteTextField;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
        _lentStatus = kLentStatusUndecided;
        
        NSLog(@"Init'd");
    }
    return self;
}

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
    
    self.amountTextField.keyboardType = UIKeyboardTypeDecimalPad; // WORKAROUND: Can't choose decimal pad as keyboard type
    
    // FIXME: Sync problems WILL arise
    // Check http://mattgemmell.com/2008/10/31/iphone-dev-tips-for-synced-contacts
//    ABAddressBookRef addressBook = ABAddressBookCreate();
//    ABRecordRef record = ABAddressBookGetPersonWithRecordID(addressBook, 1);
////    (__bridge_transfer NSString *)ABRecordCopyCompositeName(theSelectedPerson)
//    NSLog(@"%08x %08x", record, NULL);
//    if (record != NULL)
//        NSLog(@"Test:%@", ABRecordCopyCompositeName(record));
//    
//    CFArrayRef array = ABAddressBookCopyPeopleWithName(addressBook, @"b c");
//    NSLog(@"%@", array);
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
    
    [self validateAmountAndPersonToEnableSave];
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

#pragma mark - Actions

// TODO: Check if lent status is undecided
- (IBAction)save:(id)sender
{
    [self performSegueWithIdentifier:@"SaveSegue" sender:sender];
}

- (IBAction)amountTextFieldDidChange:(id)sender
{
    [self validateAmountAndPersonToEnableSave];
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([indexPath isEqual:[NSIndexPath indexPathForRow:1 inSection:0]])
        [self showPeoplePickerController];
}

#pragma mark - UITextFieldDelegate methods

// Sent from amountTextField
- (void)textFieldBorrowButtonTapped:(UITextField *)textField
{
    [self updateLentStatus:kLentStatusBorrow];
    
    [textField resignFirstResponder];
}

// Sent from amountTextField
- (void)textFieldLendButtonTapped:(UITextField *)textField
{
    [self updateLentStatus:kLentStatusLend];
    
    [textField resignFirstResponder];
}

// Sent from noteTextField
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    return YES;
}

#pragma mark - Storyboard

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"SaveSegue"])
    {
        Transaction *transaction = [self addTransaction];
        
        TransactionDetailsViewController *transactionDetailsViewController = [segue destinationViewController];
        transactionDetailsViewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(resetViewController)];
        transactionDetailsViewController.transaction = transaction;
    }
    else if ([[segue identifier] isEqualToString:@"CategoriesSegue"])
    {
        [self hideKeyboard];
    }
}

#pragma mark - Core Data stack

- (NSManagedObjectContext *)managedObjectContext
{
    id delegate = [[UIApplication sharedApplication] delegate];
    return [delegate managedObjectContext];
}

#pragma mark - ABPeoplePickerNavigationControllerDelegate methods

// Displays the information of a selected person
- (BOOL)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker shouldContinueAfterSelectingPerson:(ABRecordRef)thePerson
{
    [self updateSelectedPerson:thePerson];
    
    [self validateAmountAndPersonToEnableSave];
    
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

#pragma mark - Private methods

- (void)updateLentStatus:(NSInteger)theLentStatus
{
    _lentStatus = theLentStatus;
    
    // Update GUI
    if (_lentStatus == kLentStatusBorrow)
    {
        self.amountDescriptionLabel.text = NSLocalizedString(@"Borrow", nil);
        self.personDescriptionLabel.text = NSLocalizedString(@"From", nil);
        self.amountTextField.textColor = [UIColor colorWithHue:0.0 saturation:1.0 brightness:0.8 alpha:1.0];
    }
    else if (_lentStatus == kLentStatusLend)
    {
        self.amountDescriptionLabel.text = NSLocalizedString(@"Lend", nil);
        self.personDescriptionLabel.text = NSLocalizedString(@"To", nil);
        self.amountTextField.textColor = [UIColor colorWithHue:(120.0/360.0) saturation:1.0 brightness:0.8 alpha:1.0];
    }
}

- (void)updateSelectedPerson:(ABRecordRef)theSelectedPerson
{
    _selectedPerson = theSelectedPerson;
    
    // Update GUI
    NSString *fullName = (__bridge_transfer NSString *)ABRecordCopyCompositeName(theSelectedPerson);
    self.personValueLabel.text = fullName;
}

- (void)validateAmountAndPersonToEnableSave
{
    self.saveBarButtonItem.enabled = (self.amountTextField.text.length > 0 && _selectedPerson > 0);
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

// TODO: Fix geolocation and category
- (Transaction *)addTransaction
{
    // TODO: Check if there already exist a user with the particular record id
    // Otherwise create a new
    int recordId = (int)ABRecordGetRecordID(_selectedPerson);
    
    Transaction *transaction = [NSEntityDescription insertNewObjectForEntityForName:@"Transaction" inManagedObjectContext:self.managedObjectContext];
    
    BOOL lent = (_lentStatus == kLentStatusLend) ? YES : NO;
    transaction.lent = [NSNumber numberWithBool:lent];
    transaction.amount = [NSDecimalNumber decimalNumberWithString:self.amountTextField.text];
    transaction.personId = [NSNumber numberWithInt:recordId];
        
    transaction.category = [NSNumber numberWithInt:_selectedCategory];
    transaction.note = self.noteTextField.text;
    
    transaction.timeStamp = [NSDate date];
    transaction.location = @"Current Location"; // TODO: Fix
    
    // Save the context.
    NSError *error = nil;
    if (![self.managedObjectContext save:&error])
    {
        /*
         Replace this implementation with code to handle the error appropriately.
         
         abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. If it is not possible to recover from the error, display an alert panel that instructs the user to quit the application by pressing the Home button.
         */
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    NSLog(@"Record created successfully!");
    
    return transaction;
}

- (void)resetViewController
{
    if ([self.navigationController.viewControllers count] >= 2)
    {
        AddLoanViewController *blankAddLoanViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"AddLoanViewController"];
        NSArray *viewControllers = [NSArray arrayWithObjects:blankAddLoanViewController, self, self.navigationController.visibleViewController, nil];
        [self.navigationController setViewControllers:viewControllers];
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
}



@end
