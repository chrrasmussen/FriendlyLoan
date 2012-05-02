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


@class Transaction;


@interface BackendManager : NSObject <PF_FBRequestDelegate>

@property (nonatomic, weak) id<BackendManagerLoginDelegate> loginDelegate;
@property (nonatomic, strong) NSString *userFullName;


+ (id)sharedManager;

- (void)handleApplicationDidFinishLaunching;
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
- (void)shareTransaction:(Transaction *)transaction;

@end