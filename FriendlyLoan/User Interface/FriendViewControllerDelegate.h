//
//  FriendViewControllerDelegate.h
//  FriendlyLoan
//
//  Created by Christian Rasmussen on 13.06.12.
//  Copyright (c) 2012 Rasmussen I/O. All rights reserved.
//

#import <Foundation/Foundation.h>


@class FriendViewController;


@protocol FriendViewControllerDelegate <NSObject>

@optional
- (void)friendViewController:(FriendViewController *)friendViewController didSelectFriendID:(NSNumber *)friendID;

@end
