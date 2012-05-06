//
//  PFObjectFriendAdapter.h
//  FriendlyLoan
//
//  Created by Christian Rasmussen on 06.05.12.
//  Copyright (c) 2012 Rasmussen I/O. All rights reserved.
//

#import "Friend.h"


@class PFObject;


@interface PFObjectFriendAdapter : Friend

- (id)initWithPFObject:(PFObject *)pfObject;

@end
