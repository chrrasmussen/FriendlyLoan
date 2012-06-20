//
//  FriendsViewController.m
//  FriendlyLoan
//
//  Created by Christian Rasmussen on 09.09.11.
//  Copyright (c) 2011 Rasmussen I/O. All rights reserved.
//

#import "FriendsViewController.h"

#import "LoanManager.h"
#import "HistoryViewController.h"

#import "FriendList.h"
#import "CurrencyList.h"


NSString * const kResultFriendID    = @"friendID";
NSString * const kResultFriendName  = @"friendName";
NSString * const kResultDebt        = @"debt";

NSString * const kPlaceholderImageName  = @"MissingProfilePicture";


@implementation FriendsViewController

@synthesize fetchedResultsController = __fetchedResultsController;


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
    
    // Hide search bar as default
    self.tableView.contentOffset = CGPointMake(0.0, self.tableView.tableHeaderView.bounds.size.height);
     
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

// TODO: Optimize the fetch? Check when context was last updated
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    // Refresh result
    [self performFetch];
    [self.tableView reloadData];
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


#pragma mark - TableViewDataSource methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.sortedResult count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"FriendCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    [self configureCell:cell atIndexPath:indexPath];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self settleDebtForIndexPath:indexPath];
}


#pragma mark - UITableViewDelegate methods

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return NSLocalizedString(@"Settle", @"Text of delete button in Friends-tab");
}

//- (void)tableView:(UITableView *)tableView willBeginEditingRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    NSLog(@"Begin");
//}
//
//- (void)tableView:(UITableView *)tableView didEndEditingRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    NSLog(@"End");
//}
//
//- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    NSLog(@"Editing style");
//    
//    return UITableViewCellEditingStyleDelete;
//}
//
//- (BOOL)tableView:(UITableView *)tableView shouldIndentWhileEditingRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    NSLog(@"Indent");
//    
//    return YES;
//}


#pragma mark - Storyboard

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"FilteredHistorySegue"])
    {
        NSDictionary *result = [self.sortedResult objectAtIndex:[[self.tableView indexPathForSelectedRow] row]];
        NSNumber *friendID = [result objectForKey:kResultFriendID];
        
        HistoryViewController *historyViewController = [segue destinationViewController];
        historyViewController.title = [FriendList nameForFriendID:friendID];
        historyViewController.friendID = friendID;
    }
}


#pragma mark - Fetched results controller

- (NSFetchedResultsController *)fetchedResultsController
{
    if (__fetchedResultsController == nil)
    {
        [self setUpFetchedResultsController];
        [self performFetch];
    }
    
    return __fetchedResultsController;
}


#pragma mark - UIAlertViewDelegate methods

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSLog(@"%@ %d", NSStringFromSelector(_cmd), buttonIndex);
}


#pragma mark - Private methods

// TODO: Move debt-colors to an appropriate place
- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
    // Get data for cell
    NSDictionary *fetchedResult = [self.sortedResult objectAtIndex:indexPath.row];
    
    NSNumber *friendID = [fetchedResult objectForKey:kResultFriendID];
    NSString *friendName = [fetchedResult objectForKey:kResultFriendName];
    NSDecimalNumber *debt = [fetchedResult objectForKey:kResultDebt];
    NSString *debtPresentation = [[CurrencyList currentCurrencyFormatter] stringFromNumber:debt];
    
    // Set basic info
    cell.textLabel.text = friendName;
    cell.detailTextLabel.text = debtPresentation;
    
    // Set image
    UIImage *friendImage = [FriendList imageForFriendID:friendID];
    if (friendImage == nil)
        friendImage = [UIImage imageNamed:kPlaceholderImageName];
    
    cell.imageView.image = friendImage;
    
    // Set colors on debt
    if ([debt compare:[NSDecimalNumber zero]] == NSOrderedDescending)
        cell.detailTextLabel.textColor = [UIColor colorWithHue:(120.0/360.0) saturation:1.0 brightness:0.8 alpha:1.0];
    else
        cell.detailTextLabel.textColor = [UIColor colorWithHue:(0.0/360.0) saturation:1.0 brightness:0.8 alpha:1.0];
}

