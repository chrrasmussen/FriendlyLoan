//
//  DetailsViewControllerDelegate.h
//  FriendlyLoan
//
//  Created by Christian Rasmussen on 13.09.11.
//  Copyright (c) 2011 Rasmussen I/O. All rights reserved.
//

#import <Foundation/Foundation.h>

@class DetailsViewController;

@protocol DetailsViewControllerDelegate <NSObject>

@optional
- (void)detailsViewControllerDidDisappear:(DetailsViewController *)detailsViewController;

@end