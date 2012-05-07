//
//  PFTransaction.h
//  FriendlyLoan
//
//  Created by Christian Rasmussen on 07.05.12.
//  Copyright (c) 2012 Rasmussen I/O. All rights reserved.
//

#import <Parse/Parse.h>


@interface PFTransaction : PFObject

@property (nonatomic, strong) NSDecimalNumber *amount;
@property (nonatomic, strong) NSNumber *categoryId;
@property (nonatomic, strong) PFGeoPoint *location;
@property (nonatomic, strong) NSString *note;
@property (nonatomic, strong) PFUser *recipient;
@property (nonatomic, strong) PFUser *sender;
@property (nonatomic, strong) NSNumber *settled;

@end
