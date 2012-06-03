//
//  BackendManager.m
//  FriendlyLoan
//
//  Created by Christian Rasmussen on 01.05.12.
//  Copyright (c) 2012 Rasmussen I/O. All rights reserved.
//

#import "BackendManager.h"
#import <Parse/Parse.h>

#import "BackendManagerLoginDelegate.h"
#import "BackendManagerLoanRequestDelegate.h"

#import "LoanManager.h"


@interface BackendManager ()

@property (nonatomic, strong) NSString *userFullName;
@property (nonatomic) NSUInteger loanRequestCount;
@property (nonatomic) NSUInteger friendRequestCount;

@end


@implementation BackendManager

static BackendManager *_sharedManager;

@synthesize loanManager = _loanManager;

@synthesize loginDelegate;
@synthesize loanRequestDelegate;

@synthesize userFullName;

@synthesize loanRequestCount = _loanRequestCount;
@synthesize friendRequestCount;


#pragma mark - Create backend manager

+ (id)sharedManager
{
    return _sharedManager;
}

- (id)initWithLoanManager:(LoanManager *)aLoanManager;
{
    self = [super init];
    if (self) {
        _sharedManager = self;
        
        _loanManager = aLoanManager;
    }
    return self;
}


#pragma mark - Application events

- (void)handleApplicationDidFinishLaunching
{
    // Set up application keys
    [Parse setApplicationId:@"0sEiaamI0nu6w5oc537aPdfawR3dFHzvFtN0ytlw" clientKey:@"0WgN3ZTsUMfSPEW5Vok6lkKgUFrzBr9cgMAT5ZSA"];
    [PFFacebookUtils initializeWithApplicationId:@"377421638976943"];
}

- (void)handleApplicationDidBecomeActive
{
    if  ([self isLoggedIn]) {
        NSLog(@"User already logged in (%@)", [[PFUser currentUser] objectForKey:@"fullName"]);
        
        [self setRemoteNotificationsEnabled:YES];
        
        [self updateLoanRequestCount];
        
        typeof(self) bself = self;
        [self updateLoanRequestsWithCompletionHandler:^(BOOL succeeded, NSError *error) {
            if ([bself.loanRequestDelegate respondsToSelector:@selector(backendManager:displayLoanRequest:)]) {
                [bself.loanRequestDelegate backendManager:bself displayLoanRequest:nil];
            }
        }];
//        [self updateFriendRequests];
    }
}

- (BOOL)handleOpenURL:(NSURL *)url
{
    return [PFFacebookUtils handleOpenURL:url];
}


#pragma mark - Remote notifications

- (void)handleDidRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    [PFPush storeDeviceToken:deviceToken];
    
    [self subscribeToChannels:YES];
}

- (void)handleDidFailToRegisterForRemoteNotificationsWithError:(NSError *)error
{
#if TARGET_IPHONE_SIMULATOR
#else
    NSLog(@"%@ %@", NSStringFromSelector(_cmd), error);
#endif
}

- (void)handleDidReceiveRemoteNotification:(NSDictionary *)userInfo
{
    if (YES) { // TODO: Verify that notification is a loan request
        NSLog(@"%@", userInfo);
//        [self updateLoanRequestsWithCompletionHandler:<#^(BOOL succeeded, NSError *error)completionHandler#>];
    }
}

- (void)setRemoteNotificationsEnabled:(BOOL)enabled
{
    UIApplication *application = [UIApplication sharedApplication];
    if (enabled) {
        [application registerForRemoteNotificationTypes:(UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound)];
    }
    else {
        [application unregisterForRemoteNotifications];
        
        [self subscribeToChannels:NO];
    }
}

- (void)subscribeToChannels:(BOOL)enabled
{
    NSString *userChannel = [NSString stringWithFormat:@"user_%@", [[PFUser currentUser] objectId]];
    if (enabled) {
//        [PFPush subscribeToChannelInBackground:@""];
        [PFPush subscribeToChannelInBackground:userChannel];
    }
    else {
//        [PFPush unsubscribeFromChannelInBackground:@""];
        [PFPush unsubscribeFromChannelInBackground:userChannel];
    }
}


#pragma mark - User management

- (void)logIn
{
    if ([self.loginDelegate respondsToSelector:@selector(backendManagerWillLogIn:)]) {
        [self.loginDelegate backendManagerWillLogIn:self];
    }
    
    // The permissions requested from the user
    NSArray *permissionsArray = [NSArray arrayWithObjects:@"email", nil];
    
    // Log in
    [PFFacebookUtils logInWithPermissions:permissionsArray block:^(PFUser *user, NSError *error) {
        if (user) {
            if (user.isNew) {
                NSLog(@"User with facebook signed up and logged in!");
            }
            else {
                NSLog(@"User with facebook logged in!");
            }
            
            // Set initial full name
            self.userFullName = [user objectForKey:@"fullName"];
            
            // Send request to facebook
            NSString *requestPath = @"me/?fields=name,gender,picture,email";
            [[PFFacebookUtils facebook] requestWithGraphPath:requestPath andDelegate:self];
            
            [self setRemoteNotificationsEnabled:YES];
            
            if ([self.loginDelegate respondsToSelector:@selector(backendManagerDidSucceedToLogIn:)]) {
                [self.loginDelegate backendManagerDidSucceedToLogIn:self];
            }
        }
        else {
            if (!error) {
                NSLog(@"Uh oh. The user cancelled the Facebook login.");
            }
            else {
                NSLog(@"Uh oh. An error occurred: %@", error);
            }
            
            if ([self.loginDelegate respondsToSelector:@selector(backendManager:didFailToLogInWithError:)]) {
                [self.loginDelegate backendManager:self didFailToLogInWithError:error];
            }
        }
    }];
}

