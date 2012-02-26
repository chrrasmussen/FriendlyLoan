//
//  RIOCachedLocationManager.m
//  FriendlyLoan
//
//  Created by Christian Rasmussen on 08.10.11.
//  Copyright (c) 2011 Rasmussen I/O. All rights reserved.
//

#import "RIOCachedLocationManager.h"
#import "RIOCachedLocationManagerDelegate.h"


@interface RIOCachedLocationManager () <CLLocationManagerDelegate>

@end


@implementation RIOCachedLocationManager {
    CLLocationManager *_locationManager;
    CLLocation *_cachedLocation;
    NSTimer *_expirationTimer;
}

@synthesize delegate = _delegate;
@synthesize accuracyFilter, timeIntervalFilter;
@synthesize needsLocation = _needsLocation;


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

- (void)setNeedsLocation:(BOOL)needsLocation
{
    _needsLocation = needsLocation;
    
    [self updateLocationIfNecessary];
}

- (void)invalidateCachedLocation
{
    _cachedLocation = nil;
    [self stopExpirationTimer];
    
    [self updateLocationIfNecessary];
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
    if (status == kCLAuthorizationStatusAuthorized)
        [self updateLocationIfNecessary];
    
    if ([self.delegate respondsToSelector:@selector(cachedLocationManager:didChangeAuthorizationStatus:)])
        [self.delegate cachedLocationManager:self didChangeAuthorizationStatus:status];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    NSLog(@"didUpdateToLocation:%@", newLocation); // TODO: Remove this line
    if ([self isLocationQualified:newLocation])
    {
        _cachedLocation = newLocation;
        
        [_locationManager stopUpdatingLocation];
        
        [self startExpirationTimer];
        
        if ([self.delegate respondsToSelector:@selector(cachedLocationManager:didRetrieveLocation:)])
            [self.delegate cachedLocationManager:self didRetrieveLocation:newLocation];
    }
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    if ([self.delegate respondsToSelector:@selector(cachedLocationManager:didFailWithError:)])
        [self.delegate cachedLocationManager:self didFailWithError:error];
}


#pragma mark - Private methods

- (void)setUpLocationManager
{
    _locationManager = [[CLLocationManager alloc] init];
    _locationManager.delegate = self;
}

- (void)setDefaultValues
{
    self.accuracyFilter = DBL_MAX;
    self.timeIntervalFilter = DBL_MAX;
}

- (void)updateLocationIfNecessary
{
    BOOL hasLocation = (self.location != nil);
    if (hasLocation == NO)
    {
        if (_needsLocation == YES)
            [_locationManager startUpdatingLocation];
        else
            [_locationManager stopUpdatingLocation];
    }
    else
    {
        [self startExpirationTimer];
    }
}
   
- (CLLocation *)lastLocation
{
    if (_cachedLocation == nil)
        _cachedLocation = _locationManager.location;
    
    return _cachedLocation;
}

- (BOOL)isLocationQualified:(CLLocation *)theLocation
{
    if (theLocation == nil)
        return NO;
    
    NSTimeInterval timeSinceEvent = [theLocation.timestamp timeIntervalSinceNow];
    BOOL isLocationQualified = (fabs(timeSinceEvent) <= self.timeIntervalFilter && theLocation.horizontalAccuracy <= self.accuracyFilter);
//    NSLog(@"(%f <= %f) && (%f <= %f) == %d", fabs(timeSinceEvent), self.timeIntervalFilter, theLocation.horizontalAccuracy, self.accuracyFilter, isLocationQualified);
    return isLocationQualified;
}


#pragma mark - Expiration timer methods

- (void)startExpirationTimer
{
    if (_expirationTimer != nil)
        [self stopExpirationTimer];
    
    NSTimeInterval timeSinceEvent = [self.location.timestamp timeIntervalSinceNow];
    NSTimeInterval expirationTimeInterval = self.timeIntervalFilter - fabs(timeSinceEvent);
    
    _expirationTimer = [NSTimer scheduledTimerWithTimeInterval:expirationTimeInterval target:self selector:@selector(cacheExpired:) userInfo:nil repeats:NO];
}

- (void)stopExpirationTimer
{
    [_expirationTimer invalidate];
    _expirationTimer = nil;
}

- (void)cacheExpired:(NSTimer *)theTimer
{
    [self updateLocationIfNecessary];
    
    if ([self.delegate respondsToSelector:@selector(cachedLocationManagerDidExpireCachedLocation:)])
        [self.delegate cachedLocationManagerDidExpireCachedLocation:self];
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
