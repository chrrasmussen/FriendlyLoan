//
//  TransactionController.h
//  FriendlyLoan
//
//  Created by Christian Rasmussen on 14.06.11.
//  Copyright 2011 Rasmussen I/O. All rights reserved.
//

#import <UIKit/UIKit.h>


@class Transaction;

@interface TransactionDetailsController : UITableViewController

@property (nonatomic, strong) IBOutlet UINavigationItem *navigationItem;

@property (nonatomic, weak) Transaction *transaction;

@end
