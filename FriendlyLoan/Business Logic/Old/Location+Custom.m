//
//  Location+Custom.m
//  FriendlyLoan
//
//  Created by Christian Rasmussen on 06.10.11.
//  Copyright (c) 2011 Rasmussen I/O. All rights reserved.
//

#import "Location+Custom.h"


@implementation Location (Custom)

//- (void)awakeFromInsert
//{
//    [super awakeFromInsert];
//}
//
//- (void)awakeFromFetch
//{
//    [super awakeFromFetch];
//}

- (void)updateLocation:(CLLocation *)location
{
    self.latitude = [NSNumber numberWithDouble:location.coordinate.latitude];
    self.longitude = [NSNumber numberWithDouble:location.coordinate.longitude];
}


#pragma mark - MKAnnotation methods

- (CLLocationCoordinate2D)coordinate
{
    CLLocationCoordinate2D location;
    location.latitude = [self.latitude doubleValue];
    location.longitude = [self.longitude doubleValue];
    
    return location;
}

@end