//
//  Friend+Custom.h
//  FriendlyLoan
//
//  Created by Christian Rasmussen on 06.10.11.
//  Copyright (c) 2011 Rasmussen I/O. All rights reserved.
//

#import "Friend.h"

@interface Friend (Custom)

+ (NSString *)friendNameForFriendID:(NSNumber *)friendID;
+ (UIImage *)friendImageForFriendID:(NSNumber *)friendID;
- (NSString *)fullName;

@end
