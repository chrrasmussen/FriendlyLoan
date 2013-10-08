//
//  LocationManagerMock.h
//  FriendlyLoan
//
//  Created by Christian Rasmussen on 09.07.12.
//  Copyright (c) 2012 Rasmussen I/O. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FLLocationDelegate.h"


@class CLLocation;


@interface LocationDelegateMock : NSObject <FLLocationDelegate>

@property (nonatomic) BOOL addLocation;
@property (nonatomic, strong) CLLocation *location;

@end
