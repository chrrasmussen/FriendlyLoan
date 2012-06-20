//
//  CategoryViewController.h
//  FriendlyLoan
//
//  Created by Christian Rasmussen on 11.09.11.
//  Copyright (c) 2011 Rasmussen I/O. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol CategoryViewControllerDelegate;


@interface CategoryViewController : UITableViewController

@property (nonatomic, weak) id<CategoryViewControllerDelegate> delegate;

@property (nonatomic, strong) NSNumber *selectedCategoryID;

@end
