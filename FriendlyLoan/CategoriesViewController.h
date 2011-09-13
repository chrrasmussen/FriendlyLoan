//
//  CategoriesViewController.h
//  FriendlyLoan
//
//  Created by Christian Rasmussen on 11.09.11.
//  Copyright (c) 2011 Rasmussen I/O. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol CategoriesViewControllerDelegate;

@interface CategoriesViewController : UITableViewController

@property (nonatomic, weak) id<CategoriesViewControllerDelegate> delegate;

@end
