//
//  FetchedHistoryController.m
//  FriendlyLoan
//
//  Created by Christian Rasmussen on 26.10.11.
//  Copyright (c) 2011 Rasmussen I/O. All rights reserved.
//

#import "FetchedHistoryController.h"

@implementation FetchedHistoryController

//- (void)setUpFetchedResultsController
//{
//    // Set up the fetch request
//    NSManagedObjectContext *managedObjectContext = [[LoanManager sharedManager] managedObjectContext];
//    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Transaction" inManagedObjectContext:managedObjectContext];
//    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:entity.name];
//    fetchRequest.includesSubentities = YES;
//    fetchRequest.fetchBatchSize = 20;
//    
//    // Add sort descriptor
//    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"createdAt" ascending:NO];
//    NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
//    
//    [fetchRequest setSortDescriptors:sortDescriptors];
//    
//    // Set a default cache name
//    NSString *cacheName = @"HistoryCache";
//    
//    // Filter the history based on friend ID
//    if (self.friendID != nil)
//    {
//        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"friend.friendID == %@", self.friendID];
//        [fetchRequest setPredicate:predicate];
//        
//        // Use a specific cache name
//        cacheName = [NSString stringWithFormat:@"FriendID%@Cache", self.friendID];
//    }
//    
//    // Create the fetched results controller
//    self.fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:managedObjectContext sectionNameKeyPath:@"historySectionName" cacheName:cacheName];
//    self.fetchedResultsController.delegate = self;
//}
//
//- (void)performFetch
//{
//    // Remove cache if date has changed
//    static NSDate *lastFetchDate;
//    if (lastFetchDate == nil || ![lastFetchDate isEqualToDateIgnoringTime:[NSDate date]])
//        [NSFetchedResultsController deleteCacheWithName:@"HistoryCache"];
//    
//    // Perform fetch and handle error
//    NSError *error = nil;
//	if (![self.fetchedResultsController performFetch:&error])
//    {
//	    /*
//	     Replace this implementation with code to handle the error appropriately.
//         
//	     abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. If it is not possible to recover from the error, display an alert panel that instructs the user to quit the application by pressing the Home button.
//	     */
//	    NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
//	    abort();
//	}
//    
//    // Save last fetch date
//    lastFetchDate = [NSDate date];
//}
@end
