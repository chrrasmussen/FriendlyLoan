//
//  Friend.h
//  FriendlyLoan
//
//  Created by Christian Rasmussen on 06.10.11.
//  Copyright (c) 2011 Rasmussen I/O. All rights reserved.
//

#import "_Friend.h"

@interface Friend : _Friend

+ (NSString *)friendNameForFriendID:(NSNumber *)friendID;
+ (UIImage *)friendImageForFriendID:(NSNumber *)friendID;

- (void)populateFieldsWithFriendID:(NSNumber *)friendID;

- (NSString *)fullName;

@end
