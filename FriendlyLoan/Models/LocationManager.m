//
//  LocationManager.m
//  FriendlyLoan
//
//  Created by Christian Rasmussen on 08.10.11.
//  Copyright (c) 2011 Rasmussen I/O. All rights reserved.
//

#import "LocationManager.h"


const CLLocationDistance kDistanceFilter = 100;


@implementation LocationManager

@synthesize delegate;
@synthesize locationManager, lastKnownLocation;

#pragma mark - CLLocationManagerDelegate methods

// FIXME: Fix this
- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status
{
    NSLog(@"%s %d %d", (char *)_cmd, status, [CLLocationManager locationServicesEnabled]);
    //    [self.attachLocationSwitch setOn:self.attachLocationState animated:YES];
}

// FIXME: Update method
- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    // If it's a relatively recent event, turn off updates to save power
    NSDate* eventDate = newLocation.timestamp;
    NSTimeInterval howRecent = [eventDate timeIntervalSinceNow];
    if (abs(howRecent) < 15.0)
    {
        self.lastKnownLocation = newLocation;
        NSLog(@"Delegated:%@", newLocation);
    }
    // else skip the event and process the next one.
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"%s %d %d %@", (char *)_cmd, [CLLocationManager authorizationStatus], [CLLocationManager locationServicesEnabled], error);
}

#pragma mark - Private methods

- (void)startUpdatingLocation
{
    NSLog(@"%s %d %d", (char *)_cmd, [CLLocationManager authorizationStatus], [CLLocationManager locationServicesEnabled]);
    
    if (self.locationManager == nil)
        self.locationManager = [[CLLocationManager alloc] init];
    
    self.locationManager.delegate = self;
    //    self.locationManager.purpose = NSLocalizedString(@"This app uses the location services to determine your location when adding a loan.", nil); // TODO: Add proper description
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    self.locationManager.distanceFilter = kDistanceFilter;
    
    NSLog(@"Starting update");
    [self.locationManager startUpdatingLocation];
    
    NSLog(@"Initial:%@", self.locationManager.location);
}

- (void)stopUpdatingLocation
{
    [self.locationManager stopUpdatingLocation];
}

@end
