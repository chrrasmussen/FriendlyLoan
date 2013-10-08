//
//  FLLocationDelegate.h
//  FriendlyLoan
//
//  Created by Christian Rasmussen on 15.07.12.
//  Copyright (c) 2012 Rasmussen I/O. All rights reserved.
//

#import <Foundation/Foundation.h>


@class CLLocation;


@protocol FLLocationDelegate <NSObject>

@property (nonatomic, readonly) BOOL addLocation;
@property (nonatomic, readonly) CLLocation *location;

@end
