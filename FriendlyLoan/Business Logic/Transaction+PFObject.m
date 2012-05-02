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


@implementation Transaction (PFObject)

- (PFObject *)serializeAsPFObject
{
    PFObject *transaction = [PFObject objectWithClassName:@"Transaction"];
    
    [transaction setValue:self.amount forKey:@"amount"];
    [transaction setValue:self.categoryID forKey:@"categoryId"];
    
    if (self.note) {
        [transaction setValue:self.note forKey:@"note"];
    }
    
    [transaction setValue:[NSNumber numberWithBool:self.lentValue] forKey:@"lentToRecipient"];
    [transaction setValue:[NSNumber numberWithBool:self.settledValue] forKey:@"settledWithRecipient"];
    
    if (self.location) {
        PFGeoPoint *location = [PFGeoPoint geoPointWithLatitude:[self.location.latitude doubleValue] longitude:[self.location.longitude doubleValue]];
        [transaction setValue:location forKey:@"location"];
    }
    
    return transaction;
}

@end
