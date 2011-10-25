//
//  RIORelativeDate.m
//  FriendlyLoan
//
//  Created by Christian Rasmussen on 03.10.11.
//  Copyright (c) 2011 Rasmussen I/O. All rights reserved.
//

#import "RIORelativeDate.h"
#import "NSDate+RIOAdditions.h"


@implementation RIORelativeDate

+ (NSString *)relativeDateForDate:(NSDate *)aDate
{
    if ([aDate isToday])
        return NSLocalizedStringFromTable(@"Today", @"RIORelativeDate", nil);
    else if ([aDate isYesterday])
        return NSLocalizedStringFromTable(@"Yesterday", @"RIORelativeDate", nil);
    else if ([aDate isThisWeek])
        return NSLocalizedStringFromTable(@"This week", @"RIORelativeDate", nil);
    else if ([aDate isLastWeek])
        return NSLocalizedStringFromTable(@"Last week", @"RIORelativeDate", nil);
    else if ([aDate isThisMonth])
        return NSLocalizedStringFromTable(@"This month", @"RIORelativeDate", nil);
    else if ([aDate isLastMonth])
        return NSLocalizedStringFromTable(@"Last month", @"RIORelativeDate", nil);
    else if ([aDate isThisYear])
        return NSLocalizedStringFromTable(@"This year", @"RIORelativeDate", nil);
    else if ([aDate isLastYear])
        return NSLocalizedStringFromTable(@"Last year", @"RIORelativeDate", nil);
    else
        return NSLocalizedStringFromTable(@"Older", @"RIORelativeDate", nil);
}

@end
