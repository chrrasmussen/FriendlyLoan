//
//  SettingsViewController.h
//  FriendlyLoan
//
//  Created by Christian Rasmussen on 01.05.12.
//  Copyright (c) 2012 Rasmussen I/O. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface SettingsViewController : UITableViewController <PF_FBRequestDelegate>

- (IBAction)logIn:(id)sender;

@end
