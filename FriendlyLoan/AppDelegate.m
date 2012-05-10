//
//  AppDelegate.m
//  FriendlyLoan
//
//  Created by Christian Rasmussen on 09.09.11.
//  Copyright (c) 2011 Rasmussen I/O. All rights reserved.
//

#import "AppDelegate.h"

#import "PersistentStore.h"
#import "LoanManager.h"
#import "BackendManager.h"

// FIXME: Remove
//#import "Test.h"
//#import "RIOCalculatedState.h"


@implementation AppDelegate

@synthesize window = _window;

@synthesize persistentStore = _persistentStore;
@synthesize loanManager = _loanManager;
@synthesize backendManager = _backendManager;


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    NSLog(@"%s", (char *)_cmd);
    
//    NSNumber *userState = [[NSUserDefaults standardUserDefaults] objectForKey:@"attachLocation"];
//    NSNumber *systemState = [NSNumber numberWithBool:([CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorized)];
//    RIOCalculatedState *attachLocationState = [[RIOCalculatedState alloc] initWithInitialUserState:userState systemState:systemState calculatedStateHandler:^id(id userState, id systemState) {
//        BOOL available = ([userState boolValue] == YES && [systemState boolValue] == YES);
//        return [NSNumber numberWithBool:available];
//    }];
//    [attachLocationState addObserver:self forKeyPath:@"calculatedState" options:(NSKeyValueObservingOptionInitial | NSKeyValueObservingOptionNew) context:NULL];
//    
//    attachLocationState.userState = [NSNumber numberWithBool:NO];
//    attachLocationState.userState = [NSNumber numberWithBool:YES];
//    attachLocationState.systemState = [NSNumber numberWithBool:YES];;
//    attachLocationState.userState = [NSNumber numberWithBool:NO];
//    
//    [attachLocationState removeObserver:self forKeyPath:@"calculatedState"];
    
    [self setUpManagers];
    [self.backendManager handleApplicationDidFinishLaunching];
    
    return YES;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    NSLog(@"%@ = %@", keyPath, change);
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    return [self.backendManager handleOpenURL:url];
}


#pragma mark - Remote notifications

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    [self.backendManager handleDidRegisterForRemoteNotificationsWithDeviceToken:deviceToken];
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error
{
    [self.backendManager handleDidFailToRegisterForRemoteNotificationsWithError:error];
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    [self.backendManager handleDidReceiveRemoteNotification:userInfo];
}


#pragma mark - Application life-time

- (void)applicationWillResignActive:(UIApplication *)application
{
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
    NSLog(@"%s", (char *)_cmd);
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
     */
    NSLog(@"%s", (char *)_cmd);
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    /*
     Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
     */
    NSLog(@"%s", (char *)_cmd);
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
    NSLog(@"%s", (char *)_cmd);
    [self.loanManager handleApplicationDidBecomeActive];
    [self.backendManager handleApplicationDidBecomeActive];
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Saves changes in the application's managed object context before the application terminates.
//    [self saveContext];
    NSLog(@"%@", NSStringFromSelector(_cmd));
}


#pragma mark - LoanManagerLocationServicesDelegate

- (void)loanManagerNeedLocationServices:(LoanManager *)loanManager
{
    [self displayLocationWarning];
}

- (void)loanManagerNeedLocationServicesForThisApp:(LoanManager *)loanManager
{
    [self displayLocationWarning];
}


#pragma mark - Private methods

- (void)setUpManagers
{
    _persistentStore = [[PersistentStore alloc] init];
    
    _loanManager = [[LoanManager alloc] initWithPersistentStore:self.persistentStore];
    _loanManager.locationServicesDelegate = self;
    
    _backendManager = [[BackendManager alloc] initWithLoanManager:self.loanManager];
    // TODO: Set self as popup loanRequestDelegate
}

- (void)displayLocationWarning
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Location Service Disabled", @"Title of location warning") message:NSLocalizedString(@"To re-enable, please go to Settings and turn on Location Service for this app.", @"Message of location warning") delegate:nil cancelButtonTitle:NSLocalizedString(@"OK", @"Button text on location warning") otherButtonTitles:nil];
    [alertView show];
}

@end
