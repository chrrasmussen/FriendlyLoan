//
//  LocationViewController.m
//  FriendlyLoan
//
//  Created by Christian Rasmussen on 19.05.12.
//  Copyright (c) 2012 Rasmussen I/O. All rights reserved.
//

#import "LocationViewController.h"


const CLLocationDistance kMapViewLocationDistance = 1000;


@implementation LocationViewController

@synthesize locationCoordinate;
@synthesize mapView;

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    [self setUpMapView];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


#pragma mark - MKAnnotation methods

- (CLLocationCoordinate2D)coordinate
{
    return self.locationCoordinate;
}


#pragma mark - Private methods

- (void)setUpMapView
{
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance([self coordinate], kMapViewLocationDistance, kMapViewLocationDistance);
    [self.mapView setRegion:region animated:NO];
    
    [self.mapView addAnnotation:self];
}

// TODO: Save map view as an image
//UIGraphicsBeginImageContext(mapView.frame.size);
//[mapView.layer renderInContext:UIGraphicsGetCurrentContext()];
//UIImage *mapImage = UIGraphicsGetImageFromCurrentImageContext();
//UIGraphicsEndImageContext();
//
//NSData *mapData = UIImagePNGRepresentation(mapImage);
//[mapData writeToFile:[self myFilePath:@"yourMap.png"] atomically:YES];
@end
