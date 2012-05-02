//
//  SummaryViewController.h
//  FriendlyLoan
//
//  Created by Christian Rasmussen on 09.09.11.
//  Copyright (c) 2011 Rasmussen I/O. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FriendsSearchResultsController;

@interface FriendsViewController : UITableViewController <UISearchDisplayDelegate>;

@property (nonatomic, strong, readonly) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, strong) NSFetchedResultsController *fetchedResultsController;
@property (nonatomic, strong) NSMutableArray *sortedResult;

@property (nonatomic, strong) IBOutlet FriendsSearchResultsController *friendsSearchResultsController;

@end
