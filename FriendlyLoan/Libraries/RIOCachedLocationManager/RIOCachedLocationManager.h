//
//  RIOCachedLocationManager.h
//  FriendlyLoan
//
//  Created by Christian Rasmussen on 08.10.11.
//  Copyright (c) 2011 Rasmussen I/O. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>


@protocol RIOCachedLocationManagerDelegate;

@interface RIOCachedLocationManager : NSObject

// Location services
+ (CLAuthorizationStatus)authorizationStatus;
+ (BOOL)locationServicesEnabled;

// Delegate
@property (nonatomic, weak) id<RIOCachedLocationManagerDelegate> delegate;

// Desired accuracy
@property (nonatomic) CLLocationAccuracy desiredAccuracy;

// Filters
@property (nonatomic) CLLocationAccuracy accuracyFilter;
@property (nonatomic) CLLocationDistance distanceFilter;
@property (nonatomic) NSTimeInterval timeIntervalFilter;

// Controlling the location
@property (nonatomic, readonly) CLLocation *location;
@property (nonatomic) BOOL needsLocation;
- (void)invalidateCachedLocation;

@end
