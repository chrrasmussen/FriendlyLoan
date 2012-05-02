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

+ (NSString *)relativeTimeForDate:(NSDate *)aDate
{
//    NSUInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSWeekCalendarUnit | NSDayCalendarUnit;
//    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
//    // TODO: Set weekday, timezone etc. Maybe locale is enough?
//    
//    NSDateComponents *pastComponents = [gregorian components:unitFlags fromDate:pastDate];
//    NSDateComponents *todayComponents = [gregorian components:unitFlags fromDate:[NSDate date]];
//    
//    NSInteger pastYear = [pastComponents year];
//    NSInteger pastMonth = [pastComponents month];
//    NSInteger pastWeek = [pastComponents week];
//    NSInteger pastDay = [pastComponents day];
//    
//    NSInteger currentYear = [todayComponents year];
//    NSInteger currentMonth = [todayComponents month];
//    NSInteger currentWeek = [todayComponents week];
//    NSInteger currentDay = [todayComponents day];
    
//    if ([aDate isToday])
    [aDate isNextMonth];
    return NSLocalizedStringFromTable(@"Today", @"RIORelativeDate", nil);
//    else
//    {
//        NSInteger currentLastMonth = currentMonth - 1;
//        NSInteger currentLastDay = currentDay - 1;
//        NSRange pastRange = [gregorian rangeOfUnit:NSDayCalendarUnit inUnit:NSMonthCalendarUnit forDate:pastDate];
        
//        if ((pastYear == currentYear) && (pastMonth == currentMonth) && (pastDay == currentLastDay)) ||
//            ((pastYear == currentYear))
//            return 
//        NSLog(@"%@", NSStringFromRange(range));
//        NSInteger yesterDay = 
//        if (false)
//    }
//        return @"Yesterday";
    
//    if (pastYear == currentYear)
//    {
//        if (pastMonth == currentMonth)
//        {
//            if (pastWeek == currentWeek)
//            {
//                if (pastDay == currentDay)
//                {
//                    return @"Today";
//                }
//                else
//                {
//                    if (pastDay == (currentDay - 1))
//                        return @"Yesterday";
//                    else
//                        return @"This week";
//                }
//            }
//            else
//            {
//                if (pastWeek == (currentWeek - 1))
//                    return @"Last week";
//                else
//                    return @"This month";
//            }
//        }
//        else
//        {
//            if (pastMonth == (currentMonth - 1))
//                return @"Last month";
//            else
//                return @"This year";
//        }
//    }
//    else
//    {
//        if (pastYear == (currentYear - 1))
//            return @"Last year";
//        else
//            return NSLocalizedStringFromTable(@"Older", @"RIORelativeDate", nil);
//    }
}

@end