- (void)setUpFetchedResultsController
{
    // Set up fetch request
    NSManagedObjectContext *managedObjectContext = [[LoanManager sharedManager] managedObjectContext];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Loan" inManagedObjectContext:managedObjectContext];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:entity.name];
//    fetchRequest.includesSubentities = YES;
    fetchRequest.fetchBatchSize = 20;
    
    // Predicate
//    NSPredicate *acceptedPredicate = [NSPredicate predicateWithFormat:@"requestAccepted == YES"];
    
    // Set sort descriptors
    NSSortDescriptor *timeStampSortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"createdAt" ascending:NO];
    NSArray *sortDescriptors = @[ timeStampSortDescriptor ];
    [fetchRequest setSortDescriptors:sortDescriptors];
    
    // Set up friendID-property
    NSExpression *friendIDKeyPath = [NSExpression expressionForKeyPath:@"friendID"];
    NSExpressionDescription *friendIDProperty = [[NSExpressionDescription alloc] init];
    [friendIDProperty setName:kResultFriendID];
    [friendIDProperty setExpression:friendIDKeyPath];
    [friendIDProperty setExpressionResultType:NSInteger32AttributeType];
    
    // Set up debt-property
    NSArray *arguments = @[ [NSExpression expressionForKeyPath:@"amount"] ];
    NSExpression *sumOfAmount = [NSExpression expressionForFunction:@"sum:" arguments:arguments];
    NSExpressionDescription *debtProperty = [[NSExpressionDescription alloc] init];
    [debtProperty setName:kResultDebt];
    [debtProperty setExpression:sumOfAmount];
    [debtProperty setExpressionResultType:NSDecimalAttributeType];
    
    // Combine properties
    NSArray *fetchProperties = @[ friendIDProperty, debtProperty ];
    NSArray *groupByProperties = @[ friendIDProperty ];
    
    // Set properties on fetch request
    [fetchRequest setResultType:NSDictionaryResultType];
//    [fetchRequest setPredicate:acceptedPredicate];
    [fetchRequest setPropertiesToFetch:fetchProperties];
    [fetchRequest setPropertiesToGroupBy:groupByProperties];
    
    // Create the fetch results controller
    self.fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:managedObjectContext sectionNameKeyPath:nil cacheName:@"FriendsCache"];
}

- (void)performFetch
{
    NSError *error = nil;
	if (![self.fetchedResultsController performFetch:&error])
    {
	    /*
	     Replace this implementation with code to handle the error appropriately.
         
	     abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. If it is not possible to recover from the error, display an alert panel that instructs the user to quit the application by pressing the Home button.
	     */
	    NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
	    abort();
	}
    
    [self cleanAndSortFetchedResult];
}

- (void)cleanAndSortFetchedResult
{
    // Add another field to the result
    NSMutableArray *result = [[NSMutableArray alloc] init];
    
    for (NSDictionary *friendObject in self.fetchedResultsController.fetchedObjects)
    {
        // Skip friends with no debt
        NSDecimalNumber *debt = [friendObject objectForKey:kResultDebt];
        if ([debt compare:[NSDecimalNumber zero]] == NSOrderedSame)
            continue;
        
        // Add friend name
        NSNumber *friendID = [friendObject objectForKey:kResultFriendID];
        
        NSMutableDictionary *updatedFriendObject = [NSMutableDictionary dictionaryWithDictionary:friendObject];
        [updatedFriendObject setValue:[FriendList nameForFriendID:friendID] forKey:kResultFriendName];
        
        // Add friend to result
        [result addObject:updatedFriendObject];
    }
    
    // Sort result
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:kResultDebt ascending:NO];
    [result sortUsingDescriptors:@[ sortDescriptor ]];
    
    self.sortedResult = result;
}

- (void)settleDebtForIndexPath:(NSIndexPath *)indexPath
{
    // Retrieve data
    NSDictionary *friendObject = [self.sortedResult objectAtIndex:indexPath.row];
    
    NSDecimalNumber *debt = [friendObject objectForKey:kResultDebt];
    NSNumber *friendID = [friendObject objectForKey:kResultFriendID];
    
    [[LoanManager sharedManager] settleDebt:debt forFriendID:friendID];
    
    // Delete row from data source
    [self.sortedResult removeObjectAtIndex:indexPath.row];
    
    // Delete row from table view
    NSArray *indexPaths = @[ indexPath ];
    [self.tableView deleteRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationAutomatic];
}

- (void)promptUserToConfirmSettle
{
    NSString *title = NSLocalizedString(@"Settle Loan", @"Title of alert view");
    NSString *message = NSLocalizedString(@"When settling loans, the current settings for \"Attach Location\" and \"Share Loan with Friends\" in the Add Loan-tab are used. This message will only be displayed once.", @"Message of alert view");
    NSString *confirmButtonTitle = NSLocalizedString(@"Settle", @"Confirm settle button in alert view");
    NSString *cancelButtonTitle = NSLocalizedString(@"Cancel", @"Cancel button text in alert view");
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title message:message delegate:self cancelButtonTitle:cancelButtonTitle otherButtonTitles:confirmButtonTitle, nil];
    [alertView show];
}

@end
