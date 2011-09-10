//
//  AddLoanViewController.m
//  FriendlyLoan
//
//  Created by Christian Rasmussen on 09.09.11.
//  Copyright (c) 2011 Rasmussen I/O. All rights reserved.
//

#import "AddLoanViewController.h"

#import "Transaction.h"
#import "Person.h"

@interface AddLoanViewController ()

- (void)createTransaction;
- (Person *)fetchPersonWithName:(NSString *)name;

@end

@implementation AddLoanViewController

@synthesize amountTextField, personTextField, categorySegmentedControl, noteTextField;

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

#pragma mark - Actions

- (IBAction)cancel:(id)sender
{
    [self dismissModalViewControllerAnimated:YES];
}

- (IBAction)save:(id)sender
{
    [self createTransaction];
    [self dismissModalViewControllerAnimated:YES];
}

- (void)textFieldBorrowButtonTapped:(UITextField *)textField
{
    amountField.text = [NSString stringWithFormat:@"-%@", amountField.text];
    [self nextField];
}

- (void)textFieldLendButtonTapped:(UITextField *)textField
{
    [self nextField];
}


- (void)nextField
{
    UITextField *fields[] = {amountField, personField, noteField};
    int count = sizeof(fields) / sizeof(UITextField *);
    for (int i = 0; i != count; i++)
    {
        UITextField *textField = fields[i];
        if ([textField isFirstResponder] == YES)
        {
            int nextPosition = i + 1;
            if (nextPosition < count)
            {
                UITextField *nextTextField = fields[nextPosition];
                [nextTextField becomeFirstResponder];
            }
            else
            {
                [textField resignFirstResponder];
            }
        }
    }
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
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
    
    self.amountTextField.keyboardType = UIKeyboardTypeDecimalPad; // WORKAROUND: Can't choose decimal pad as keyboard type
    [self.amountTextField becomeFirstResponder];
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

#pragma mark - Table view data source

//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
//{
//#warning Potentially incomplete method implementation.
//    // Return the number of sections.
//    return 0;
//}
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
//{
//#warning Incomplete method implementation.
//    // Return the number of rows in the section.
//    return 0;
//}
//
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    static NSString *CellIdentifier = @"Cell";
//    
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
//    if (cell == nil) {
//        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
//    }
//    
//    // Configure the cell...
//    
//    return cell;
//}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    // Navigation logic may go here. Create and push another view controller.
//    /*
//     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
//     // ...
//     // Pass the selected object to the new view controller.
//     [self.navigationController pushViewController:detailViewController animated:YES];
//     */
//}

#pragma mark - Core Data stack

- (NSManagedObjectContext *)managedObjectContext
{
    id delegate = [[UIApplication sharedApplication] delegate];
    return [delegate managedObjectContext];
}

#pragma mark - Private methods

// TODO: Fix geolocation and category
- (void)createTransaction
{
    NSLog(@"Creating a record...");
    
    // Check if person already exists
    Person *person = [self fetchPersonWithName:self.personTextField.text];
    if (person == nil)
    {
        person = [NSEntityDescription insertNewObjectForEntityForName:@"Person" inManagedObjectContext:self.managedObjectContext];
        person.name = self.personTextField.text;
    }
    
    // Create the transaction
    Transaction *transaction = [NSEntityDescription insertNewObjectForEntityForName:@"Transaction" inManagedObjectContext:self.managedObjectContext];
    transaction.amount = [NSDecimalNumber decimalNumberWithString:self.amountTextField.text];
    transaction.person = person;
    transaction.category = [NSNumber numberWithInt:[self.categorySegmentedControl selectedSegmentIndex]];
    transaction.note = self.noteTextField.text;
    transaction.timeStamp = [NSDate date];
    transaction.location = @"Current Location"; // FIXME: Missing feature
    
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

- (Person *)fetchPersonWithName:(NSString *)name
{
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"Person"];
    fetchRequest.predicate = [NSPredicate predicateWithFormat:@"name ==[c] %@", name];
    
    NSError *error = nil;
    NSArray *people = [self.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    if (!people)
    {
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    NSLog(@"%@", people);
    return ([people count] > 0) ? [people objectAtIndex:0] : nil;
}

@end
