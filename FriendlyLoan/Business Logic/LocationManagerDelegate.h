//
//  LocationManagerDelegate.h
//  FriendlyLoan
//
//  Created by Christian Rasmussen on 09.10.11.
//  Copyright (c) 2011 Rasmussen I/O. All rights reserved.
//

#import <Foundation/Foundation.h>


@class RIOTimedLocationManager;

@protocol LocationManagerDelegate <NSObject>

@optional
- (void)locationManager:(RIOTimedLocationManager *)locationManager didFailWithError:(NSError *)error;
- (void)locationManager:(RIOTimedLocationManager *)locationManager didRetrieveLocation:(CLLocation *)location;

@end
