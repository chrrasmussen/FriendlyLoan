//
//  NSDate+RIOAdditions.h
//  FriendlyLoan
//
//  Created by Christian Rasmussen on 22.10.11.
//  Copyright (c) 2011 Rasmussen I/O. All rights reserved.
//

#import "NSDate+RIOAdditions.h"
#import "NSCalendar+RIOAdditions.h"


@interface NSDate (RIOAdditionsPrivateMethods)

- (NSDateComponents *)components;
- (NSRange)dayOfMonthRange;
- (NSRange)dayOfMonthRangeForToday;
- (NSRange)weekOfYearRange;
- (NSRange)weekOfYearRangeForToday;
- (NSRange)monthOfYearRange;
- (NSRange)monthOfYearRangeForToday;

@end


@implementation NSDate (RIOAdditions)

#pragma mark - Global state to enable testing

static NSCalendar *_currentCalendar;
static NSDate *_today;

+ (NSCalendar *)currentCalendar
{
    if (_currentCalendar == nil)
        return [NSCalendar currentCalendar];
    
    return _currentCalendar;
}

+ (void)setCurrentCalendar:(NSCalendar *)aCalendar
{
    _currentCalendar = aCalendar;
}

+ (NSDate *)today
{
    if (_today == nil)
        return [NSDate date];
    
    return _today;
}

+ (void)setToday:(NSDate *)aDate
{
    _today = aDate;
}


#pragma mark - Comparing dates

// Day
- (BOOL)isEqualToDateIgnoringTime:(NSDate *)aDate;
{
    return ([self isSameMonthAsDate:aDate] && [self day] == [aDate day]);
}

- (BOOL)isToday
{
    return [self isEqualToDateIgnoringTime:[NSDate today]];
}

- (BOOL)isTomorrow
{
    if ([self isThisMonth])
    {
        NSInteger nextDay = [[NSDate today] day] + 1;
        return ([self day] == nextDay);
    }
    else if ([self isNextMonth])
    {
        NSInteger firstDayOfMonth = [self dayOfMonthRange].location;
        NSInteger lastDayOfMonth = [self dayOfMonthRangeForToday].length;
        return ([self day] == firstDayOfMonth && [[NSDate today] day] == lastDayOfMonth);
    }
    
    return NO;
}

- (BOOL)isYesterday
{
    if ([self isThisMonth])
    {
        NSInteger lastDay = [[NSDate today] day] - 1;
        return ([self day] == lastDay);
    }
    else if ([self isLastMonth])
    {
        NSInteger lastDayOfMonth = [self dayOfMonthRange].length;
        NSInteger firstDayOfMonth = [self dayOfMonthRangeForToday].location;
        return ([self day] == lastDayOfMonth && [[NSDate today] day] == firstDayOfMonth);
    }
    
    return NO;
}

// Month
- (BOOL)isSameWeekAsDate:(NSDate *)aDate
{
    // TODO: Take care of special case where week 1 is extending through last and next year
    // HINT: Check if isLastMonth or isNextMonth to include first and last month of the the year before and after
    return ([self isSameYearAsDate:aDate] && [self week] == [aDate week]);
}

- (BOOL)isThisWeek
{
    return [self isSameWeekAsDate:[NSDate today]];
}

- (BOOL)isNextWeek
{
    if ([self isThisYear])
    {
        NSInteger nextWeek = [[NSDate today] week] + 1;
        return ([self week] == nextWeek);
    }
    else if ([self isNextYear])
    {
        NSInteger firstWeekOfYear = [self weekOfYearRange].location;
        NSInteger lastWeekOfYear = [self weekOfYearRangeForToday].length;
        return ([self week] == firstWeekOfYear && [[NSDate today] week] == lastWeekOfYear);
    }
    
    return NO;
}

- (BOOL)isLastWeek
{
    if ([self isThisYear])
    {
        NSInteger lastWeek = [[NSDate today] week] - 1;
        return ([self week] == lastWeek);
    }
    else if ([self isLastYear])
    {
        NSInteger lastWeekOfYear = [self weekOfYearRange].length;
        NSInteger firstWeekOfYear = [self weekOfYearRangeForToday].location;
        return ([self week] == lastWeekOfYear && [[NSDate today] week] == firstWeekOfYear);
    }
    
    return NO;
}

// Month
- (BOOL)isSameMonthAsDate:(NSDate *)aDate
{
    return ([self isSameYearAsDate:aDate] && [self month] == [aDate month]);
}

- (BOOL)isThisMonth
{
    return [self isSameMonthAsDate:[NSDate today]];
}

- (BOOL)isNextMonth
{
    if ([self isThisYear])
    {
        NSInteger nextMonth = [[NSDate today] month] + 1;
        return ([self month] == nextMonth);
    }
    else if ([self isNextYear])
    {
        NSInteger firstMonthOfYear = [self monthOfYearRange].location;
        NSInteger lastMonthOfYear = [self monthOfYearRangeForToday].length;
        return ([self month] == firstMonthOfYear && [[NSDate today] month] == lastMonthOfYear);
    }
    
    return NO;
}

- (BOOL)isLastMonth
{
    if ([self isThisYear])
    {
        NSInteger lastMonth = [[NSDate today] month] - 1;
        return ([self month] == lastMonth);
    }
    else if ([self isLastYear])
    {
        NSInteger lastMonthOfYear = [self monthOfYearRange].length;
        NSInteger firstMonthOfYear = [self monthOfYearRangeForToday].location;
        return ([self month] == lastMonthOfYear && [[NSDate today] month] == firstMonthOfYear);
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
    return [self isSameYearAsDate:[NSDate today]];
}

-(BOOL)isNextYear
{
    NSInteger nextYear = [[NSDate today] year] + 1;
    return ([self year] == nextYear);
}

- (BOOL)isLastYear
{
    NSInteger lastYear = [[NSDate today] year] - 1;
    return ([self year] == lastYear);
}

// Earlier/later date
- (BOOL)isEarlierThanDate:(NSDate *)aDate
{
    return ([self earlierDate:aDate] == self);
}

- (BOOL)isLaterThanDate:(NSDate *)aDate
{
    return ([self laterDate:aDate] == self);    
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
    NSDateComponents *components = [[NSDate currentCalendar] components:dateComponents fromDate:self];
    
    return components;
}

- (NSRange)dayOfMonthRange
{
    return [[NSDate currentCalendar] dayOfMonthRangeForDate:self];
}

- (NSRange)dayOfMonthRangeForToday
{
    return [[NSDate currentCalendar] dayOfMonthRangeForDate:[NSDate today]];
}

- (NSRange)weekOfYearRange
{
    return [[NSDate currentCalendar] weekOfYearRangeForDate:self];
}

- (NSRange)weekOfYearRangeForToday
{
    return [[NSDate currentCalendar] weekOfYearRangeForDate:[NSDate today]];
}

- (NSRange)monthOfYearRange
{
    return [[NSDate currentCalendar] monthOfYearRangeForDate:self];
}

- (NSRange)monthOfYearRangeForToday
{
    return [[NSDate currentCalendar] monthOfYearRangeForDate:[NSDate today]];
}

@end
