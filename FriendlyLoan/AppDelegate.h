//
//  AppDelegate.h
//  FriendlyLoan
//
//  Created by Christian Rasmussen on 09.09.11.
//  Copyright (c) 2011 Rasmussen I/O. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "LoanManagerLocationServicesDelegate.h"
#import "BackendManagerLoanRequestDelegate.h"


@class PersistentStore, LoanManager, BackendManager;


@interface AppDelegate : UIResponder <UIApplicationDelegate, LoanManagerLocationServicesDelegate, BackendManagerLoanRequestDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (nonatomic, strong, readonly) PersistentStore *persistentStore;
@property (nonatomic, strong, readonly) LoanManager *loanManager;
@property (nonatomic, strong, readonly) BackendManager *backendManager;

@end
