//
//  Location+Custom.m
//  FriendlyLoan
//
//  Created by Christian Rasmussen on 06.10.11.
//  Copyright (c) 2011 Rasmussen I/O. All rights reserved.
//

#import "Location+Custom.h"


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

- (void)test
{
    NSLog(@"Test");
}

@end
