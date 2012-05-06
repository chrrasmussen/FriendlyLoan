//
//  BackendManagerLoginDelegate.h
//  FriendlyLoan
//
//  Created by Christian Rasmussen on 02.05.12.
//  Copyright (c) 2012 Rasmussen I/O. All rights reserved.
//

#import <Foundation/Foundation.h>


@class BackendManager;


@protocol BackendManagerLoginDelegate <NSObject>

@optional
- (void)backendManagerWillLogIn:(BackendManager *)backendManager;
- (void)backendManagerDidSucceedToLogIn:(BackendManager *)backendManager;
- (void)backendManager:(BackendManager *)backendManager didFailToLogInWithError:(NSError *)error;

- (void)backendManagerWillLogOut:(BackendManager *)backendManager;
- (void)backendManagerDidLogOut:(BackendManager *)backendManager;

@end
