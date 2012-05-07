//
//  BackendManagerTransactionRequestDelegate.h
//  FriendlyLoan
//
//  Created by Christian Rasmussen on 07.05.12.
//  Copyright (c) 2012 Rasmussen I/O. All rights reserved.
//

#import <Foundation/Foundation.h>


@class BackendManager;
@class Transaction;


@protocol BackendManagerTransactionRequestDelegate <NSObject>

- (void)backendManager:(BackendManager *)backendManager displayTransactionRequest:(Transaction *)transaction;

@end
