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
    PFObject *transaction = [PFObject objectWithClassName:@"Transaction"];
    
    NSDecimalNumber *negatedAmount = [self.amount decimalNumberByNegating];
    [transaction setValue:negatedAmount forKey:@"amount"];
    
    [transaction setValue:self.categoryID forKey:@"categoryId"];
    [transaction setValue:self.note forKey:@"note"];
    
    [transaction setValue:self.settled forKey:@"settled"];
    
    if (self.location) {
        PFGeoPoint *location = [PFGeoPoint geoPointWithLatitude:self.locationLatitudeValue longitude:self.locationLongitudeValue];
        [transaction setValue:location forKey:@"location"];
    }
    
    return transaction;
}

- (void)setValuesForPFObject:(PFObject *)pfObject
{
    self.requestID = [pfObject valueForKey:@"objectId"];
    
    self.amount = [pfObject valueForKey:@"amount"];
    
    self.categoryID = [pfObject valueForKey:@"categoryId"];
    self.note = [pfObject valueForKey:@"note"];
    
    self.settled = [pfObject valueForKey:@"settled"];
    
    self.createdAt = [pfObject valueForKey:@"createdAt"];
    self.updatedAt = [pfObject valueForKey:@"updatedAt"];
    
    PFGeoPoint *geoPoint = (PFGeoPoint *)[pfObject valueForKey:@"location"];
    if (geoPoint != nil) {
        self.attachLocation = [NSNumber numberWithBool:YES];
        [self setLocationWithLatitude:geoPoint.latitude longitude:geoPoint.longitude];
    }
}

@end
