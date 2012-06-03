//
//  BackendManager.h
//  FriendlyLoan
//
//  Created by Christian Rasmussen on 01.05.12.
//  Copyright (c) 2012 Rasmussen I/O. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Parse/Parse.h>


@class LoanManager;
@class Loan;

@protocol BackendManagerLoginDelegate, BackendManagerLoanRequestDelegate;


@interface BackendManager : NSObject <PF_FBRequestDelegate>

@property (nonatomic, strong, readonly) LoanManager *loanManager;

@property (nonatomic, weak) id<BackendManagerLoginDelegate> loginDelegate;
@property (nonatomic, weak) id<BackendManagerLoanRequestDelegate> loanRequestDelegate;


// Create backend manager
+ (id)sharedManager;
- (id)initWithLoanManager:(LoanManager *)aLoanManager;

// Application lifecycle
- (void)handleApplicationDidFinishLaunching;
- (void)handleApplicationDidBecomeActive;
- (BOOL)handleOpenURL:(NSURL *)url;

// Remote notifications
- (void)setRemoteNotificationsEnabled:(BOOL)enabled;
- (void)handleDidRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken;
- (void)handleDidFailToRegisterForRemoteNotificationsWithError:(NSError *)error;
- (void)handleDidReceiveRemoteNotification:(NSDictionary *)userInfo;

// User management
@property (nonatomic, strong, readonly) NSString *userFullName;

- (void)logIn;
- (void)logOut;
- (BOOL)isLoggedIn;

// Friend management
//- (void)findFriendByHashedEmail:(NSString *)hashedEmail;
//- (void)findFriendByHashedFacebookId:(NSString *)hashedFacebookId;

// Loan methods
@property (nonatomic, readonly) NSUInteger loanRequestCount;

- (void)shareLoanInBackground:(Loan *)loan;
- (void)updateLoanRequestsWithCompletionHandler:(void (^)(BOOL succeeded, NSError *error))completionHandler;

// Friend methods
@property (nonatomic, readonly) NSUInteger friendRequestCount;


@end

// Notifications
extern NSString * const FLUserWillLogInNotification;
extern NSString * const FLUserDidLogInNotification;
extern NSString * const FLUserFailedToLogInNotification;
extern NSString * const FLUserWillLogOutNotification;
extern NSString * const FLUserDidLogOutNotification;
