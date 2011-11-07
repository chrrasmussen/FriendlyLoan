//
//  FetchedFriendsController.h
//  FriendlyLoan
//
//  Created by Christian Rasmussen on 26.10.11.
//  Copyright (c) 2011 Rasmussen I/O. All rights reserved.
//

#import <Foundation/Foundation.h>

// TODO: Subclass of NSFetchResultedController?
@interface FetchedFriendsController : NSObject

- (id)initWithFriendID:(NSNumber *)friendID;

@end
