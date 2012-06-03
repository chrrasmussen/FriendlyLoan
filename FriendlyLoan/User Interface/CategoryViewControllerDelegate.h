//
//  CategoryViewControllerDelegate.h
//  FriendlyLoan
//
//  Created by Christian Rasmussen on 14.09.11.
//  Copyright (c) 2011 Rasmussen I/O. All rights reserved.
//

#import <Foundation/Foundation.h>


@class CategoryViewController;

@protocol CategoryViewControllerDelegate <NSObject>

@optional
- (void)categoryViewController:(CategoryViewController *)cvc didSelectCategoryID:(NSNumber *)categoryID;

@end
