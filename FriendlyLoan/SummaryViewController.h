//
//  SummaryViewController.h
//  FriendlyLoan
//
//  Created by Christian Rasmussen on 09.09.11.
//  Copyright (c) 2011 Rasmussen I/O. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SummaryViewController : UITableViewController

@property (nonatomic, strong, readonly) NSManagedObjectContext *managedObjectContext;

@end
