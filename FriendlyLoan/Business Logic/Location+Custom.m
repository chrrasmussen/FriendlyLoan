//
//  Location+Custom.m
//  FriendlyLoan
//
//  Created by Christian Rasmussen on 06.10.11.
//  Copyright (c) 2011 Rasmussen I/O. All rights reserved.
//

#import "Location+Custom.h"

#import "RIOTimedLocationManager.h"


@implementation Location (Custom)

- (void)awakeFromInsert
{
    [super awakeFromInsert];
    
    NSLog(@"%s", (char *)_cmd);
}

- (void)awakeFromFetch
{
    [super awakeFromFetch];
    
    // TODO: Resolve place name if necessary
    if (self.placeName == nil)
    {
//        [RIOTimedLocationManager resolvePlaceNameForLocation:self.coordinate completionHandler:^(NSString *placeName) {
//            // TODO: Fix implementation
//            NSLog(@"Resolved placeName:%@", placeName);
//        }];
    }
}

- (void)updateLocation
{
    // FIXME: Set correct flag depending on status
    self.status = [NSNumber numberWithInt:kLocationStatusLocating];
    
    // FIXME: Fix code when RIOTimedLocationManager is fixed
//    CLLocationCoordinate2D lastKnownLocation = [[[RIOTimedLocationManager sharedManager] qualifiedLocation] coordinate];
//    self.latitude = [NSNumber numberWithDouble:lastKnownLocation.latitude];
//    self.longitude = [NSNumber numberWithDouble:lastKnownLocation.longitude];
}


#pragma mark - MKAnnotation methods

- (CLLocationCoordinate2D)coordinate
{
    CLLocationCoordinate2D location;
    location.latitude = [self.latitude doubleValue];
    location.longitude = [self.longitude doubleValue];
    
    return location;
}

- (NSString *)title
{
    return self.placeName;
}

#pragma mark - Private methods

//- (void)test
//{
//    NSLog(@"Test");
//}

@end
