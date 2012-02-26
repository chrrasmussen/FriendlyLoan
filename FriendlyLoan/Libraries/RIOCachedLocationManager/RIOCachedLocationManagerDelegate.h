//
//  RIOTimedLocationManagerDelegate.h
//  FriendlyLoan
//
//  Created by Christian Rasmussen on 09.10.11.
//  Copyright (c) 2011 Rasmussen I/O. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>


@class RIOCachedLocationManager;

@protocol RIOCachedLocationManagerDelegate <NSObject>

@optional
- (void)cachedLocationManager:(RIOCachedLocationManager *)locationManager didChangeAuthorizationStatus:(CLAuthorizationStatus)status;
- (void)cachedLocationManager:(RIOCachedLocationManager *)locationManager didFailWithError:(NSError *)error;

//- (BOOL)cachedLocationManager:(RIOCachedLocationManager *)locationManager shouldCacheLocation:(CLLocation *)location;
- (void)cachedLocationManager:(RIOCachedLocationManager *)locationManager didRetrieveLocation:(CLLocation *)location;

- (void)cachedLocationManagerDidExpireCachedLocation:(RIOCachedLocationManager *)locationManager;

@end
