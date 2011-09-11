//
//  AddLoanViewController.m
//  FriendlyLoan
//
//  Created by Christian Rasmussen on 09.09.11.
//  Copyright (c) 2011 Rasmussen I/O. All rights reserved.
//

#import "AddLoanViewController.h"

#import "Transaction.h"

@interface AddLoanViewController ()

- (void)updateSelectedPerson:(ABRecordRef)person;
- (void)updateLentStatus:(BOOL)lent;
- (void)validateAmountAndPersonToEnableSave;

- (void)showPeoplePickerController;

- (void)addTransaction;

@end

@implementation AddLoanViewController {
    BOOL isViewControllerLoaded;
}

@synthesize personId, personName, lent, category;
@synthesize amountTextField, noteTextField, saveBarButtonItem;
@synthesize amountDescriptionLabel, personDescriptionLabel, personValueLabel;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
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
    
    // FIXME: Sync problems will arise
    // Check http://mattgemmell.com/2008/10/31/iphone-dev-tips-for-synced-contacts
//    ABAddressBookRef addressBook = ABAddressBookCreate();
//    ABRecordRef record = ABAddressBookGetPersonWithRecordID(addressBook, 1);
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
    
//    if (isViewControllerLoaded == NO)
//    {
//        [self.amountTextField becomeFirstResponder];
//        isViewControllerLoaded = YES;
//    }
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

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 1)
        [self showPeoplePickerController];
}

#pragma mark - Interface actions

- (IBAction)cancel:(id)sender
{
    [self dismissModalViewControllerAnimated:YES];
}

- (IBAction)save:(id)sender
{
    [self addTransaction];
    
    [self dismissModalViewControllerAnimated:YES];
}

- (IBAction)amountTextFieldDidChange:(id)sender
{
    [self validateAmountAndPersonToEnableSave];
}

- (IBAction)selectCategory:(id)sender
{
    [self.noteTextField becomeFirstResponder];
}

#pragma mark - UITextFieldDelegate methods

// Sent from amountTextField
- (void)textFieldBorrowButtonTapped:(UITextField *)textField
{
    [self updateLentStatus:NO];
    
    [textField resignFirstResponder];
}

// Sent from amountTextField
- (void)textFieldLendButtonTapped:(UITextField *)textField
{
    [self updateLentStatus:YES];
    
    [textField resignFirstResponder];
}

// Sent from noteTextField
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    return YES;
}

#pragma mark - Core Data stack

- (NSManagedObjectContext *)managedObjectContext
{
    id delegate = [[UIApplication sharedApplication] delegate];
    return [delegate managedObjectContext];
}

#pragma mark - ABPeoplePickerNavigationControllerDelegate methods

// Displays the information of a selected person
- (BOOL)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker shouldContinueAfterSelectingPerson:(ABRecordRef)person
{
    [self updateSelectedPerson:person];
    
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

- (void)updateLentStatus:(BOOL)lentStatus
{
    self.lent = lentStatus;
    
    // Update GUI
    if (self.lent == YES)
    {
        self.amountDescriptionLabel.text = NSLocalizedString(@"Lend", nil);
        self.personDescriptionLabel.text = NSLocalizedString(@"To", nil);
    }
    else
    {
        self.amountDescriptionLabel.text = NSLocalizedString(@"Borrow", nil);
        self.personDescriptionLabel.text = NSLocalizedString(@"From", nil);
    }
}

- (void)updateSelectedPerson:(ABRecordRef)person
{
    self.personId = (int)ABRecordGetRecordID(person);
    self.personName = (__bridge_transfer NSString *)ABRecordCopyCompositeName(person);
    
    // Update GUI
    self.personValueLabel.text = self.personName;
}

- (void)validateAmountAndPersonToEnableSave
{
    self.saveBarButtonItem.enabled = (self.amountTextField.text.length > 0 && self.personName != nil);
}

-(void)showPeoplePickerController
{
	ABPeoplePickerNavigationController *picker = [[ABPeoplePickerNavigationController alloc] init];
    picker.peoplePickerDelegate = self;
	[self presentModalViewController:picker animated:YES];
}

// TODO: Fix geolocation and category
- (void)addTransaction
{
    Transaction *transaction = [NSEntityDescription insertNewObjectForEntityForName:@"Transaction" inManagedObjectContext:self.managedObjectContext];
    
    transaction.amount = [NSDecimalNumber decimalNumberWithString:self.amountTextField.text];
    transaction.lent = [NSNumber numberWithBool:self.lent];
    
    transaction.personId = [NSNumber numberWithInt:self.personId];
    transaction.personName = self.personName;
    
    transaction.note = self.noteTextField.text;
    
    transaction.category = [NSNumber numberWithInt:self.category];
    
    transaction.timeStamp = [NSDate date];
    transaction.location = @"Current Location";
    
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
}


@end
