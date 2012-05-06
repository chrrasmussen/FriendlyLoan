//
//  PFObjectFriendAdapter.m
//  FriendlyLoan
//
//  Created by Christian Rasmussen on 06.05.12.
//  Copyright (c) 2012 Rasmussen I/O. All rights reserved.
//

#import "PFObjectFriendAdapter.h"
#import <Parse/Parse.h>


@implementation PFObjectFriendAdapter {
    PFObject *_pfObject;
}

- (id)initWithPFObject:(PFObject *)pfObject
{
    self = [super init];
    if (self) {
        _pfObject = pfObject;
    }
    
    return self;
}

#pragma mark - Overriden methods

- (NSString *)fullName
{
    return [_pfObject valueForKey:@"fullName"];
}

@end
