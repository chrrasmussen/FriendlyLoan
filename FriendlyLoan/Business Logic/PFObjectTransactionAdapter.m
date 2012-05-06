//
//  TransactionPFObjectAdapter.m
//  FriendlyLoan
//
//  Created by Christian Rasmussen on 06.05.12.
//  Copyright (c) 2012 Rasmussen I/O. All rights reserved.
//

#import "PFObjectTransactionAdapter.h"
#import <Parse/Parse.h>

#import "PFObjectFriendAdapter.h"
#import "PFObjectLocationAdapter.h"


@implementation PFObjectTransactionAdapter {
    PFObject *_pfObject;
    Friend *_friend;
    Location *_location;
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

- (NSDate *)createdAt
{
    return [_pfObject valueForKey:@"createdAt"];
}

- (NSDate *)updatedAt
{
    return [_pfObject valueForKey:@"createdAt"];
}

- (NSString *)historySectionName
{
    return NSLocalizedString(@"Transaction Requests", @"Section name for transaction requests");
}

- (NSNumber *)settled
{
    return [_pfObject valueForKey:@"settledByRecipient"];
}

- (NSDecimalNumber *)amount
{
    return [_pfObject valueForKey:@"amount"];
}

- (Friend *)friend
{
    if (_friend == nil) {
        _friend = [[PFObjectFriendAdapter alloc] initWithPFObject:_pfObject];
    }
    
    return _friend;
}

- (Location *)location
{
    if (_location == nil) {
        PFGeoPoint *getPoint = [_pfObject valueForKey:@"location"];
        if (getPoint == nil) {
            return nil;
        }
        
        _location = [[PFObjectLocationAdapter alloc] initWithPFObject:_pfObject];
    }
    
    return _location;
}

@end