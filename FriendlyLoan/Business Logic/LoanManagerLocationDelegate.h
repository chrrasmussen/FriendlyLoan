//
//  LoanManagerLocationDelegate.h
//  FriendlyLoan
//
//  Created by Christian Rasmussen on 09.02.12.
//  Copyright (c) 2012 Rasmussen I/O. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol LoanManagerLocationDelegate <NSObject>

- (void)startUpdatingLocation;
- (void)stopUpdatingLocation;

@end
