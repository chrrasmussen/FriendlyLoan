//
//  NSDate+RIORelativeDate.m
//  FriendlyLoan
//
//  Created by Christian Rasmussen on 03.10.11.
//  Copyright (c) 2011 Rasmussen I/O. All rights reserved.
//

#import "NSDate+RIORelativeDate.h"
#import "RIORelativeDate.h"

@implementation NSDate (RIORelativeDate)

- (NSString *)relativeTime
{
    return [RIORelativeDate relativeTimeForDate:self];
}

@end
