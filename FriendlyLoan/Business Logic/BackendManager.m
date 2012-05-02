//
//  BackendManager.m
//  FriendlyLoan
//
//  Created by Christian Rasmussen on 01.05.12.
//  Copyright (c) 2012 Rasmussen I/O. All rights reserved.
//

#import "BackendManager.h"
#import <Parse/Parse.h>

#import "Models.h"


@implementation BackendManager

static BackendManager *_sharedManager;


@synthesize loginDelegate;
@synthesize userFullName;


#pragma mark - Create backend manager

+ (id)sharedManager
{
    if (_sharedManager == nil)
        _sharedManager = [[[self class] alloc] init];
    
    return _sharedManager;
}

//- (id)init
//{
//    self = [super init];
//    if (self) {
//    }
//    return self;
//}

- (void)handleApplicationDidFinishLaunching
{
    // Set up application keys
    [Parse setApplicationId:@"0sEiaamI0nu6w5oc537aPdfawR3dFHzvFtN0ytlw" clientKey:@"0WgN3ZTsUMfSPEW5Vok6lkKgUFrzBr9cgMAT5ZSA"];
    [PFFacebookUtils initializeWithApplicationId:@"377421638976943"];
    
    if  ([self isLoggedIn]) {
        NSLog(@"User already logged in (%@)", [[PFUser currentUser] objectForKey:@"fullName"]);
        
//        [self transactionRequests];
        
        [self setRemoteNotificationsEnabled:YES];
    }
}

- (BOOL)handleOpenURL:(NSURL *)url
{
    return [PFFacebookUtils handleOpenURL:url];
}


#pragma mark - Remote notifications

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

- (void)handleDidRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    [PFPush storeDeviceToken:deviceToken];
    
    [self subscribeToChannels:YES];
}

- (void)handleDidFailToRegisterForRemoteNotificationsWithError:(NSError *)error
{
    NSLog(@"%s%@", (char *)_cmd, error);
}

- (void)handleDidReceiveRemoteNotification:(NSDictionary *)userInfo
{
    [PFPush handlePush:userInfo];
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
    if ([self.loginDelegate respondsToSelector:@selector(backendManagerWillLogIn:)])
        if ([self.loginDelegate backendManagerWillLogIn:self] == NO)
            return;
    
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
                
                // Send request to facebook
                NSString *requestPath = @"me/?fields=name,gender,picture,email";
                [[PFFacebookUtils facebook] requestWithGraphPath:requestPath andDelegate:self];
            }
            
            self.userFullName = [user objectForKey:@"fullName"];
            
            [self setRemoteNotificationsEnabled:YES];
            
            if ([self.loginDelegate respondsToSelector:@selector(backendManagerDidSucceedToLogIn:)])
                [self.loginDelegate backendManagerDidSucceedToLogIn:self];
        }
        else {
            if (!error) {
                NSLog(@"Uh oh. The user cancelled the Facebook login.");
            }
            else {
                NSLog(@"Uh oh. An error occurred: %@", error);
            }
            
            if ([self.loginDelegate respondsToSelector:@selector(backendManager:didFailToLogInWithError:)])
                [self.loginDelegate backendManager:self didFailToLogInWithError:error];
        }
    }];
}

- (void)logOut
{
    if ([self.loginDelegate respondsToSelector:@selector(backendManagerWillLogOut:)])
        if ([self.loginDelegate backendManagerWillLogOut:self] == NO)
            return;
    
    [self setRemoteNotificationsEnabled:NO];
    
    [PFUser logOut];
    
    if ([self.loginDelegate respondsToSelector:@selector(backendManagerDidLogOut:)])
        [self.loginDelegate backendManagerDidLogOut:self];
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
    
    NSString *identifier = [userData objectForKey:@"id"];
    NSString *name = [userData objectForKey:@"name"];
    NSString *gender = [userData objectForKey:@"gender"];
    NSString *email = [userData objectForKey:@"email"];
    
    if (![self.userFullName isEqualToString:name]) {
        self.userFullName = name;
    }
    

//    PFUser *currentUser = [PFUser currentUser];
//    
//    if (![currentUser.email isEqualToString:email]) {
//        
//    }
    
    NSLog(@"%@, %@, %@, %@", identifier, name, email, gender);
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


#pragma mark - Transactions

- (void)shareTransaction:(Transaction *)transaction
{
    PFUser *sender = [PFUser currentUser];
    PFUser *recipient = [self userForFriendID:transaction.friend.friendID];
    
    // TODO: Check if recipient is matched
    
    PFObject *serializedTransaction = [transaction serializeAsPFObject];
    [serializedTransaction setValue:sender forKey:@"sender"];
    [serializedTransaction setValue:recipient forKey:@"recipient"];
    serializedTransaction.ACL = [PFACL ACLWithUser:recipient];
    
    [serializedTransaction saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            NSLog(@"Succeeded to save transaction");
            
            NSString *message = [NSString stringWithFormat:@"%@ just shared a loan with you.", [sender objectForKey:@"fullName"]];
            [self notifyUser:recipient withMessage:message];
        }
    }];
}

- (void)notifyUser:(PFUser *)user withMessage:(NSString *)message
{
    NSString *userChannel = [NSString stringWithFormat:@"user_%@", user.objectId];
    [PFPush sendPushMessageToChannelInBackground:userChannel withMessage:message block:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            NSLog(@"Succeeded to send push message");
        }
    }];
}

