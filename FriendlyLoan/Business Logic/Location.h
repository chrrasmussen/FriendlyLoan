//
//  Location.h
//  FriendlyLoan
//
//  Created by Christian Rasmussen on 06.10.11.
//  Copyright (c) 2011 Rasmussen I/O. All rights reserved.
//

#import "_Location.h"
#import <MapKit/MapKit.h>


@interface Location : _Location <MKAnnotation>

- (void)setLocationWithLatitude:(double)latitude longitude:(double)longitude;

@end
