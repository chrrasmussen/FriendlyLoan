//
//  FriendlyLoanCoreData.h
//  FriendlyLoan
//
//  Created by Christian Rasmussen on 15.06.11.
//  Copyright 2011 Rasmussen I/O. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface FriendlyLoanStore : NSObject

@property (nonatomic, strong, readonly) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, strong, readonly) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, strong, readonly) NSPersistentStoreCoordinator *persistentStoreCoordinator;

@property (nonatomic, strong, readonly) NSString *persistentStoreType;

- (id)initWithType:(NSString *)persistentStoreType;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

// TODO: Temp
- (void)resetPersistentStore;

@end
