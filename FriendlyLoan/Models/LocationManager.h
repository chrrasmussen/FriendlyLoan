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

@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic, strong) CLLocation *lastKnownLocation;

- (void)startUpdatingLocation;
- (void)stopUpdatingLocation;

@end
