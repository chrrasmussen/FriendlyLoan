//
//  FriendsSearchDisplayTableViewController.m
//  FriendlyLoan
//
//  Created by Christian Rasmussen on 29.09.11.
//  Copyright (c) 2011 Rasmussen I/O. All rights reserved.
//

#import "FriendsSearchResultsController.h"

#import "FriendsViewController.h"


@implementation FriendsSearchResultsController


- (NSArray *)sortedResult
{
    return self.friendsViewController.sortedResult;
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.searchDisplayResult count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"SearchDisplayCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    // Configure the cell...
    NSDictionary *friend = (self.searchDisplayResult)[indexPath.row];
    cell.textLabel.text = friend[kResultFriendName];
    
    return cell;
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Convert index path from search display result to sorted result
    id object = (self.searchDisplayResult)[indexPath.row]; 
    NSUInteger row = [self.sortedResult indexOfObject:object];
    NSIndexPath *sortedResultIndexPath = [NSIndexPath indexPathForRow:row inSection:0];
    
    // Select row in table view and perform segue
    [self.friendsViewController.tableView selectRowAtIndexPath:sortedResultIndexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
    [self.friendsViewController performSegueWithIdentifier:@"FilteredHistorySegue" sender:self];
}


#pragma mark - UISearchDisplayDelegate methods

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
    // Store a copy of the last result in order to check if result has changed
    NSArray *lastResult = self.searchDisplayResult;
    
    // Filter search display result
    NSString *test = [NSString stringWithFormat:@"*%@*", searchString];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"%K LIKE[cd] %@", kResultFriendName, test];
    self.searchDisplayResult = [self.sortedResult filteredArrayUsingPredicate:predicate];
    
    // Determine if search display should reload table
    if ([self.searchDisplayResult count] != [lastResult count])
        return YES;
    
    BOOL hasChanged = !([self.searchDisplayResult isEqualToArray:lastResult]);
    return hasChanged;
}

@end
