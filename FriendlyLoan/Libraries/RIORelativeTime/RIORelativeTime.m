//
//  RIORelativeTime.m
//  FriendlyLoan
//
//  Created by Christian Rasmussen on 03.10.11.
//  Copyright (c) 2011 Rasmussen I/O. All rights reserved.
//

#import "RIORelativeTime.h"

@implementation RIORelativeTime

+ (NSString *)relativeTimeForDate:(NSDate *)date
{
    NSUInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSWeekCalendarUnit | NSDayCalendarUnit;
    NSCalendar *gregorian = [NSCalendar currentCalendar];
    
    // Get end of today
    NSDateComponents *todayComponents = [gregorian components:unitFlags fromDate:[NSDate date]];
    todayComponents.hour = 23;
    todayComponents.minute = 59;
    todayComponents.second = 59;
    NSDate *todayDate = [gregorian dateFromComponents:todayComponents];
    NSLog(@"%@", todayComponents);
    NSLog(@"%@ vs %@", todayDate, date);
    
    // Get time since today
    NSDateComponents *dateComponents = [gregorian components:unitFlags fromDate:date toDate:todayDate options:0];
    NSInteger years = [dateComponents year];
    NSInteger months = [dateComponents month];
    NSInteger weeks = [dateComponents week];
    NSInteger days = [dateComponents day];
    
    
    if (years > 1)
        return @"Older";
    else if (years == 1)
        return @"Last year";
    else if (years == 0)
    {
        if (months > 1)
            return @"This year";
        else if (months == 1)
            return @"Last month";
        else if (months == 0)
        {
            if (weeks > 1)
                return @"This month";
            else if (weeks == 1)
                return @"Last week";
            else if (weeks == 0)
            {
                if (days > 1)
                    return @"This week";
                else if (days == 1)
                    return @"Yesterday";
                else
                    return @"Today";
            }
        }
    }
    
//    NSLog(@"Y:%d M:%d W:%d D:%d", years, months, weeks, days);
    
    return @"";
}

@end
