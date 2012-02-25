//
//  RIOCachedLocationManager.h
//  FriendlyLoan
//
//  Created by Christian Rasmussen on 08.10.11.
//  Copyright (c) 2011 Rasmussen I/O. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>


extern NSString * const RIOCachedLocationManagerErrorDomain;


@protocol RIOCachedLocationManagerDelegate;

@interface RIOCachedLocationManager : NSObject

// Delegate
@property (nonatomic, weak) id<RIOCachedLocationManagerDelegate> delegate;

// Desired accuracy
@property (nonatomic) CLLocationAccuracy desiredAccuracy;

// Filters
@property (nonatomic) CLLocationAccuracy accuracyFilter;
@property (nonatomic) CLLocationDistance distanceFilter;
@property (nonatomic) NSTimeInterval timeIntervalFilter;

// Maximum locating duration
@property (nonatomic) NSTimeInterval maximumLocatingDuration;

// Purpose
@property (nonatomic, copy) NSString *purpose;

// Location status
@property (nonatomic, readonly, getter = isLocating) BOOL locating;
@property (nonatomic, readonly) CLLocation *location;

// Location services
+ (CLAuthorizationStatus)authorizationStatus;
+ (BOOL)locationServicesEnabled;

// Controlling the updates
- (void)startUpdatingLocation;
- (void)stopUpdatingLocation;

@end
