//
//  NSCalendar+RIOAdditions.m
//  FriendlyLoan
//
//  Created by Christian Rasmussen on 22.10.11.
//  Copyright (c) 2011 Rasmussen I/O. All rights reserved.
//

#import "NSCalendar+RIOAdditions.h"

@implementation NSCalendar (RIOAdditions)

#pragma mark - Calendar ranges

- (NSRange)dayOfMonthRangeForDate:(NSDate *)aDate
{
    return [self rangeOfUnit:NSDayCalendarUnit inUnit:NSMonthCalendarUnit forDate:aDate];
}

- (NSRange)weekOfYearRangeForDate:(NSDate *)aDate
{
    return [self rangeOfUnit:NSWeekCalendarUnit inUnit:NSYearCalendarUnit forDate:aDate];
}

- (NSRange)monthOfYearRangeForDate:(NSDate *)aDate
{
    return [self rangeOfUnit:NSMonthCalendarUnit inUnit:NSYearCalendarUnit forDate:aDate];
}

@end
