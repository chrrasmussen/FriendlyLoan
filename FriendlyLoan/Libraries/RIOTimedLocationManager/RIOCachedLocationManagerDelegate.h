//
//  RIOTimedLocationManagerDelegate.h
//  FriendlyLoan
//
//  Created by Christian Rasmussen on 09.10.11.
//  Copyright (c) 2011 Rasmussen I/O. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>


@class RIOTimedLocationManager;

@protocol RIOTimedLocationManagerDelegate <NSObject>

@optional
- (void)timedLocationManager:(RIOTimedLocationManager *)locationManager didChangeAuthorizationStatus:(CLAuthorizationStatus)status;
- (void)timedLocationManager:(RIOTimedLocationManager *)locationManager didRetrieveLocation:(CLLocation *)location;
- (void)timedLocationManager:(RIOTimedLocationManager *)locationManager didFailWithError:(NSError *)error;

@end
