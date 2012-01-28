//
//  AppDelegate.h
//  FriendlyLoan
//
//  Created by Christian Rasmussen on 09.09.11.
//  Copyright (c) 2011 Rasmussen I/O. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "RIOTimedLocationManagerDelegate.h"


@class RIOTimedLocationManager;
@protocol AppDelegateLocationDelegate;

@interface AppDelegate : UIResponder <UIApplicationDelegate, RIOTimedLocationManagerDelegate>

@property (strong, nonatomic) UIWindow *window;

// Core Data
@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

@property (nonatomic, strong, readonly) RIOTimedLocationManager *timedLocationManager;

- (NSURL *)applicationDocumentsDirectory;
- (void)saveContext;

// Location
@property (nonatomic, weak) id<AppDelegateLocationDelegate> locationDelegate;

- (void)startUpdatingLocation;
- (void)stopUpdatingLocation;

@end
