//
//  TabBarController.m
//  FriendlyLoan
//
//  Created by Christian Rasmussen on 08.10.11.
//  Copyright (c) 2011 Rasmussen I/O. All rights reserved.
//

#import "TabBarController.h"

#import "AddLoanViewController.h"
#import "DetailsViewController.h"


@implementation TabBarController

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    self.delegate = self;
}

#pragma mark - UITabBarControllerDelegate methods

- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController
{
    if ([viewController isKindOfClass:[UINavigationController class]] == NO)
        return YES;
    
    UINavigationController *navigationController = (UINavigationController *)viewController;
    UIViewController *rootViewController = [navigationController.viewControllers objectAtIndex:0];
    UIViewController *visibleViewController = navigationController.visibleViewController;
    
    // Add Loan-tab
    if ([rootViewController isKindOfClass:[AddLoanViewController class]])
    {
        AddLoanViewController *addLoanViewController = (AddLoanViewController *)rootViewController;
        
        // Add Loan View is visible
        if (visibleViewController == addLoanViewController)
        {
//            if (addLoanViewController.hasChanges == NO)
//            {
//                [addLoanViewController.amountTextField becomeFirstResponder];
//            }
        }
        // Details View is visible
        else if ([visibleViewController isKindOfClass:[DetailsViewController class]])
        {
            [addLoanViewController popToBlankViewControllerAnimated:YES];
//            [addLoanViewController.amountTextField becomeFirstResponder];
        }
    }
    
    return YES;
}

@end
