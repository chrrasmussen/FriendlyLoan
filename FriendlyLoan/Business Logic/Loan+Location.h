//
//  Loan+Location.h
//  FriendlyLoan
//
//  Created by Christian Rasmussen on 06.10.11.
//  Copyright (c) 2011 Rasmussen I/O. All rights reserved.
//

#import "Loan.h"
#import <MapKit/MapKit.h>


@interface Loan (Location) <MKAnnotation>

- (void)setLocationWithLatitude:(CLLocationDegrees)latitude longitude:(CLLocationDegrees)longitude;

- (BOOL)hasLocation;
//- (CLLocation *)location;

@end
