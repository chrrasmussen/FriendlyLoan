//
//  FriendlyLoan.m
//  FriendlyLoan
//
//  Created by Christian Rasmussen on 14.06.11.
//  Copyright 2011 Rasmussen I/O. All rights reserved.
//

#import "FriendlyLoan.h"
#import "FriendlyLoanStore.h"


#define kTransactionEntity      @"Transaction"


static FriendlyLoan *_sharedInstance;


@interface FriendlyLoan () {
    FriendlyLoanStore *_model;
}

@end


@implementation FriendlyLoan

- (id)initWithModel:(FriendlyLoanStore *)model
{
    self = [super init];
    if (self) {
        if (_sharedInstance == nil)
            _sharedInstance = self;
        
        _model = model;
    }
    return self;
}

- (id)init
{
    FriendlyLoanStore *defaultStore = [[FriendlyLoanStore alloc] init];
    return [self initWithModel:defaultStore];
}

+ (id)sharedInstance
{
    if (_sharedInstance == nil)
        _sharedInstance = [[self alloc] init];
    
    return _sharedInstance;
}

+ (void)setSharedInstance:(FriendlyLoan *)instance
{
    _sharedInstance = instance;
}


#pragma mark - Application logic

- (void)terminate
{
    // Saves changes in the application's managed object context before the application terminates
    [_model saveContext];
}

- (Transaction *)newTransaction
{
    return [NSEntityDescription insertNewObjectForEntityForName:kTransactionEntity inManagedObjectContext:_model.managedObjectContext];
}

- (void)addTransaction:(Transaction *)transaction
{
//    [_model.managedObjectContext insertObject:transaction];
//    Transaction *transaction = 
//    
//    transaction.lent = [NSNumber numberWithBool:lent];
//    transaction.person = person;
//    transaction.value = value;
//    transaction.timeStamp = [NSDate date];
    
    [_model saveContext];
}

- (NSArray *)fetchTransactions
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:kTransactionEntity inManagedObjectContext:_model.managedObjectContext];
    [fetchRequest setEntity:entity];
    NSError *error;
    NSArray *fetchedObjects = [_model.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    if (error != nil)
    {
        /*
         Replace this implementation with code to handle the error appropriately.
         
         abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. If it is not possible to recover from the error, display an alert panel that instructs the user to quit the application by pressing the Home button.
         */
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    return fetchedObjects;
}

#pragma mark - Temp methods

- (void)tempReset
{
    [_model resetPersistentStore];
}

@end
