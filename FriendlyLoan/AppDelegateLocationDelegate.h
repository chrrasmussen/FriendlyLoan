//
//  LocationDelegate.h
//  FriendlyLoan
//
//  Created by Christian Rasmussen on 28.01.12.
//  Copyright (c) 2012 Rasmussen I/O. All rights reserved.
//

#import <Foundation/Foundation.h>


@class AppDelegate;

@protocol AppDelegateLocationDelegate <NSObject>

- (void)appDelegate:(AppDelegate *)appDelegate didChangeAttachLocationStatus:(BOOL)status;

@end