- (void)logOut
{
    if ([self.loginDelegate respondsToSelector:@selector(backendManagerWillLogOut:)]) {
        [self.loginDelegate backendManagerWillLogOut:self];
    }
    
//    [[NSNotificationCenter defaultCenter] postNotificationName:FLUserWillLogOutNotification object:self];
    
    [self setRemoteNotificationsEnabled:NO];
    
    [PFUser logOut];
    
//    [[NSNotificationCenter defaultCenter] postNotificationName:FLUserDidLogOutNotification object:self];
    
    if ([self.loginDelegate respondsToSelector:@selector(backendManagerDidLogOut:)]) {
        [self.loginDelegate backendManagerDidLogOut:self];
    }
}

- (BOOL)isLoggedIn
{
    PFUser *user = [PFUser currentUser];
    return (user && [PFFacebookUtils isLinkedWithUser:user]);
}


#pragma mark - PF_FBRequestDelegate methods

// TODO: Update current user with info
// - Do not save if nothing has changed
// - Check that the user is logged in
- (void)request:(PF_FBRequest *)request didLoad:(id)result
{
    NSDictionary *userData = (NSDictionary *)result;
    
    NSString *facebookID = [userData objectForKey:@"id"];
    NSString *fullName = [userData objectForKey:@"name"];
    NSString *email = [userData objectForKey:@"email"];
    
    if (![self.userFullName isEqualToString:fullName]) {
        self.userFullName = fullName;
    }
    
    if ([self isLoggedIn]) {
        PFUser *user = [PFUser currentUser];
        
        // FIXME: Wrong data type for facebookID?
        [user setValue:facebookID forKey:@"facebookId"];
        [user setValue:fullName forKey:@"fullName"];
        [user setValue:email forKey:@"email"];
        [user saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            NSLog(@"Successfully saved:%@, %@, %@", facebookID, fullName, email);
        }];
    }
}

- (void)request:(PF_FBRequest *)request didFailWithError:(NSError *)error
{
    // OAuthException means our session is invalid
    if ([[[[error userInfo] objectForKey:@"error"] objectForKey:@"type"] isEqualToString: @"OAuthException"]) {
        NSLog(@"The facebook token was invalidated");
        
        [self logOut];
    } else {
        NSLog(@"Some other error");
    }
}


#pragma mark - Loan methods

- (void)shareLoanInBackground:(Loan *)loan
{
    // TODO: Is it necessary to check this?
    if (![self isLoggedIn]) {
        return;
    }
    
    PFUser *sender = [PFUser currentUser];
    PFUser *recipient = [self userForFriendID:loan.friendID];
    
    // TODO: Check if recipient is matched
    
    PFObject *serializedLoan = [loan loanRequestForValues];
    [serializedLoan setValue:sender forKey:@"sender"];
    [serializedLoan setValue:recipient forKey:@"recipient"];
    serializedLoan.ACL = [PFACL ACLWithUser:recipient];
    
    [serializedLoan saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            NSLog(@"Succeeded to save loan");
            
            // TODO: Localize string using a dictionary as the alert
            NSString *message = [NSString stringWithFormat:@"%@ just shared a loan with you.", [sender objectForKey:@"fullName"]];
            [self notifyUser:recipient withMessage:message];
        }
    }];
}

// TODO: Add badge?
// TODO: Make it more flexible? Use with friend request as well
// TODO: Note hard code type
- (void)notifyUser:(PFUser *)user withMessage:(NSString *)message
{
    NSString *userChannel = [NSString stringWithFormat:@"user_%@", user.objectId];
    NSDictionary *data = [NSDictionary dictionaryWithObjectsAndKeys:message, @"alert",
                          @"", @"sound",
                          @"loanRequest", @"type", nil];
    [PFPush sendPushDataToChannelInBackground:userChannel withData:data block:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            NSLog(@"Succeeded to send push message");
        }
    }];
}

- (void)updateLoanRequestsWithCompletionHandler:(void (^)(BOOL succeeded, NSError *error))completionHandler
{
    PFQuery *query = [PFQuery queryWithClassName:@"LoanRequest"];
//    query.cachePolicy = kPFCachePolicyNetworkElseCache;
    [query whereKey:@"recipient" equalTo:[PFUser currentUser]];
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (objects) {
            for (PFObject *object in objects) {
                LoanRequest *loanRequest = [LoanRequest objectWithDataObject:object];
                
                [_loanManager addLoanWithUpdateHandler:^(Loan *loan) {
                    [loan setValuesForLoanRequest:loanRequest];
                }];
                
                [loanRequest deleteEventually];
            }
            
            [self updateLoanRequestCount];
            
            completionHandler(YES, nil);
        }
        else {
            NSLog(@"Failed to retrieve loans:%@", error);
            
            completionHandler(NO, error);
        }
    }];
}

- (void)updateLoanRequestCount
{
    NSUInteger count = [_loanManager getLoanRequestCount];
    self.loanRequestCount = count;
}

- (PFUser *)userForFriendID:(NSNumber *)friendID
{
    return [PFUser currentUser];
}

@end

// Notifications
NSString * const FLUserWillLogInNotification        = @"FLUserWillLogInNotification";
NSString * const FLUserDidLogInNotification         = @"FLUserDidLogInNotification";
NSString * const FLUserFailedToLogInNotification    = @"FLUserFailedToLogInNotification";
NSString * const FLUserWillLogOutNotification       = @"FLUserWillLogOutNotification";
NSString * const FLUserDidLogOutNotification        = @"FLUserDidLogOutNotification";