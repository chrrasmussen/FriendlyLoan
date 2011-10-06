//
//  FriendsSearchDisplayTableViewController.h
//  FriendlyLoan
//
//  Created by Christian Rasmussen on 29.09.11.
//  Copyright (c) 2011 Rasmussen I/O. All rights reserved.
//

#import <UIKit/UIKit.h>


@class FriendsViewController;

@interface FriendsSearchResultsController : UITableViewController <UISearchDisplayDelegate>

@property (nonatomic, weak) IBOutlet FriendsViewController *friendsViewController;
@property (nonatomic, strong, readonly) NSArray *sortedResult;

@property (nonatomic, strong) NSArray *searchDisplayResult;

@end
