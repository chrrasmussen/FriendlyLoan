//
//  FLFriend.h
//  FriendlyLoan
//
//  Created by Christian Rasmussen on 16.07.12.
//  Copyright (c) 2012 Rasmussen I/O. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol FLPerson <NSObject>

@property (nonatomic, readonly) NSString *personUUID;
@property (nonatomic, readonly) NSString *firstName;
@property (nonatomic, readonly) NSString *lastName;

@end
