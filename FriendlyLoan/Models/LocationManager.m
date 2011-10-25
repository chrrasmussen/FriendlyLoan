//
//  LocationManager.m
//  FriendlyLoan
//
//  Created by Christian Rasmussen on 08.10.11.
//  Copyright (c) 2011 Rasmussen I/O. All rights reserved.
//

#import "LocationManager.h"
#import "LocationManagerDelegate.h"


const CLLocationDistance kDistanceFilter    = 500.0;
const NSTimeInterval kTimeoutTime           = 300.0;

const NSTimeInterval kQualifiedTime         = 900.0;
const CLLocationDistance kQualifiedAccuracy = 100.0;


@interface LocationManager ()

- (void)setUpLocationManager;
- (void)startTimeoutTimer;
- (void)stopTimeoutTimer;
- (void)timeout:(NSTimer *)theTimer;
- (BOOL)qualifyLocation:(CLLocation *)theLocation;

@end


@implementation LocationManager {
    CLLocationManager *_locationManager;
    NSTimer *_timeoutTimer;
    CLLocation *_lastSuccessfulLocation;
}

@synthesize delegate;
@synthesize locating = _locating;
@synthesize transactionsWaitingForLocation;

static LocationManager *_sharedManager;

#pragma mark - Creating location manager

+ (id)sharedManager
{
    if (_sharedManager == nil)
        _sharedManager = [[LocationManager alloc] init];
    
    return _sharedManager;
}

+ (void)setSharedManager:(LocationManager *)manager
{
    _sharedManager = manager;
}

- (id)init {
    self = [super init];
    if (self) {
        if (_sharedManager == nil)
            _sharedManager = self;
        
        // TODO: Setup (Unecessary?)
    }
    return self;
}


#pragma mark - Controlling location updates

- (void)startUpdatingLocation
{
    if (_locating == NO && [self qualifiedLocation] == nil)
    {
        _locating = YES;
        
        NSLog(@"Starting updating location:%s %d %d", (char *)_cmd, [CLLocationManager authorizationStatus], [CLLocationManager locationServicesEnabled]);
        [self setUpLocationManager];
        if ([self qualifyLocation:_locationManager.location] == NO)
        {
            [_locationManager startUpdatingLocation];
            
            [self startTimeoutTimer];
        }
    }
}

- (void)stopUpdatingLocation
{
    if (_locating == YES)
    {
        [self stopTimeoutTimer];
        
        NSLog(@"Stopped updating location");
        [_locationManager stopUpdatingLocation];
        
        _locating = NO;
    }
}


#pragma mark - Helper methods

- (CLLocation *)qualifiedLocation
{
    if ([[self class] isLocationQualified:_lastSuccessfulLocation])
        return _lastSuccessfulLocation;
    
    return nil;
}

+ (BOOL)isLocationQualified:(CLLocation *)theLocation
{
    if (theLocation == nil)
        return NO;
    
    // QUALIFIERS:
    // - Max 5 minutes old
    // - Within 100m accuracy
    
    NSDate *eventDate = theLocation.timestamp;
    NSTimeInterval timeSinceEvent = [eventDate timeIntervalSinceNow];
    
    return (abs(timeSinceEvent) < kQualifiedTime && theLocation.horizontalAccuracy < kQualifiedAccuracy);
}

+ (void)resolvePlaceNameForLocation:(CLLocation *)CLLocation
{
    // TODO: Add code
}


#pragma mark - CLLocationManagerDelegate methods

- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status
{
    NSLog(@"Authorization changed:%s %d %d", (char *)_cmd, status, [CLLocationManager locationServicesEnabled]);
//    [self.attachLocationSwitch setOn:self.attachLocationState animated:YES];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    [self qualifyLocation:newLocation];
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"Failed:%s %d %d %@", (char *)_cmd, [CLLocationManager authorizationStatus], [CLLocationManager locationServicesEnabled], error);
}


#pragma mark - Private methods

- (void)setUpLocationManager
{
    if (_locationManager == nil)
    {
        _locationManager = [[CLLocationManager alloc] init];
        _locationManager.delegate = self;
        _locationManager.purpose = NSLocalizedString(@"This application uses the location services to determine your location when adding a loan.", nil); // TODO: Add proper description + Use key instead of long string
        _locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters;
        _locationManager.distanceFilter = kDistanceFilter;
    }
}

- (void)startTimeoutTimer
{
    _timeoutTimer = [NSTimer timerWithTimeInterval:kTimeoutTime target:self selector:@selector(timeout:) userInfo:nil repeats:NO];
    [[NSRunLoop mainRunLoop] addTimer:_timeoutTimer forMode:NSRunLoopCommonModes];
}

- (void)stopTimeoutTimer
{
    [_timeoutTimer invalidate];
    _timeoutTimer = nil;
}

- (void)timeout:(NSTimer *)theTimer
{
    // Stop updating
    [self stopUpdatingLocation];
    
    // Notify delegate
    if ([self.delegate respondsToSelector:@selector(locationManager:didFailWithError:)])
    {
        // TODO: Set up error
        
        [self.delegate locationManager:self didFailWithError:nil];
    }
}

- (BOOL)qualifyLocation:(CLLocation *)theLocation
{
    if ([[self class] isLocationQualified:theLocation])
    {
        // Save location and stop updating
        _lastSuccessfulLocation = theLocation;
        [self stopUpdatingLocation];
        
        // Notify delegate
        if ([self.delegate respondsToSelector:@selector(locationManager:didRetrieveLocation:)])
            [self.delegate locationManager:self didRetrieveLocation:theLocation];
        
        return YES;
    }
    
    return NO;
}

@end
