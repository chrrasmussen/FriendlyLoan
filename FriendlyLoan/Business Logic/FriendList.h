//
//  FriendList.h
//  FriendlyLoan
//
//  Created by Christian Rasmussen on 07.05.12.
//  Copyright (c) 2012 Rasmussen I/O. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface FriendList : NSObject

+ (NSString *)friendNameForFriendID:(NSNumber *)friendID;
+ (UIImage *)friendImageForFriendID:(NSNumber *)friendID;

@end
