//
//  Transaction+PFObject.m
//  FriendlyLoan
//
//  Created by Christian Rasmussen on 02.05.12.
//  Copyright (c) 2012 Rasmussen I/O. All rights reserved.
//

#import "Transaction+PFObject.h"
#import <Parse/Parse.h>
#import "Location.h"
#import "NSDecimalNumber+RIOAdditions.h"

@implementation Transaction (PFObject)

- (PFObject *)serializeAsPFObject
{
    PFObject *transaction = [PFObject objectWithClassName:@"Transaction"];
    
    NSDecimalNumber *negatedAmount = [self.amount decimalNumberByNegating];
    [transaction setValue:negatedAmount forKey:@"amount"];
    
    [transaction setValue:self.categoryID forKey:@"categoryId"];
    [transaction setValue:self.note forKey:@"note"];
    
    [transaction setValue:[NSNumber numberWithBool:self.settledValue] forKey:@"settled"];
    
    if (self.location) {
        PFGeoPoint *location = [PFGeoPoint geoPointWithLatitude:[self.location.latitude doubleValue] longitude:[self.location.longitude doubleValue]];
        [transaction setValue:location forKey:@"location"];
    }
    
    return transaction;
}

- (void)setValuesForPFObject:(PFObject *)pfObject
{
    self.amount = [pfObject valueForKey:@"amount"];
    
    self.categoryID = [pfObject valueForKey:@"categoryId"];
    self.note = [pfObject valueForKey:@"note"];
    
    self.settled = [pfObject valueForKey:@"settled"];
    
    self.createdAt = [pfObject valueForKey:@"createdAt"];
    self.updatedAt = [pfObject valueForKey:@"updatedAt"];
    
    PFGeoPoint *location = (PFGeoPoint *)[pfObject valueForKey:@"location"];
    if (location != nil) {
        [self setLocationWithLatitude:location.latitude longitude:location.longitude];
    }
    
    self.accepted = [NSNumber numberWithBool:NO];
}

@end
