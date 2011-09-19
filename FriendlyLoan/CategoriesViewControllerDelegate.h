//
//  CategoriesViewControllerDelegate.h
//  FriendlyLoan
//
//  Created by Christian Rasmussen on 14.09.11.
//  Copyright (c) 2011 Rasmussen I/O. All rights reserved.
//

#import <Foundation/Foundation.h>


@class CategoriesViewController;

@protocol CategoriesViewControllerDelegate <NSObject>

@optional
- (BOOL)categoriesViewController:(CategoriesViewController *)cvc willSelectCategoryID:(int)categoryID;
- (void)categoriesViewController:(CategoriesViewController *)cvc didSelectCategoryID:(int)categoryID;

@end
