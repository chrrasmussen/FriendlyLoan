//
//  AppDelegate.m
//  FriendlyLoan
//
//  Created by Christian Rasmussen on 09.09.11.
//  Copyright (c) 2011 Rasmussen I/O. All rights reserved.
//

#import "AppDelegate.h"
#import <CoreData/CoreData.h>

#import "RIOTimedLocationManager.h"
#import "AppDelegateLocationDelegate.h"


@interface AppDelegate ()

- (void)setUpTestFlight;
- (void)setUpTimedLocationManager;

@end


@implementation AppDelegate

@synthesize window = _window;
@synthesize managedObjectContext = __managedObjectContext;
@synthesize managedObjectModel = __managedObjectModel;
@synthesize persistentStoreCoordinator = __persistentStoreCoordinator;
@synthesize timedLocationManager = _timedLocationManager;
@synthesize locationDelegate;


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [self setUpTestFlight];
    [self setUpTimedLocationManager];
//    NSLog(@"Initial qualified location:%@", _timedLocationManager.location);
//    [_timedLocationManager startUpdatingLocation];

    // Override point for customization after application launch.
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
     */
    
    // TODO: What I need to account for:
    // - Terminates if app is forced closed (by user or otherwise)
    // - Background-stuff?
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    /*
     Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
     */
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Saves changes in the application's managed object context before the application terminates.
    [self saveContext];
    NSLog(@"Terminated");
}

#pragma mark - Core Data stack

/**
 Returns the managed object context for the application.
 If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
 */
- (NSManagedObjectContext *)managedObjectContext
{
    if (__managedObjectContext != nil)
    {
        return __managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil)
    {
        __managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
        [__managedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    return __managedObjectContext;
}

/**
 Returns the managed object model for the application.
 If the model doesn't already exist, it is created from the application's model.
 */
- (NSManagedObjectModel *)managedObjectModel
{
    if (__managedObjectModel != nil)
    {
        return __managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"FriendlyLoan" withExtension:@"momd"];
    __managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return __managedObjectModel;
}

/**
 Returns the persistent store coordinator for the application.
 If the coordinator doesn't already exist, it is created and the application's store added to it.
 */
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    if (__persistentStoreCoordinator != nil)
    {
        return __persistentStoreCoordinator;
    }
    
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"FriendlyLoan.sqlite"];
    
    NSError *error = nil;
    __persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    if (![__persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error])
    {
        /*
         Replace this implementation with code to handle the error appropriately.
         
         abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. 
         
         Typical reasons for an error here include:
         * The persistent store is not accessible;
         * The schema for the persistent store is incompatible with current managed object model.
         Check the error message to determine what the actual problem was.
         
         
         If the persistent store is not accessible, there is typically something wrong with the file path. Often, a file URL is pointing into the application's resources directory instead of a writeable directory.
         
         If you encounter schema incompatibility errors during development, you can reduce their frequency by:
         * Simply deleting the existing store:
         [[NSFileManager defaultManager] removeItemAtURL:storeURL error:nil]
         
         * Performing automatic lightweight migration by passing the following dictionary as the options parameter: 
         [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithBool:YES], NSMigratePersistentStoresAutomaticallyOption, [NSNumber numberWithBool:YES], NSInferMappingModelAutomaticallyOption, nil];
         
         Lightweight migration will only work for a limited set of schema changes; consult "Core Data Model Versioning and Data Migration Programming Guide" for details.
         
         */
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }    
    
    return __persistentStoreCoordinator;
}

- (void)saveContext
{
    NSError *error = nil;
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil)
    {
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error])
        {
            /*
             Replace this implementation with code to handle the error appropriately.
             
             abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. 
             */
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        } 
    }
}

#pragma mark - Application's Documents directory

/**
 Returns the URL to the application's Documents directory.
 */
- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}


#pragma mark - Location methods

- (void)displayLocationWarning
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Location Service Disabled" message:@"To re-enable, please go to Settings and turn on Location Service for this app." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alertView show];
}

- (void)startUpdatingLocation
{
    if ([CLLocationManager locationServicesEnabled] == YES)
    {
        [self.timedLocationManager startUpdatingLocation];
    }
    else
    {
        [self displayLocationWarning];
        [self.locationDelegate appDelegate:self didChangeAttachLocationStatus:NO];
    }
}

- (void)stopUpdatingLocation
{
    [self.timedLocationManager startUpdatingLocation];
}


#pragma mark - RIOTimedLocationManagerDelegate methods

- (void)timedLocationManager:(RIOTimedLocationManager *)locationManager didChangeAuthorizationStatus:(CLAuthorizationStatus)status
{
    [self.locationDelegate appDelegate:self didChangeAttachLocationStatus:(status == kCLAuthorizationStatusAuthorized)];
}

- (void)timedLocationManager:(RIOTimedLocationManager *)locationManager didRetrieveLocation:(CLLocation *)location
{
//    NSLog(@"%@", location);
}

- (void)timedLocationManager:(RIOTimedLocationManager *)locationManager didFailWithError:(NSError *)error
{
    if (error.domain == kCLErrorDomain)
    {
        if (error.code == kCLErrorLocationUnknown)
        {
            // TODO: Add code?
        }
        else if (error.code == kCLErrorDenied)
        {
            [self displayLocationWarning];
            [self.locationDelegate appDelegate:self didChangeAttachLocationStatus:NO];
        }
    }
}

#pragma mark - Private methods

- (void)setUpTestFlight
{
    // TODO: Remove if app should be sent to app store
#ifdef DEBUG
    [TestFlight takeOff:@"9eebe38baf2651f6db2456860a9aac8a_MTcyNDcyMDExLTA5LTEzIDE3OjU3OjE4LjUyNDk4NA"];
#endif
}

- (void)setUpTimedLocationManager
{
    _timedLocationManager = [[RIOTimedLocationManager alloc] init];
    _timedLocationManager.delegate = self;
    _timedLocationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters;
    _timedLocationManager.distanceFilter = 500;
    _timedLocationManager.accuracyFilter = 100;
    _timedLocationManager.timeIntervalFilter = 15 * 60;
    _timedLocationManager.maximumLocatingDuration = 5;
    _timedLocationManager.purpose = @"The location will help you remember where the loan took place.";
}

@end
