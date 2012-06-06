//
//  SettingsViewController.h
//  FriendlyLoan
//
//  Created by Christian Rasmussen on 01.05.12.
//  Copyright (c) 2012 Rasmussen I/O. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface SettingsViewController : UITableViewController

@property (nonatomic, strong) IBOutlet UITableViewCell *logInTableViewCell;
@property (nonatomic, strong) IBOutlet UITableViewCell *inviteFriendsTableViewCell;
@property (nonatomic, strong) IBOutlet UITableViewCell *manageFriendsTableViewCell;
@property (nonatomic, strong) IBOutlet UITableViewCell *logOutTableViewCell;

@end
