//
//  Loan+LoanRequest.m
//  FriendlyLoan
//
//  Created by Christian Rasmussen on 02.05.12.
//  Copyright (c) 2012 Rasmussen I/O. All rights reserved.
//

#import "Loan+LoanRequest.h"

#import "Loan+Location.h"
#import "NSDecimalNumber+RIOAdditions.h"


@implementation Loan (LoanRequest)

- (LoanRequest *)loanRequestForValues
{
    LoanRequest *loanRequest = [LoanRequest object];
    
//    NSDecimalNumber *negatedAmount = [self.amount decimalNumberByNegating];
//    [loan setValue:negatedAmount forKey:@"amount"];
//    
//    [loan setValue:self.categoryID forKey:@"categoryId"];
//    
//    if (self.note != nil) {
//        [loan setValue:self.note forKey:@"note"];
//    }
//    
//    [loan setValue:self.settled forKey:@"settled"];
//    
//    if ([self hasLocation]) {
//        PFGeoPoint *location = [PFGeoPoint geoPointWithLatitude:self.locationLatitudeValue longitude:self.locationLongitudeValue];
//        [loan setValue:location forKey:@"location"];
//    }
    
    loanRequest.amount = [self.amount decimalNumberByNegating];
    
    loanRequest.categoryId = self.categoryID;
    
    if (self.note != nil) {
        loanRequest.note = self.note;
    }
    
    loanRequest.settled = [NSNumber numberWithBool:self.settledValue];
    
    if ([self hasLocation]) {
        loanRequest.location = [PFGeoPoint geoPointWithLatitude:self.locationLatitudeValue longitude:self.locationLongitudeValue];
    }
    
    return loanRequest;
}

- (void)setValuesForLoanRequest:(LoanRequest *)loanRequest
{
    self.requestID = loanRequest.objectId;
    
    self.amount = loanRequest.amount;
    
    // TODO: Fix automatic friend ID
    self.friendID = [NSNumber numberWithInt:3554];
    
    self.categoryID = loanRequest.categoryId;
    self.note = loanRequest.note;
    
    self.settled = loanRequest.settled;
    
    self.createdAt = loanRequest.createdAt;
    
    PFGeoPoint *geoPoint = loanRequest.location;
    if (geoPoint != nil) {
        self.attachLocation = [NSNumber numberWithBool:YES];
        [self setLocationWithLatitude:geoPoint.latitude longitude:geoPoint.longitude];
    }
    
    self.requestAcceptedValue = NO;
}

@end