- (NSArray *)transactionRequests
{
    NSLog(@"transactionRequests API call");
    PFQuery *query = [PFQuery queryWithClassName:@"Transaction"];
    query.cachePolicy = kPFCachePolicyNetworkElseCache;
    [query whereKey:@"recipient" equalTo:[PFUser currentUser]];
    
//    __block NSArray *transactions;
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (objects) {
            NSLog(@"%@", objects);
            
//            transactions = objects;
        }
    }];
    
    return nil;
}

- (PFUser *)userForFriendID:(NSNumber *)friendID
{
    return [PFUser currentUser];
}

#pragma mark - Temp methods

//    [PFUser logOut];
//    PFQuery *query = [PFQuery queryForUser];
//    PFUser *user = [PFUser currentUser];
//    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
//        NSLog(@"%@", objects);
//        NSLog(@"%@", [((PFUser *)objects.lastObject).ACL getPublicReadAccess]);
//    }];

//    PFQuery *query = [PFQuery queryForUser];
//    [query whereKey:@"email" equalTo:@"test@test.com"];
//    PFUser *user = (PFUser *)[query getObjectWithId:@"CcV58vygkR"];
//    NSLog(@"%@", [query getFirstObject]);

//        [PFACL setDefaultACL:[PFACL ACL] withAccessForCurrentUser:YES];
//        [PFUser currentUser].ACL = [PFACL ACL];
//        user.ACL = [PFACL ACLWithUser:user];
//        [user save];

//                user.ACL = [PFACL ACLWithUser:user];
//                user.ACL = [PFACL ACL];
//                [user save];

//        PFUser *user = [PFUser currentUser];
//        
//        PFQuery *query = [PFQuery queryForUser];
//        PFUser *friendRef = (PFUser *)[query getObjectWithId:@"fvtdFpt7Sq"];
//        
//        NSDictionary *contact = [NSDictionary dictionaryWithObjectsAndKeys:
//                                 [NSNumber numberWithInt:5], @"friendId",
//                                 @"iphone", @"deviceId", nil];
//        NSArray *syncInfo = [NSArray arrayWithObject:contact];
//        NSDictionary *friendInfo = [NSDictionary dictionaryWithObjectsAndKeys:user, @"friendRef",
//                                 syncInfo, @"syncInfo", nil];
//        NSArray *friends = [NSArray arrayWithObject:friendInfo];
//        [user setValue:friends forKey:@"friends"];
//        [user saveInBackground];

- (void)generateParseClasses
{
    //    PFObject *transaction = [PFObject objectWithClassName:@"Transaction"];
    //    [transaction setValue:[NSNumber numberWithInt:100] forKey:@"amount"];
    //    [transaction setValue:[NSNumber numberWithInt:0] forKey:@"categoryId"];
    //    [transaction setValue:@"Note" forKey:@"note"];
    //    
    //    [transaction setValue:[NSNumber numberWithBool:YES] forKey:@"lentToRecipient"];
    //    [transaction setValue:[NSNumber numberWithBool:NO] forKey:@"settledWithRecipient"];
    //    
    //    PFGeoPoint *location = [PFGeoPoint geoPointWithLatitude:0 longitude:0];
    //    [transaction setValue:location forKey:@"location"];
    //    
    //    PFUser *sender = [PFUser currentUser];
    //    PFUser *recipient = [PFUser currentUser];
    //    
    //    PFObject *transactionRequest = [PFObject objectWithClassName:@"TransactionRequest"];
    //    [transactionRequest setValue:sender forKey:@"sender"];
    //    [transactionRequest setValue:recipient forKey:@"recipient"];
    //    [transactionRequest setValue:transaction forKey:@"transaction"];
    //    transactionRequest.ACL = [PFACL ACLWithUser:recipient];
    //    [transactionRequest save];
    //    
    //    PFObject *friendInvitation = [PFObject objectWithClassName:@"FriendInvitation"];
    //    [friendInvitation setValue:@"cizza2k@hotmail.com" forKey:@"emailHash"];
    //    [friendInvitation setValue:@"787355064" forKey:@"facebookIdHash"];
    //    friendInvitation.ACL = [PFACL ACLWithUser:sender];
    //    [friendInvitation save];
    //    
    //    PFObject *friendRequest = [PFObject objectWithClassName:@"FriendRequest"];
    //    [friendRequest setValue:sender forKey:@"sender"];
    //    [friendRequest setValue:recipient forKey:@"recipient"];
    //    NSDictionary *identifiers = [NSDictionary dictionaryWithObjectsAndKeys:@"cizza2k@hotmail.com", @"emailHash",
    //                                 @"787355064", @"facebookIdHash", nil];
    //    [friendRequest setValue:identifiers forKey:@"identifiers"];
    //    PFACL *acl = [PFACL ACLWithUser:sender];
    //    [acl setReadAccess:YES forUser:recipient];
    //    friendRequest.ACL = acl;
    //    [friendRequest save];
    //    
    //    // Recipient
    //    
    //    PFObject *friendAccept = [PFObject objectWithClassName:@"FriendAccept"];
    //    [friendAccept setValue:friendRequest forKey:@"friendRequest"];
    //    friendAccept.ACL = [PFACL ACLWithUser:sender];
    //    [friendAccept save];
    //    
    //    PFObject *friendReject = [PFObject objectWithClassName:@"FriendReject"];
    //    [friendReject setValue:friendRequest forKey:@"friendRequest"];
    //    friendAccept.ACL = [PFACL ACLWithUser:recipient];
    //    [friendReject save];
    //    
    //    PFObject *friendList = [PFObject objectWithClassName:@"FriendList"];
    //    friendList.ACL = [PFACL ACLWithUser:sender];
    //    [friendList save];
}

@end