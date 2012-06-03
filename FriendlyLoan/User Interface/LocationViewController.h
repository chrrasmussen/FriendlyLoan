//
//  LocationViewController.h
//  FriendlyLoan
//
//  Created by Christian Rasmussen on 19.05.12.
//  Copyright (c) 2012 Rasmussen I/O. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>


@interface LocationViewController : UIViewController <MKAnnotation>

@property (nonatomic) CLLocationCoordinate2D locationCoordinate;

@property (nonatomic, strong) IBOutlet MKMapView *mapView;

@end
