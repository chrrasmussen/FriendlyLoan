//
//  Loan.m
//  FriendlyLoan
//
//  Created by Christian Rasmussen on 06.10.11.
//  Copyright (c) 2011 Rasmussen I/O. All rights reserved.
//

#import "LoanManager.h"

@implementation LoanManager

@synthesize managedObjectContext = _managedObjectContext;

static LoanManager *_sharedManager;

+ (id)sharedManager
{
    if (_sharedManager == nil)
        _sharedManager = [[[self class] alloc] init];
    
    return _sharedManager;
}

+ (void)setSharedManager:(id)manager
{
    if ([manager isKindOfClass:[LoanManager class]])
        _sharedManager = manager;
}

- (id)initWithManagedObjectContext:(NSManagedObjectContext *)context
{
    self = [super init];
    if (self) {
        if (_sharedManager == nil)
            _sharedManager = self;
        
        _managedObjectContext = context;
    }
    return self;
}

#pragma mark - Manager methods

- (Transaction *)newTransaction
{
    return [NSEntityDescription insertNewObjectForEntityForName:@"Transaction" inManagedObjectContext:self.managedObjectContext];
}

- (Friend *)newFriend
{
    return [NSEntityDescription insertNewObjectForEntityForName:@"Friend" inManagedObjectContext:self.managedObjectContext];
}

- (Location *)newLocation
{
    return [NSEntityDescription insertNewObjectForEntityForName:@"Location" inManagedObjectContext:self.managedObjectContext];
}

#pragma mark - Core Data stack

- (NSManagedObjectContext *)managedObjectContext
{
    id appDelegate = [[UIApplication sharedApplication] delegate];
    return [appDelegate managedObjectContext];
}

- (void)saveContext
{
    NSLog(@"Saving context...");
    
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


@end
