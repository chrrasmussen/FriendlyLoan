//
//  NSDecimalNumber+RIOAdditions.h
//  FriendlyLoan
//
//  Created by Christian Rasmussen on 13.09.11.
//  Copyright (c) 2011 Rasmussen I/O. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDecimalNumber (RIOAdditions)

- (NSDecimalNumber *)decimalNumberByNegating;
- (BOOL)isNegative;

@end
