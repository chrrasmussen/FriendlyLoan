//
//  NumberOfTransactionRequestsFetchRequest.m
//  FriendlyLoan
//
//  Created by Christian Rasmussen on 06.05.12.
//  Copyright (c) 2012 Rasmussen I/O. All rights reserved.
//

#import "NumberOfTransactionRequestsFetchRequest.h"
#import <CoreData/CoreData.h>

#import "Transaction.h"

@implementation NumberOfTransactionRequestsFetchRequest

+ (NSUInteger)fetchFromManagedObjectContext:(NSManagedObjectContext *)managedObjectContext
{
    NSPersistentStoreCoordinator *persistentStoreCoordinator = managedObjectContext.persistentStoreCoordinator;
    NSManagedObjectModel *managedObjectModel = persistentStoreCoordinator.managedObjectModel;
    
    NSFetchRequest *fetchRequest = [managedObjectModel fetchRequestTemplateForName:@"NumberOfTransactionRequestsFetchRequest"];
    
    NSError *error;
    NSUInteger count = [managedObjectContext countForFetchRequest:fetchRequest error:&error];
    if (count == NSNotFound)
    {
	    /*
	     Replace this implementation with code to handle the error appropriately.
         
	     abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. If it is not possible to recover from the error, display an alert panel that instructs the user to quit the application by pressing the Home button.
	     */
	    NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
	    abort();
	}
    
    return count;
}

@end
