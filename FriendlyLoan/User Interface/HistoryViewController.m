//
//  HistoryViewController.m
//  FriendlyLoan
//
//  Created by Christian Rasmussen on 09.09.11.
//  Copyright (c) 2011 Rasmussen I/O. All rights reserved.
//

#import "HistoryViewController.h"

#import "FriendlyLoan.h"

#import "DetailsViewController.h"
#import "NSDate+RIOAdditions.h"

#import "CoreData+MagicalRecord.h" // TODO: Temp


@implementation HistoryViewController

@synthesize fetchedResultsController = __fetchedResultsController;


- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)dealloc
{
    self.fetchedResultsController = nil;
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

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
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


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [[self.fetchedResultsController sections] count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    id<NSFetchedResultsSectionInfo> sectionInfo = [self.fetchedResultsController sections][section];
    return [sectionInfo numberOfObjects];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"HistoryCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    [self configureCell:cell atIndexPath:indexPath];
    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    id<NSFetchedResultsSectionInfo> sectionInfo = [self.fetchedResultsController sections][section];
    return [sectionInfo name];
}

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        // Delete the managed object for the given index path
        NSManagedObjectContext *context = [self.fetchedResultsController managedObjectContext];
        [context deleteObject:[self.fetchedResultsController objectAtIndexPath:indexPath]];
        
        // Save the context.
        NSError *error = nil;
        if (![context save:&error])
        {
            /*
             Replace this implementation with code to handle the error appropriately.
             
             abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. If it is not possible to recover from the error, display an alert panel that instructs the user to quit the application by pressing the Home button.
             */
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
    else if (editingStyle == UITableViewCellEditingStyleInsert)
    {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}


#pragma mark - Storyboard

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"DetailsSegue"])
    {
        id<FLLoan> loan = [self.fetchedResultsController objectAtIndexPath:[self.tableView indexPathForSelectedRow]];
        
        DetailsViewController *detailsViewController = [segue destinationViewController];
        detailsViewController.loan = loan;
    }
}

#pragma mark - Table view delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 54;
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

- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller
{
    [self.tableView beginUpdates];
}

- (void)controller:(NSFetchedResultsController *)controller didChangeSection:(id<NSFetchedResultsSectionInfo>)sectionInfo atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type
{
    switch(type)
    {
        case NSFetchedResultsChangeInsert:
            [self.tableView insertSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationAutomatic];
            break;
            
        case NSFetchedResultsChangeDelete:
            [self.tableView deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationAutomatic];
            break;
    }
}

- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath *)newIndexPath
{
    UITableView *tableView = self.tableView;
    
    switch(type)
    {
        case NSFetchedResultsChangeInsert:
            [tableView insertRowsAtIndexPaths:@[ newIndexPath ] withRowAnimation:UITableViewRowAnimationAutomatic];
            break;
            
        case NSFetchedResultsChangeDelete:
             [tableView deleteRowsAtIndexPaths:@[ indexPath ] withRowAnimation:UITableViewRowAnimationAutomatic];
            break;
            
        case NSFetchedResultsChangeUpdate:
            [self configureCell:[tableView cellForRowAtIndexPath:indexPath] atIndexPath:indexPath];
            break;
            
        case NSFetchedResultsChangeMove:
             [tableView deleteRowsAtIndexPaths:@[ indexPath ] withRowAnimation:UITableViewRowAnimationAutomatic];
             [tableView insertRowsAtIndexPaths:@[ newIndexPath ] withRowAnimation:UITableViewRowAnimationAutomatic];
             break;
    }
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller
{
    [self.tableView endUpdates];
}


#pragma mark - Private methods

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
    id<FLLoan> loan = [self.fetchedResultsController objectAtIndexPath:indexPath];
    
    UIImage *lentImage = [UIImage imageNamed:@"UpArrow-Normal"];
    UIImage *lentHighlightedImage = [UIImage imageNamed:@"UpArrow-Highlighted"];
    UIImage *borrowedImage = [UIImage imageNamed:@"DownArrow-Normal"];
    UIImage *borrowedHighlightedImage = [UIImage imageNamed:@"DownArrow-Highlighted"];
//    UIImage *image = [loan categoryImage];
//    UIImage *highlightedImage = [loan categoryHighlightedImage];
    
    // FIXME: Fix code
    NSString *amountText = @"FIXME";//loan.amountPresentation;
    NSString *friendText = @"FIXME";//loan.friendFullName;
    
    BOOL settled = [loan isSettled];
    BOOL lent = NO;//[loan.lent boolValue];
    
    UIImage *image = (lent == YES) ? lentImage : borrowedImage;
    UIImage *highlightedImage = (lent == YES) ? lentHighlightedImage : borrowedHighlightedImage;
    
    NSString *format = nil;
    if (settled == NO) {
        if (lent == YES) {
            format = NSLocalizedString(@"Lent %1$@ to %2$@", @"Outgoing loans in History-tab");
        }
        else {
            format = NSLocalizedString(@"Borrowed %1$@ from %2$@", @"Incoming loans in History-tab");
        }
    }
    else {
        if (lent == YES) {
            format = NSLocalizedString(@"Paid back %1$@ to %2$@", @"Settled incoming loans in History-tab");
        }
        else {
            format = NSLocalizedString(@"Got back %1$@ from %2$@", @"Settled outgoing loans in History-tab");
        }
    }
    
    cell.textLabel.text = [NSString stringWithFormat:format, amountText, friendText];
    cell.imageView.image = image;
    cell.imageView.highlightedImage = highlightedImage;
}

- (void)setUpFetchedResultsController
{
    // Set up the fetch request
    NSManagedObjectContext *managedObjectContext = [NSManagedObjectContext MR_defaultContext];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Loan" inManagedObjectContext:managedObjectContext];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:entity.name];
    fetchRequest.includesSubentities = YES;
    fetchRequest.fetchBatchSize = 20;
    
    // Add sort descriptor
//    NSSortDescriptor *acceptedSortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"requestAccepted" ascending:YES];
    NSSortDescriptor *createdAtSortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"createdAt" ascending:NO];
    NSArray *sortDescriptors = @[ createdAtSortDescriptor ];
    
    [fetchRequest setSortDescriptors:sortDescriptors];
    
    // Set a default cache name
    NSString *cacheName = @"HistoryCache";
    
    // Filter the history based on friend ID
    if (self.friendID != nil)
    {
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"friendID == %@", self.friendID];
        [fetchRequest setPredicate:predicate];
        
        // Use a specific cache name
        cacheName = [NSString stringWithFormat:@"FriendID%@Cache", self.friendID];
    }
    
    // Create the fetched results controller
    self.fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:managedObjectContext sectionNameKeyPath:@"historySectionName" cacheName:cacheName];
    self.fetchedResultsController.delegate = self;
}

- (void)performFetch
{
    // Remove cache if date has changed
    static NSDate *lastFetchDate = nil;
    if (lastFetchDate == nil || ![lastFetchDate isEqualToDateIgnoringTime:[NSDate date]]) {
        [NSFetchedResultsController deleteCacheWithName:@"HistoryCache"];
    }
    
    // Perform fetch and handle error
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
    
    // Save last fetch date
    lastFetchDate = [NSDate date];
}

@end