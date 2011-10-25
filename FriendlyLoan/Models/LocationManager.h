//
//  LocationManager.h
//  FriendlyLoan
//
//  Created by Christian Rasmussen on 08.10.11.
//  Copyright (c) 2011 Rasmussen I/O. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>


@protocol LocationManagerDelegate;

@interface LocationManager : NSObject <CLLocationManagerDelegate>

@property (nonatomic, weak) id<LocationManagerDelegate> delegate;

@property (nonatomic, readonly) BOOL locating;
@property (nonatomic, readonly) BOOL requiresLocationServicesInBackground;
@property (nonatomic, strong, readonly) CLLocation *qualifiedLocation;

+ (id)sharedManager;
+ (void)setSharedManager:(LocationManager *)manager;

- (void)startUpdatingLocation;
- (void)stopUpdatingLocation;

+ (BOOL)isLocationQualified:(CLLocation *)theLocation;
+ (void)resolvePlaceNameForLocation:(CLLocation *)CLLocation;

@end
