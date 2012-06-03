//
//  FriendLookup.h
//  FriendlyLoan
//
//  Created by Christian Rasmussen on 29.05.12.
//  Copyright (c) 2012 Rasmussen I/O. All rights reserved.
//

#import "PFDynamicObject.h"


@interface FriendLookup : PFDynamicObject

@property (nonatomic, strong) PFUser *user;
@property (nonatomic, strong) NSString *hashedEmail;
@property (nonatomic, strong) NSString *hashedFacebookId;

@end
