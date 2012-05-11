//
//  Loan+PFObject.m
//  FriendlyLoan
//
//  Created by Christian Rasmussen on 02.05.12.
//  Copyright (c) 2012 Rasmussen I/O. All rights reserved.
//

#import "Loan+PFObject.h"
#import <Parse/Parse.h>

#import "Loan+Location.h"

#import "NSDecimalNumber+RIOAdditions.h"


@implementation Loan (PFObject)

- (PFObject *)PFObjectForValues
{
    PFObject *loan = [PFObject objectWithClassName:@"LoanRequest"];
    
    NSDecimalNumber *negatedAmount = [self.amount decimalNumberByNegating];
    [loan setValue:negatedAmount forKey:@"amount"];
    
    [loan setValue:self.categoryID forKey:@"categoryId"];
    [loan setValue:self.note forKey:@"note"];
    
    [loan setValue:self.settled forKey:@"settled"];
    
    if (self.location) {
        PFGeoPoint *location = [PFGeoPoint geoPointWithLatitude:self.locationLatitudeValue longitude:self.locationLongitudeValue];
        [loan setValue:location forKey:@"location"];
    }
    
    return loan;
}

- (void)setValuesForPFObject:(PFObject *)pfObject
{
    self.requestID = [pfObject valueForKey:@"objectId"];
    
    self.amount = [pfObject valueForKey:@"amount"];
    
    self.categoryID = [pfObject valueForKey:@"categoryId"];
    self.note = [pfObject valueForKey:@"note"];
    
    self.settled = [pfObject valueForKey:@"settled"];
    
    self.createdAt = [pfObject valueForKey:@"createdAt"];
    
    PFGeoPoint *geoPoint = (PFGeoPoint *)[pfObject valueForKey:@"location"];
    if (geoPoint != nil) {
        self.attachLocation = [NSNumber numberWithBool:YES];
        [self setLocationWithLatitude:geoPoint.latitude longitude:geoPoint.longitude];
    }
}

@end
