//
//  Location+Custom.h
//  FriendlyLoan
//
//  Created by Christian Rasmussen on 06.10.11.
//  Copyright (c) 2011 Rasmussen I/O. All rights reserved.
//

#import "Location.h"
#import "MapKit/MapKit.h"


enum {
    kLocationStatusDisabled  = 0,
    kLocationStatusLocating  = 1,
    kLocationStatusFailed    = 2,
    kLocationStatusRetrieved = 3
};


@interface Location (Custom) <MKAnnotation>

@end
