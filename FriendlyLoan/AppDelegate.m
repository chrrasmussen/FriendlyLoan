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
    [self setUpNotificationObservers];
    
//    LoanRequest *lr = [LoanRequest object];
//    lr.note = @"abc";
    
//    Test *test = [[Test alloc] init];
//    test.test = @"Elg";
//    test.note = @"abc";
//    
//    LoanRequest *lr = [[LoanRequest alloc] init];
//    lr.note = @"note";
//    NSLog(@"Wee:%@ + %@ + %@", test.test, test.note, lr.note);
    
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


#pragma mark - Private methods

- (void)setUpManagers
{
    _loanManager = [[LoanManager alloc] init];
    _backendManager = [[BackendManager alloc] initWithLoanManager:self.loanManager];
}

- (void)setUpNotificationObservers
{
    typeof(self) bself = self;
    
    [[NSNotificationCenter defaultCenter] addObserverForName:FLNeedsLocationServices object:nil queue:nil usingBlock:^(NSNotification *note) {
        [bself promptUserToEnableLocationServices];
    }];
    
    [[NSNotificationCenter defaultCenter] addObserverForName:FLNeedsLocationServicesForThisApp object:nil queue:nil usingBlock:^(NSNotification *note) {
        [bself promptUserToEnableLocationServicesForThisApp];
    }];
    
    [[NSNotificationCenter defaultCenter] addObserverForName:FLHasNewLoanRequests object:nil queue:nil usingBlock:^(NSNotification *note) {
        Loan *loan = [note.userInfo objectForKey:@"loan"];
        [bself presentLoanRequest:loan];
    }];
}

- (void)promptUserToEnableLocationServices
{
    NSString *title = NSLocalizedString(@"Location Services Disabled", @"Title of alert view");
    NSString *message = NSLocalizedString(@"To re-enable, please go to Settings and turn on Location Services.", @"Message of alert view");
    NSString *cancelButtonTitle = NSLocalizedString(@"OK", @"Cancel button text in alert view");
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title message:message delegate:nil cancelButtonTitle:cancelButtonTitle otherButtonTitles:nil];
    [alertView show];
}

- (void)promptUserToEnableLocationServicesForThisApp
{
    NSString *title = NSLocalizedString(@"Location Services Disabled for this App", @"Title of alert view");
    NSString *message = NSLocalizedString(@"To re-enable, please go to Settings and turn on Location Services for this app.", @"Message of alert view");
    NSString *cancelButtonTitle = NSLocalizedString(@"OK", @"Cancel button text in alert view");
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title message:message delegate:nil cancelButtonTitle:cancelButtonTitle otherButtonTitles:nil];
    [alertView show];
}

- (void)presentLoanRequest:(Loan *)loan
{
//    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"FriendlyLoan" bundle:nil];
//    UINavigationController *navigationController = [storyboard instantiateViewControllerWithIdentifier:@"LoanRequestNavigationController"];
//    // TODO: Set loan on LoanRequestViewController
//    [self.window.rootViewController presentModalViewController:navigationController animated:YES];
}

@end
