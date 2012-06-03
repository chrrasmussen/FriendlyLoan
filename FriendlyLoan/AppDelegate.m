//
//  AppDelegate.m
//  FriendlyLoan
//
//  Created by Christian Rasmussen on 09.09.11.
//  Copyright (c) 2011 Rasmussen I/O. All rights reserved.
//

#import "AppDelegate.h"

#import "LoanManager.h"
#import "BackendManager.h"

#import "LoanRequest.h"
#import "Test.h"


@implementation AppDelegate

@synthesize window = _window;

@synthesize loanManager = _loanManager;
@synthesize backendManager = _backendManager;


#pragma mark - Application lifecycle

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [self setUpManagers];
    [self.backendManager handleApplicationDidFinishLaunching];
    
//    LoanRequest *lr = [LoanRequest object];
//    lr.note = @"abc";
    
    Test *test = [[Test alloc] init];
    test.test = @"Elg";
    test.note = @"abc";
    
    LoanRequest *lr = [[LoanRequest alloc] init];
    lr.note = @"note";
    NSLog(@"Wee:%@ + %@ + %@", test.test, test.note, lr.note);
    
    return YES;
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    return [self.backendManager handleOpenURL:url];
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
    NSLog(@"%@", NSStringFromSelector(_cmd));
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
     */
    NSLog(@"%@", NSStringFromSelector(_cmd));
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    /*
     Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
     */
    NSLog(@"%@", NSStringFromSelector(_cmd));
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
    NSLog(@"%@", NSStringFromSelector(_cmd));
    [self.loanManager handleApplicationDidBecomeActive];
    [self.backendManager handleApplicationDidBecomeActive];
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Saves changes in the application's managed object context before the application terminates.
//    [self saveContext];
    NSLog(@"%@", NSStringFromSelector(_cmd));
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


#pragma mark - LoanManagerLocationServicesDelegate

- (void)loanManagerNeedLocationServices:(LoanManager *)loanManager
{
    [self displayLocationWarning];
}

- (void)loanManagerNeedLocationServicesForThisApp:(LoanManager *)loanManager
{
    [self displayLocationWarning];
}


#pragma mark - BackendManagerLoanRequestDelegate

- (void)backendManager:(BackendManager *)backendManager displayLoanRequest:(Loan *)loan
{
//    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"FriendlyLoan" bundle:nil];
//    UINavigationController *navigationController = [storyboard instantiateViewControllerWithIdentifier:@"LoanRequestNavigationController"];
//    // TODO: Set loan on LoanRequestViewController
//    [self.window.rootViewController presentModalViewController:navigationController animated:YES];
}


#pragma mark - Private methods

- (void)setUpManagers
{
    _loanManager = [[LoanManager alloc] init];
    _loanManager.locationServicesDelegate = self;
    
    _backendManager = [[BackendManager alloc] initWithLoanManager:self.loanManager];
    _backendManager.loanRequestDelegate = self;
}

- (void)displayLocationWarning
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Location Service Disabled", @"Title of location warning") message:NSLocalizedString(@"To re-enable, please go to Settings and turn on Location Service for this app.", @"Message of location warning") delegate:nil cancelButtonTitle:NSLocalizedString(@"OK", @"Button text on location warning") otherButtonTitles:nil];
    [alertView show];
}

@end
