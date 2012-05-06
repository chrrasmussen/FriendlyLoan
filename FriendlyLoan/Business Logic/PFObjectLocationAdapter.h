//
//  PFObjectLocationAdapter.h
//  FriendlyLoan
//
//  Created by Christian Rasmussen on 06.05.12.
//  Copyright (c) 2012 Rasmussen I/O. All rights reserved.
//

#import "Location.h"


@class PFObject;


@interface PFObjectLocationAdapter : Location

- (id)initWithPFObject:(PFObject *)pfObject;

@end
