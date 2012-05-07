//
//  Transaction+Location.h
//  FriendlyLoan
//
//  Created by Christian Rasmussen on 06.10.11.
//  Copyright (c) 2011 Rasmussen I/O. All rights reserved.
//

#import "Transaction.h"
#import <MapKit/MapKit.h>


@interface Transaction (Location) <MKAnnotation>

- (void)setLocationWithLatitude:(CLLocationDegrees)latitude longitude:(CLLocationDegrees)longitude;

- (CLLocation *)location;

@end
