//
//  SummaryViewController.m
//  FriendlyLoan
//
//  Created by Christian Rasmussen on 09.09.11.
//  Copyright (c) 2011 Rasmussen I/O. All rights reserved.
//

#import "PeopleViewController.h"

#import "HistoryViewController.h"
#import "Models.h"

@interface PeopleViewController ()

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath;

- (void)setUpFetchedResultsController;
- (void)performFetch;

@end


@implementation PeopleViewController

@synthesize fetchedResultsController = __fetchedResultsController;

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
    return [[self.fetchedResultsController sections] count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    id<NSFetchedResultsSectionInfo> sectionInfo = [[self.fetchedResultsController sections] objectAtIndex:section];
    return [sectionInfo numberOfObjects];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"PersonCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    // Configure the cell...
    [self configureCell:cell atIndexPath:indexPath];
    
    return cell;
}

#pragma mark - Table view delegate

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return NSLocalizedString(@"Remove Debt", @"Delete confirmation button in Summary");
}

#pragma mark - Storyboard

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"FilteredHistorySegue"])
    {
        NSDictionary *result = [self.fetchedResultsController objectAtIndexPath:[self.tableView indexPathForSelectedRow]];
        NSNumber *personID = [result objectForKey:@"personID"];
        
        HistoryViewController *historyViewController = [segue destinationViewController];
        historyViewController.title = [Transaction personNameForID:[personID intValue]];
        historyViewController.personID = [personID intValue];
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

// TODO: Localize
- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *fetchedResult = [self.fetchedResultsController objectAtIndexPath:indexPath];
    
    NSNumber *personID = [fetchedResult objectForKey:@"personID"];
    NSDecimalNumber *debt = [fetchedResult objectForKey:@"debt"];
    
    cell.textLabel.text = [Transaction personNameForID:[personID intValue]];
    cell.detailTextLabel.text = [debt description];
}

- (void)setUpFetchedResultsController
{
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Transaction" inManagedObjectContext:self.managedObjectContext];
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    [fetchRequest setEntity:entity];
    [fetchRequest setFetchBatchSize:20];
    
//    NSSortDescriptor *sectionNameSortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"sectionName" ascending:NO];
    NSSortDescriptor *timeStampSortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"createdTimeStamp" ascending:NO];
    NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:timeStampSortDescriptor, nil];
    [fetchRequest setSortDescriptors:sortDescriptors];
    
    
    NSPropertyDescription *personIDProperty = [[entity propertiesByName] objectForKey:@"personID"];
    
    NSExpression *sumOfAmount = [NSExpression expressionForFunction:@"sum:" arguments:[NSArray arrayWithObject:[NSExpression expressionForKeyPath:@"amount"]]];
    NSExpressionDescription *debtProperty = [[NSExpressionDescription alloc] init];
    [debtProperty setName:@"debt"];
    [debtProperty setExpression:sumOfAmount];
    [debtProperty setExpressionResultType:NSDecimalAttributeType];
    
    NSArray *fetchProperties = [NSArray arrayWithObjects:personIDProperty, debtProperty, nil];
    NSArray *groupByProperties = [NSArray arrayWithObject:personIDProperty];
    
    [fetchRequest setPropertiesToFetch:fetchProperties];
    [fetchRequest setPropertiesToGroupBy:groupByProperties];
    [fetchRequest setResultType:NSDictionaryResultType];
    
    self.fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:self.managedObjectContext sectionNameKeyPath:nil cacheName:nil];
    self.fetchedResultsController.delegate = self;
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
}

@end
