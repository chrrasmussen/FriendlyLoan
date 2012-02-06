//
//  AppDelegate.h
//  FriendlyLoan
//
//  Created by Christian Rasmussen on 09.09.11.
//  Copyright (c) 2011 Rasmussen I/O. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "RIOTimedLocationManagerDelegate.h"


@class NSManagedObjectID;
@class RIOTimedLocationManager;
@protocol AppDelegateLocationDelegate;

@interface AppDelegate : UIResponder <UIApplicationDelegate, RIOTimedLocationManagerDelegate>

@property (strong, nonatomic) UIWindow *window;

// Core Data
@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (NSURL *)applicationDocumentsDirectory;
- (void)saveContext;

// Location
@property (nonatomic, strong, readonly) RIOTimedLocationManager *timedLocationManager;
@property (nonatomic, weak) id<AppDelegateLocationDelegate> locationDelegate;

@property (nonatomic, strong) NSMutableSet *transactionsAwaitingLocation;

- (void)startUpdatingLocation;
- (void)stopUpdatingLocation;
- (CLLocation *)location;
- (void)addTransaction:(NSURL *)objectURI;
- (void)updateTransactions;

@end
