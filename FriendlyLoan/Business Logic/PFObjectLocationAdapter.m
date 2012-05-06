//
//  PFObjectLocationAdapter.m
//  FriendlyLoan
//
//  Created by Christian Rasmussen on 06.05.12.
//  Copyright (c) 2012 Rasmussen I/O. All rights reserved.
//

#import "PFObjectLocationAdapter.h"
#import <Parse/Parse.h>


@implementation PFObjectLocationAdapter {
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

- (NSNumber *)latitude
{
    return [_pfObject valueForKey:@"latitude"];
}

- (NSNumber *)longitude
{
    return [_pfObject valueForKey:@"longitude"];
}

@end
