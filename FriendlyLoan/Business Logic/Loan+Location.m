//
//  Loan+Location.m
//  FriendlyLoan
//
//  Created by Christian Rasmussen on 06.10.11.
//  Copyright (c) 2011 Rasmussen I/O. All rights reserved.
//

#import "Loan+Location.h"


@implementation Loan (Location)

//- (void)awakeFromInsert
//{
//    [super awakeFromInsert];
//}
//
//- (void)awakeFromFetch
//{
//    [super awakeFromFetch];
//}

- (void)setLocationWithLatitude:(CLLocationDegrees)latitude longitude:(CLLocationDegrees)longitude
{
//        [self willChangeValueForKey:@"locationStatus"];
//        self.location = [Location insertInManagedObjectContext:self.managedObjectContext];
//        [self didChangeValueForKey:@"locationStatus"];
    self.locationLatitude = @(latitude);
    self.locationLongitude = @(longitude);
}

//- (CLLocation *)location
//{
//    CLLocationCoordinate2D coordinate = [self coordinate];
//    if (CLLocationCoordinate2DIsValid(coordinate) == NO) {
//        return nil;
//    }
//    
//    CLLocation *location = [[CLLocation alloc] initWithLatitude:coordinate.latitude longitude:coordinate.longitude];
//    
//    return location;
//}

- (BOOL)hasLocation
{
    return ([self locationLatitude] != nil && [self locationLongitude] != nil);
}


#pragma mark - MKAnnotation methods

- (CLLocationCoordinate2D)coordinate
{
    CLLocationCoordinate2D location;
    location.latitude = [self locationLatitudeValue];
    location.longitude = [self locationLongitudeValue];
    
    return location;
}

@end
