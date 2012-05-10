//
//  BackendManager.h
//  FriendlyLoan
//
//  Created by Christian Rasmussen on 01.05.12.
//  Copyright (c) 2012 Rasmussen I/O. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Parse/Parse.h>

#import "BackendManagerLoginDelegate.h"


extern NSString * const BMUserWillLogInNotification;
extern NSString * const BMUserDidLogInNotification;
extern NSString * const BMUserFailedToLogInNotification;
extern NSString * const BMUserWillLogOutNotification;
extern NSString * const BMUserDidLogOutNotification;


@class LoanManager;
@class Loan;


@interface BackendManager : NSObject <PF_FBRequestDelegate>

@property (nonatomic, strong, readonly) LoanManager *loanManager;

@property (nonatomic, weak) id<BackendManagerLoginDelegate> loginDelegate;

@property (nonatomic, strong, readonly) NSString *userFullName;
@property (nonatomic, readonly) NSUInteger loanRequestCount;
@property (nonatomic, readonly) NSUInteger friendRequestCount;


+ (id)sharedManager;
- (id)initWithLoanManager:(LoanManager *)aLoanManager;

- (void)handleApplicationDidFinishLaunching;
- (void)handleApplicationDidBecomeActive;
- (BOOL)handleOpenURL:(NSURL *)url;

// Remote notifications
- (void)setRemoteNotificationsEnabled:(BOOL)enabled;
- (void)handleDidRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken;
- (void)handleDidFailToRegisterForRemoteNotificationsWithError:(NSError *)error;
- (void)handleDidReceiveRemoteNotification:(NSDictionary *)userInfo;

// User management
- (void)logIn;
- (void)logOut;
- (BOOL)isLoggedIn;

// Transactions
- (void)shareTransactionInBackground:(Loan *)transaction;
- (void)updateTransactionRequests;


@end
