//
//  RIORelativeDate.h
//  FriendlyLoan
//
//  Created by Christian Rasmussen on 03.10.11.
//  Copyright (c) 2011 Rasmussen I/O. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSDate+RIORelativeDate.h"

@interface RIORelativeDate : NSObject

+ (NSString *)relativeTimeForDate:(NSDate *)aDate;

@end
