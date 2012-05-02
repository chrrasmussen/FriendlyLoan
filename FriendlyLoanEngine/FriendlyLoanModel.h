//
//  FriendlyLoanCoreData.h
//  FriendlyLoan
//
//  Created by Christian Rasmussen on 15.06.11.
//  Copyright 2011 Rasmussen I/O. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface FriendlyLoanModel : NSObject

@property (nonatomic, strong, readonly) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, strong, readonly) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, strong, readonly) NSPersistentStoreCoordinator *persistentStoreCoordinator;

@property (nonatomic, strong, readonly) NSString *persistentStoreName;

- (id)initWithPersistentStoreName:(NSString *)persistentStoreName;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

- (void)resetPersistentStore;

@end
