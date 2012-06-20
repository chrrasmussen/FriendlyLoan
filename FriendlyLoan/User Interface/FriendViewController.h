//
//  FriendViewController.h
//  FriendlyLoan
//
//  Created by Christian Rasmussen on 13.06.12.
//  Copyright (c) 2012 Rasmussen I/O. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol FriendViewControllerDelegate;


@interface FriendViewController : UITableViewController

@property (nonatomic, weak) id<FriendViewControllerDelegate> delegate;

@property (nonatomic, strong) NSNumber *selectedFriendID;

@end
