//
//  SummaryViewController.m
//  FriendlyLoan
//
//  Created by Christian Rasmussen on 09.09.11.
//  Copyright (c) 2011 Rasmussen I/O. All rights reserved.
//

#import "FriendsViewController.h"

#import "HistoryViewController.h"
#import "Models.h"


NSString * const kResultFriendID    = @"friendID";
NSString * const kResultFriendName  = @"friendName";
NSString * const kResultDebt        = @"debt";

NSString * const kPlaceholderImageName  = @"MissingProfilePicture";


@interface FriendsViewController ()

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath;

- (void)setUpFetchedResultsController;
- (void)performFetch;
- (void)cleanAndSortFetchedResult;

@end


@implementation FriendsViewController

@synthesize fetchedResultsController = __fetchedResultsController;
@synthesize sortedResult;
@synthesize friendsSearchResultsController;

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
    
    // Hide search bar as default
    self.tableView.contentOffset = CGPointMake(0.0, self.tableView.tableHeaderView.bounds.size.height);
     
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
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

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

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
    
    // Configure the cell...
    [self configureCell:cell atIndexPath:indexPath];
    
    return cell;
}

#pragma mark - UITableViewDelegate methods

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return NSLocalizedString(@"Clear Debt", @"Delete confirmation button in Summary");
}

#pragma mark - Storyboard

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"FilteredHistorySegue"])
    {
        NSDictionary *result = [self.fetchedResultsController objectAtIndexPath:[self.tableView indexPathForSelectedRow]];
        NSNumber *friendID = [result objectForKey:kResultFriendID];
        
        HistoryViewController *historyViewController = [segue destinationViewController];
        historyViewController.title = [Transaction friendNameForFriendID:friendID];
        historyViewController.friendID = friendID;
    }
}

#pragma mark - Core Data stack

- (NSManagedObjectContext *)managedObjectContext
{
    id appDelegate = [[UIApplication sharedApplication] delegate];
    return [appDelegate managedObjectContext];
}

#pragma mark - Fetched results controller

- (NSFetchedResultsController *)fetchedResultsController
{
    if (__fetchedResultsController != nil)
    {
        return __fetchedResultsController;
    }
    
    [self setUpFetchedResultsController];
    [self performFetch];
    
    return __fetchedResultsController;
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
    
    // Set basic info
    cell.textLabel.text = friendName;
    cell.detailTextLabel.text = [debt stringValue];
    
    // Set image
    UIImage *friendImage = [Transaction friendImageForFriendID:friendID];
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
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Transaction" inManagedObjectContext:self.managedObjectContext];
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Transaction"];
    [fetchRequest setFetchBatchSize:20];
    
    NSSortDescriptor *timeStampSortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"createdTimestamp" ascending:NO];
    NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:timeStampSortDescriptor, nil];
    [fetchRequest setSortDescriptors:sortDescriptors];
    
    
    NSPropertyDescription *friendIDProperty = [[entity propertiesByName] objectForKey:kResultFriendID];
    
    NSExpression *sumOfAmount = [NSExpression expressionForFunction:@"sum:" arguments:[NSArray arrayWithObject:[NSExpression expressionForKeyPath:@"amount"]]];
    NSExpressionDescription *debtProperty = [[NSExpressionDescription alloc] init];
    [debtProperty setName:kResultDebt];
    [debtProperty setExpression:sumOfAmount];
    [debtProperty setExpressionResultType:NSDecimalAttributeType];
    
//    NSPredicate *havingPredicate = [NSPredicate predicateWithFormat:@"%K != 0", kResultDebt];
    
    NSArray *fetchProperties = [NSArray arrayWithObjects:friendIDProperty, debtProperty, nil];
    NSArray *groupByProperties = [NSArray arrayWithObject:friendIDProperty];
    
    [fetchRequest setResultType:NSDictionaryResultType];
    [fetchRequest setPropertiesToFetch:fetchProperties];
    [fetchRequest setPropertiesToGroupBy:groupByProperties];
//    [fetchRequest setHavingPredicate:havingPredicate];
    
    self.fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:self.managedObjectContext sectionNameKeyPath:nil cacheName:@"FriendsCache"];
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
        [updatedFriendObject setValue:[Transaction friendNameForFriendID:friendID] forKey:kResultFriendName];
        
        // Add friend to result
        [result addObject:updatedFriendObject];
    }
    
    // Sort result
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:kResultDebt ascending:NO];
    [result sortUsingDescriptors:[NSArray arrayWithObject:sortDescriptor]];
    
    self.sortedResult = [result copy];
}

@end
