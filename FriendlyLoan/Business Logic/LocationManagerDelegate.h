//
//  LocationManagerDelegate.h
//  FriendlyLoan
//
//  Created by Christian Rasmussen on 09.10.11.
//  Copyright (c) 2011 Rasmussen I/O. All rights reserved.
//

#import <Foundation/Foundation.h>


@class LocationManager;

@protocol LocationManagerObserver <NSObject>

@optional
- (void)locationManager:(LocationManager *)locationManager didFailWithError:(NSError *)error;
- (void)locationManager:(LocationManager *)locationManager didRetrieveLocation:(CLLocation *)location;

@end
