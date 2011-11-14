//
//  LocationManager.h
//  FriendlyLoan
//
//  Created by Christian Rasmussen on 08.10.11.
//  Copyright (c) 2011 Rasmussen I/O. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>


@protocol LocationManagerObserver;

@interface LocationManager : NSObject <CLLocationManagerDelegate>

@property (nonatomic, weak) id<LocationManagerObserver> delegate;

@property (nonatomic, readonly) BOOL locating;
@property (nonatomic, readonly) BOOL requiresLocationServicesInBackground;
@property (nonatomic, strong, readonly) CLLocation *qualifiedLocation;

+ (id)sharedManager;
+ (void)setSharedManager:(LocationManager *)manager;

- (void)startUpdatingLocation;
- (void)stopUpdatingLocation;

+ (BOOL)isLocationQualified:(CLLocation *)location;
+ (void)resolvePlaceNameForLocation:(CLLocationCoordinate2D)location completionHandler:(void (^)(NSString *placeName))completionHandler;

@end
