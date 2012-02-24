//
//  RIOTimedLocationManager.m
//  FriendlyLoan
//
//  Created by Christian Rasmussen on 08.10.11.
//  Copyright (c) 2011 Rasmussen I/O. All rights reserved.
//

#import "RIOTimedLocationManager.h"
#import "RIOTimedLocationManagerDelegate.h"


const CLLocationAccuracy kDefaultAccuracyFilter         = DBL_MAX;
const NSTimeInterval kDefaultTimeIntervalFilter         = DBL_MAX;
const NSTimeInterval kDefaultMaximumLocatingDuration    = DBL_MAX;


@interface RIOTimedLocationManager () <CLLocationManagerDelegate>

- (void)setUpLocationManager;
- (void)setDefaultValues;

- (void)startTimeoutTimer;
- (void)stopTimeoutTimer;
- (void)timeout:(NSTimer *)theTimer;

- (CLLocation *)lastLocation;
- (BOOL)isLocationQualified:(CLLocation *)location;

@end


@implementation RIOTimedLocationManager {
    CLLocationManager *_locationManager;
    NSTimer *_timeoutTimer;
    CLLocation *_acquiredLocation;
}

@synthesize delegate = _delegate;
@synthesize accuracyFilter, timeIntervalFilter, maximumLocatingDuration;


#pragma mark - Creating location manager

- (id)init {
    self = [super init];
    if (self)
    {
        [self setUpLocationManager];
        [self setDefaultValues];
    }
    return self;
}


#pragma mark - Controlling location updates

- (void)startUpdatingLocation
{
    BOOL needLocation = (self.location == nil);
    if (self.locating == NO && needLocation)
    {
//        NSLog(@"Starting updating location (status:%d enabled:%d)", [CLLocationManager authorizationStatus], [CLLocationManager locationServicesEnabled]);
        [_locationManager startUpdatingLocation];
        
        [self startTimeoutTimer];
    }
}

- (void)stopUpdatingLocation
{
    if (self.locating == YES)
    {
        [self stopTimeoutTimer];
        
        [_locationManager stopUpdatingLocation];
//        NSLog(@"Stopped updating location");
    }
}


#pragma mark - Location status

- (BOOL)isLocating
{
    BOOL timerIsActive = (_timeoutTimer != nil);
    return timerIsActive;
}

- (CLLocation *)location
{
    if ([self isLocationQualified:self.lastLocation])
        return self.lastLocation;
    
    return nil;
}


#pragma mark - CLLocationManagerDelegate methods

- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status
{
    if ([self.delegate respondsToSelector:@selector(timedLocationManager:didChangeAuthorizationStatus:)])
        [self.delegate timedLocationManager:self didChangeAuthorizationStatus:status];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    NSLog(@"didUpdateToLocation:%@", newLocation); // TODO: Remove this line
    if ([self isLocationQualified:newLocation])
    {
        _acquiredLocation = newLocation;
        
        if ([self.delegate respondsToSelector:@selector(timedLocationManager:didRetrieveLocation:)])
            [self.delegate timedLocationManager:self didRetrieveLocation:newLocation];
        
        [self stopUpdatingLocation];
    }
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    if ([self.delegate respondsToSelector:@selector(timedLocationManager:didFailWithError:)])
        [self.delegate timedLocationManager:self didFailWithError:error];
    
    [self stopUpdatingLocation];
}


#pragma mark - Private methods

- (void)setUpLocationManager
{
    _locationManager = [[CLLocationManager alloc] init];
    _locationManager.delegate = self;
}

- (void)setDefaultValues
{
    self.accuracyFilter = kDefaultAccuracyFilter;
    self.timeIntervalFilter = kDefaultTimeIntervalFilter;
    self.maximumLocatingDuration = kDefaultMaximumLocatingDuration;
}


- (void)startTimeoutTimer
{
    _timeoutTimer = [NSTimer scheduledTimerWithTimeInterval:self.maximumLocatingDuration target:self selector:@selector(timeout:) userInfo:nil repeats:NO];
}

- (void)stopTimeoutTimer
{
    [_timeoutTimer invalidate];
    _timeoutTimer = nil;
}

- (void)timeout:(NSTimer *)theTimer
{
    if ([self.delegate respondsToSelector:@selector(timedLocationManager:didFailWithError:)])
    {
        // TODO: Set up error correctly
        NSError *error = [NSError errorWithDomain:@"kRIOTimedLocationManagerErrorDomain" code:0 userInfo:nil];
        
        [self.delegate timedLocationManager:self didFailWithError:error];
    }
    
    [self stopUpdatingLocation];
}
   

- (CLLocation *)lastLocation
{
    if (_acquiredLocation == nil)
        _acquiredLocation = _locationManager.location;
    
    return _acquiredLocation;
}

- (BOOL)isLocationQualified:(CLLocation *)theLocation
{
    if (theLocation == nil)
        return NO;
    
    NSTimeInterval timeSinceEvent = [theLocation.timestamp timeIntervalSinceNow];
    
    return (abs(timeSinceEvent) <= self.timeIntervalFilter && theLocation.horizontalAccuracy <= self.accuracyFilter);
}


#pragma mark - Proxy methods

+ (CLAuthorizationStatus)authorizationStatus
{
    return [CLLocationManager authorizationStatus];
}

+ (BOOL)locationServicesEnabled
{
    return [CLLocationManager locationServicesEnabled];
}


- (CLLocationDistance)distanceFilter
{
    return _locationManager.distanceFilter;
}

- (void)setDistanceFilter:(CLLocationDistance)distanceFilter
{
    _locationManager.distanceFilter = distanceFilter;
}


- (CLLocationAccuracy)desiredAccuracy
{
    return _locationManager.desiredAccuracy;
}

- (void)setDesiredAccuracy:(CLLocationAccuracy)desiredAccuracy
{
    _locationManager.desiredAccuracy = desiredAccuracy;
}


- (NSString *)purpose
{
    return _locationManager.purpose;
}

- (void)setPurpose:(NSString *)purpose
{
    _locationManager.purpose = purpose;
}

@end
