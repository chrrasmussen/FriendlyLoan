//
//  TransactionsWaitingForLocationFetchRequest.m
//  FriendlyLoan
//
//  Created by Christian Rasmussen on 10.02.12.
//  Copyright (c) 2012 Rasmussen I/O. All rights reserved.
//

#import "TransactionsWaitingForLocationFetchRequest.h"
#import <CoreData/CoreData.h>

@implementation TransactionsWaitingForLocationFetchRequest

+ (NSArray *)fetchFromManagedObjectContext:(NSManagedObjectContext *)managedObjectContext
{
    NSPersistentStoreCoordinator *persistentStoreCoordinator = managedObjectContext.persistentStoreCoordinator;
    NSManagedObjectModel *managedObjectModel = persistentStoreCoordinator.managedObjectModel;
    
    NSDate *dateLimit = [NSDate dateWithTimeIntervalSinceNow:-300]; // TODO: Set as a global constant?
    NSDictionary *variables = [NSDictionary dictionaryWithObject:dateLimit forKey:@"DATE_LIMIT"];
    NSFetchRequest *fetchRequest = [managedObjectModel fetchRequestFromTemplateWithName:@"TransactionsWaitingForLocationFetchRequest" substitutionVariables:variables];
    
    NSError *error;
    NSArray *result = [managedObjectContext executeFetchRequest:fetchRequest error:&error];
    if (result == nil)
    {
	    /*
	     Replace this implementation with code to handle the error appropriately.
         
	     abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. If it is not possible to recover from the error, display an alert panel that instructs the user to quit the application by pressing the Home button.
	     */
	    NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
	    abort();
	}
    
    return result;
}

@end
