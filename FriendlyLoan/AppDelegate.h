//
//  AppDelegate.h
//  FriendlyLoan
//
//  Created by Christian Rasmussen on 09.09.11.
//  Copyright (c) 2011 Rasmussen I/O. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "RIOTimedLocationManagerDelegate.h"
#import "LoanManagerLocationDelegate.h"
#import "LoanManagerBackingStoreDelegate.h"


@class LoanManager;
@class RIOTimedLocationManager;

@interface AppDelegate : UIResponder <UIApplicationDelegate, RIOTimedLocationManagerDelegate, LoanManagerLocationDelegate, LoanManagerBackingStoreDelegate>

@property (strong, nonatomic) UIWindow *window;

// Core Data
@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (NSURL *)applicationDocumentsDirectory;
- (void)saveContext;

@property (nonatomic, strong, readonly) LoanManager *loanManager;
@property (nonatomic, strong, readonly) RIOTimedLocationManager *timedLocationManager;


@end
