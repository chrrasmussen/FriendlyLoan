//
//  FriendsViewController.h
//  FriendlyLoan
//
//  Created by Christian Rasmussen on 09.09.11.
//  Copyright (c) 2011 Rasmussen I/O. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>


extern NSString * const kResultFriendID;
extern NSString * const kResultFriendName;
extern NSString * const kResultDebt;

extern NSString * const kPlaceholderImageName;


@protocol FLLoanManager;
@class FriendsSearchResultsController;


@interface FriendsViewController : UITableViewController <UISearchDisplayDelegate, UIAlertViewDelegate>;

@property (nonatomic, strong) id<FLLoanManager> loanManager;

@property (nonatomic, strong) NSFetchedResultsController *fetchedResultsController;
@property (nonatomic, strong) NSMutableArray *sortedResult;

@property (nonatomic, strong) IBOutlet FriendsSearchResultsController *friendsSearchResultsController;

@end
