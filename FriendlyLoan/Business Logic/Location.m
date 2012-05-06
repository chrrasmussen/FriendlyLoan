//
//  Location.m
//  FriendlyLoan
//
//  Created by Christian Rasmussen on 06.10.11.
//  Copyright (c) 2011 Rasmussen I/O. All rights reserved.
//

#import "Location.h"


@implementation Location

//- (void)awakeFromInsert
//{
//    [super awakeFromInsert];
//}
//
//- (void)awakeFromFetch
//{
//    [super awakeFromFetch];
//}

- (void)setLocationWithLatitude:(double)latitude longitude:(double)longitude
{
    self.latitude = [NSNumber numberWithDouble:latitude];
    self.longitude = [NSNumber numberWithDouble:longitude];
}


#pragma mark - MKAnnotation methods

- (CLLocationCoordinate2D)coordinate
{
    CLLocationCoordinate2D location;
    location.latitude = [self latitudeValue];
    location.longitude = [self longitudeValue];
    
    return location;
}

@end
