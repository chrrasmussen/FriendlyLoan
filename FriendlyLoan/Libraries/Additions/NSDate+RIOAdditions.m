//
//  NSDate+RIOAdditions.h
//  FriendlyLoan
//
//  Created by Christian Rasmussen on 22.10.11.
//  Copyright (c) 2011 Rasmussen I/O. All rights reserved.
//

#import "NSDate+RIOAdditions.h"


@interface NSDate (RIOAdditionsPrivateMethods)

- (NSDateComponents *)components;

@end


@implementation NSDate (RIOAdditions)


#pragma mark - Comparing dates

// Day
- (BOOL)isEqualToDateIgnoringTime:(NSDate *)aDate;
{
    return ([self isSameMonthAsDate:aDate] && [self day] == [aDate day]);
}

- (BOOL)isToday
{
    return [self isEqualToDateIgnoringTime:[NSDate date]];
}

- (BOOL)isTomorrow
{
    if ([self isThisMonth])
    {
        NSInteger nextDay = [[NSDate date] day] + 1;
        return ([self month] == nextDay);
    }
    else if ([self isNextMonth])
    {
        NSInteger firstDayOfMonth = [self dayOfMonthRangeForDate:self].location;
        NSInteger lastDayOfMonth = [self dayOfMonthRangeForToday].length;
        return ([self month] == firstDayOfMonth && [[NSDate date] month] == lastDayOfMonth);
    }
    
    return NO;
}

- (BOOL)isYesterday
{
//    if ([self isThisYear])
//    {
//        NSInteger lastMonth = [[NSDate date] month] - 1;
//        return ([self month] == lastMonth);
//    }
//    else if ([self isLastYear])
//    {
//        NSInteger lastMonthOfYear = [self monthOfYearRangeForDate:self].length;
//        NSInteger firstMonthOfYear = [self monthOfYearRangeForToday].location;
//        return ([self month] == lastMonthOfYear && [[NSDate date] month] == firstMonthOfYear);
//    }
    
    return NO;
}

// Month
- (BOOL)isSameWeekAsDate:(NSDate *)aDate
{
    return ([self isSameYearAsDate:aDate] && [self week] == [aDate week]);
}

- (BOOL)isThisWeek
{
    return [self isSameWeekAsDate:[NSDate date]];
}

- (BOOL)isNextWeek
{
//    if ([self isThisYear])
//    {
//        NSInteger nextMonth = [[NSDate date] month] + 1;
//        return ([self month] == nextMonth);
//    }
//    else if ([self isNextYear])
//    {
//        NSInteger firstMonthOfYear = [self monthOfYearRangeForDate:self].location;
//        NSInteger lastMonthOfYear = [self monthOfYearRangeForToday].length;
//        return ([self month] == firstMonthOfYear && [[NSDate date] month] == lastMonthOfYear);
//    }
    
    return NO;
}

- (BOOL)isLastWeek
{
//    if ([self isThisYear])
//    {
//        NSInteger lastMonth = [[NSDate date] month] - 1;
//        return ([self month] == lastMonth);
//    }
//    else if ([self isLastYear])
//    {
//        NSInteger lastMonthOfYear = [self monthOfYearRangeForDate:self].length;
//        NSInteger firstMonthOfYear = [self monthOfYearRangeForToday].location;
//        return ([self month] == lastMonthOfYear && [[NSDate date] month] == firstMonthOfYear);
//    }
    
    return NO;
}

// Month
- (BOOL)isSameMonthAsDate:(NSDate *)aDate
{
    return ([self isSameYearAsDate:aDate] && [self month] == [aDate month]);
}

- (BOOL)isThisMonth
{
    return [self isSameMonthAsDate:[NSDate date]];
}

- (BOOL)isNextMonth
{
    if ([self isThisYear])
    {
        NSInteger nextMonth = [[NSDate date] month] + 1;
        return ([self month] == nextMonth);
    }
    else if ([self isNextYear])
    {
        NSInteger firstMonthOfYear = [self monthOfYearRangeForDate:self].location;
        NSInteger lastMonthOfYear = [self monthOfYearRangeForToday].length;
        return ([self month] == firstMonthOfYear && [[NSDate date] month] == lastMonthOfYear);
    }
    
    return NO;
}

- (BOOL)isLastMonth
{
    if ([self isThisYear])
    {
        NSInteger lastMonth = [[NSDate date] month] - 1;
        return ([self month] == lastMonth);
    }
    else if ([self isLastYear])
    {
        NSInteger lastMonthOfYear = [self monthOfYearRangeForDate:self].length;
        NSInteger firstMonthOfYear = [self monthOfYearRangeForToday].location;
        return ([self month] == lastMonthOfYear && [[NSDate date] month] == firstMonthOfYear);
    }
    
    return NO;
}

// Year
- (BOOL)isSameYearAsDate:(NSDate *)aDate
{
    return ([self year] == [aDate year]);
}

- (BOOL)isThisYear
{
    return [self isSameYearAsDate:[NSDate date]];
}

-(BOOL)isNextYear
{
    NSInteger nextYear = [[NSDate date] year] + 1;
    return ([self year] == nextYear);
}

- (BOOL)isLastYear
{
    NSInteger lastYear = [[NSDate date] year] - 1;
    return ([self year] == lastYear);
}


#pragma mark - Ranges

- (NSRange)dayOfMonthRangeForDate:(NSDate *)aDate
{
    return [[NSCalendar currentCalendar] rangeOfUnit:NSDayCalendarUnit inUnit:NSMonthCalendarUnit forDate:aDate];
}

- (NSRange)dayOfMonthRangeForToday
{
    return [self dayOfMonthRangeForDate:[NSDate date]];
}

- (NSRange)weekOfYearRangeForDate:(NSDate *)aDate
{
    return [[NSCalendar currentCalendar] rangeOfUnit:NSWeekCalendarUnit inUnit:NSYearCalendarUnit forDate:aDate];
}

- (NSRange)weekOfYearRangeForToday
{
    return [self weekOfYearRangeForDate:[NSDate date]];
}

- (NSRange)monthOfYearRangeForDate:(NSDate *)aDate
{
    return [[NSCalendar currentCalendar] rangeOfUnit:NSMonthCalendarUnit inUnit:NSYearCalendarUnit forDate:aDate];
}

- (NSRange)monthOfYearRangeForToday
{
    return [self monthOfYearRangeForDate:[NSDate date]];
}


#pragma mark - Decomposing dates

- (NSInteger)hour
{
	return [[self components] hour];
}

- (NSInteger)minute
{
	return [[self components] minute];
}

- (NSInteger)seconds
{
	return [[self components] second];
}

- (NSInteger)day
{
	return [[self components] day];
}

- (NSInteger)month
{
	return [[self components] month];
}

- (NSInteger)week
{
	return [[self components] week];
}

- (NSInteger)weekday
{
	return [[self components] weekday];
}

- (NSInteger)nthWeekday
{
	return [[self components] weekdayOrdinal];
}
- (NSInteger)year
{
	return [[self components] year];
}


#pragma mark - Private methods

- (NSDateComponents *)components
{
    NSUInteger dateComponents = NSYearCalendarUnit| NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekCalendarUnit |  NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit | NSWeekdayCalendarUnit | NSWeekdayOrdinalCalendarUnit;
    NSDateComponents *components = [[NSCalendar currentCalendar] components:dateComponents fromDate:self];
    
    return components;
}

@end
