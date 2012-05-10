//
//  TabBarController.m
//  FriendlyLoan
//
//  Created by Christian Rasmussen on 08.10.11.
//  Copyright (c) 2011 Rasmussen I/O. All rights reserved.
//

#import "TabBarController.h"

#import "BackendManager.h"

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
    [self setUpObservers];
}

- (void)viewDidUnload
{
    [self tearDownObservers];
}


#pragma mark - UITabBarControllerDelegate methods

- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController
{
    if ([viewController isKindOfClass:[UINavigationController class]] == NO)
        return YES;
    
    UINavigationController *navigationController = (UINavigationController *)viewController;
    UIViewController *rootViewControllerInNavigationController = [navigationController.viewControllers objectAtIndex:0];
    UIViewController *visibleViewController = navigationController.visibleViewController;
    
    // Add Loan-tab
    if ([rootViewControllerInNavigationController isKindOfClass:[AddLoanViewController class]])
    {
        AddLoanViewController *addLoanViewController = (AddLoanViewController *)rootViewControllerInNavigationController;
        
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


#pragma mark - Observer

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"loanRequestCount"]) {
        NSNumber *value = [change objectForKey:@"new"];
        [self setTransactionRequestCount:[value unsignedIntegerValue]];
    }
    else if ([keyPath isEqualToString:@"friendRequestCount"]) {
        NSNumber *value = [change objectForKey:@"new"];
        [self setFriendRequestCount:[value unsignedIntegerValue]];
    }
}


#pragma mark - Private methods

- (void)setUpNavigationControllers
{
    _historyNavigationController = [self.viewControllers objectAtIndex:kHistoryNavigationControllerIndex];
    _settingsNavigationController = [self.viewControllers objectAtIndex:kSettingsNavigationControllerIndex];
    
}

- (void)setUpObservers
{
    [[BackendManager sharedManager] addObserver:self forKeyPath:@"loanRequestCount" options:NSKeyValueObservingOptionInitial | NSKeyValueObservingOptionNew context:NULL];
    [[BackendManager sharedManager] addObserver:self forKeyPath:@"friendRequestCount" options:NSKeyValueObservingOptionInitial |NSKeyValueObservingOptionNew context:NULL];
}

- (void)tearDownObservers
{
    [[BackendManager sharedManager] removeObserver:self];
}

- (void)setTransactionRequestCount:(NSUInteger)count
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
