//
//  TabBarController.h
//  FriendlyLoan
//
//  Created by Christian Rasmussen on 08.10.11.
//  Copyright (c) 2011 Rasmussen I/O. All rights reserved.
//

#import <Foundation/Foundation.h>


@protocol FLLoanManager;


@interface TabBarController : UITabBarController <UITabBarControllerDelegate>

@property (nonatomic, strong) id<FLLoanManager> loanManager;

@end
