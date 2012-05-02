//
//  LoanManager.m
//  FriendlyLoan
//
//  Created by Christian Rasmussen on 06.10.11.
//  Copyright (c) 2011 Rasmussen I/O. All rights reserved.
//

#import "LoanManager.h"

#import "LocationManager.h"

@implementation LoanManager

@synthesize managedObjectContext = _managedObjectContext;
@synthesize locationManagedObjectContext = _locationManagedObjectContext;
@synthesize locationManager = _locationManager;
@synthesize transactionsWaitingForLocation = _transactionsWaitingForLocation;

static LoanManager *_sharedManager;

#pragma mark - Creating loan manager

+ (id)sharedManager
{
    if (_sharedManager == nil)
        [NSException raise:@"LoanManagerNotSet" format:@"Please instantiate a loan manager"];
    
    return _sharedManager;
}

+ (void)setSharedManager:(LoanManager *)manager
{
    if (manager == nil)
        [NSException raise:@"LoanManagerIsNil" format:@"Please specify a loan manager"];
    
    _sharedManager = manager;
}

- (id)initWithManagedObjectContext:(NSManagedObjectContext *)context
{
    self = [super init];
    if (self) {
        // Set first instance as shared manager
        if (_sharedManager == nil)
            _sharedManager = self;
        
        // Set up instance variables
        _managedObjectContext = context;
        
        _locationManagedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSPrivateQueueConcurrencyType];
        [_locationManagedObjectContext performBlockAndWait:^{
            _locationManagedObjectContext.parentContext = context;
        }];
        
        _locationManager = [[LocationManager alloc] init];
        _locationManager.delegate = self;
        
        _transactionsWaitingForLocation = [[NSMutableSet alloc] init];
    }
    return self;
}

#pragma mark - Manipulating transaction

- (Transaction *)newTransaction
{
    return [NSEntityDescription insertNewObjectForEntityForName:@"Transaction" inManagedObjectContext:self.managedObjectContext];;
}

- (void)addFriendID:(NSNumber *)friendID forTransaction:(Transaction *)transaction
{
    if (transaction.friend == nil)
        transaction.friend = [NSEntityDescription insertNewObjectForEntityForName:@"Friend" inManagedObjectContext:self.managedObjectContext];
    
    [transaction.friend populateFieldsWithFriendID:friendID];
}

- (void)addCurrentLocationForTransaction:(Transaction *)transaction
{
    if (transaction.location == nil)
    {
        transaction.location = [NSEntityDescription insertNewObjectForEntityForName:@"Location" inManagedObjectContext:self.managedObjectContext];
        transaction.location.status = [NSNumber numberWithInt:kLocationStatusLocating];
    }
    
    CLLocationCoordinate2D lastKnownLocation = [[self.locationManager lastKnownLocation] coordinate];
    transaction.location.latitude = [NSNumber numberWithDouble:lastKnownLocation.latitude];
    transaction.location.longitude = [NSNumber numberWithDouble:lastKnownLocation.longitude];
    
    NSLog(@"Added location for transaction:%@", transaction);
}

#pragma mark - Location methods

- (void)startUpdatingLocation
{
    [self.locationManager startUpdatingLocation];
}

- (void)stopUpdatingLocation
{
    [self.locationManager stopUpdatingLocation];
}

- (void)resolvePlaceNameForLocation:(CLLocation *)CLLocation
{
    
}

#pragma mark - LocationManagerDelegate methods

- (void)locationManager:(LocationManager *)locationManager didFailWithError:(NSError *)error
{
    NSLog(@"%s", (char *)_cmd);
}

- (void)locationManager:(LocationManager *)locationManager didRetrieveLocation:(CLLocation *)location
{
    NSLog(@"%s", (char *)_cmd);
//    [_transactionsWaitingForLocation removeAllObjects];
}

#pragma mark - Core Data stack

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

@end
