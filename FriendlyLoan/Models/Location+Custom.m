//
//  Location+Custom.m
//  FriendlyLoan
//
//  Created by Christian Rasmussen on 06.10.11.
//  Copyright (c) 2011 Rasmussen I/O. All rights reserved.
//

#import "Location+Custom.h"

@interface Location ()

- (void)test;

@end

@implementation Location (Custom)

- (void)awakeFromFetch
{
    [super awakeFromFetch];
    
    // Resolve place name if necessary
    if (self.placeName == nil)
    {
        NSLog(@"Resolving place name");
    }
}

#pragma mark - MKAnnotation methods

- (CLLocationCoordinate2D)coordinate
{
    NSLog(@"Coordinate");
    CLLocationCoordinate2D location;
    location.latitude = [self.latitude doubleValue];
    location.longitude = [self.longitude doubleValue];
    
    return location;
}

//- (NSString *)title
//{
//    [self test];
//    return self.placeName;
//}


#pragma mark - Private methods

- (void)test
{
    NSLog(@"Test");
}

@end
