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


const NSUInteger kHistoryNavigationControllerIndex = 2;
const NSUInteger kSettingsNavigationControllerIndex = 3;


@implementation TabBarController {
    UINavigationController *_historyNavigationController;
    UINavigationController *_settingsNavigationController;
}


#pragma mark - View lifecycle

- (void)viewDidLoad
{
    self.delegate = self;
    
    [self setUpNavigationControllers];
}


#pragma mark - UITabBarControllerDelegate methods

- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController
{
    if ([viewController isKindOfClass:[UINavigationController class]] == NO) {
        return YES;
    }
    
    UINavigationController *navigationController = (UINavigationController *)viewController;
    UIViewController *rootViewControllerInNavigationController = (navigationController.viewControllers)[0];
    UIViewController *visibleViewController = navigationController.visibleViewController;
    
    // Add Loan-tab
    if ([rootViewControllerInNavigationController isKindOfClass:[AddLoanViewController class]]) {
        AddLoanViewController *addLoanViewController = (AddLoanViewController *)rootViewControllerInNavigationController;
        
        // Add Loan View is visible
        if (visibleViewController == addLoanViewController) {
//            if (addLoanViewController.hasChanges == NO) {
//                [addLoanViewController.amountTextField becomeFirstResponder];
//            }
        }
        // Details View is visible
        else {
            [addLoanViewController popToBlankViewControllerAnimated:YES];
        }
    }
    
    return YES;
}


#pragma mark - Observer

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"loanRequestCount"]) {
        NSNumber *value = change[@"new"];
        [self setLoanRequestCount:[value unsignedIntegerValue]];
    }
    else if ([keyPath isEqualToString:@"friendRequestCount"]) {
        NSNumber *value = change[@"new"];
        [self setFriendRequestCount:[value unsignedIntegerValue]];
    }
}


#pragma mark - Private methods

- (void)setUpNavigationControllers
{
    _historyNavigationController = (self.viewControllers)[kHistoryNavigationControllerIndex];
    _settingsNavigationController = (self.viewControllers)[kSettingsNavigationControllerIndex];
    
}

- (void)setLoanRequestCount:(NSUInteger)count
{
    NSString *badgeValue = (count > 0) ? [NSString stringWithFormat:@"%u", count] : nil;
    _historyNavigationController.tabBarItem.badgeValue = badgeValue;
}

- (void)setFriendRequestCount:(NSUInteger)count
{
    NSString *badgeValue = (count > 0) ? [NSString stringWithFormat:@"%u", count] : nil;
    _settingsNavigationController.tabBarItem.badgeValue = badgeValue;
}

@end
