//
//  NSDate+RIOAdditions.h
//  FriendlyLoan
//
//  Created by Christian Rasmussen on 22.10.11.
//  Copyright (c) 2011 Rasmussen I/O. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NSDate (RIOAdditions)

// Decomposing dates
@property (readonly) NSInteger hour;
@property (readonly) NSInteger minute;
@property (readonly) NSInteger seconds;
@property (readonly) NSInteger day;
@property (readonly) NSInteger month;
@property (readonly) NSInteger week;
@property (readonly) NSInteger weekday;
@property (readonly) NSInteger nthWeekday; // e.g. 2nd Tuesday of the month == 2
@property (readonly) NSInteger year;

// Comparing dates
- (BOOL)isEqualToDateIgnoringTime:(NSDate *)aDate;
- (BOOL)isToday;
- (BOOL)isTomorrow;
- (BOOL)isYesterday;
- (BOOL)isSameWeekAsDate:(NSDate *)aDate;
- (BOOL)isThisWeek;
- (BOOL)isNextWeek;
- (BOOL)isLastWeek;
- (BOOL)isSameMonthAsDate:(NSDate *)aDate;
- (BOOL)isThisMonth;
- (BOOL)isNextMonth;
- (BOOL)isLastMonth;
- (BOOL)isSameYearAsDate:(NSDate *)aDate;
- (BOOL)isThisYear;
- (BOOL)isNextYear;
- (BOOL)isLastYear;
- (BOOL)isEarlierThanDate:(NSDate *)aDate;
- (BOOL)isLaterThanDate:(NSDate *)aDate;

// Global state to enable testing
+ (NSCalendar *)currentCalendar;
+ (void)setCurrentCalendar:(NSCalendar *)aCalendar;
+ (NSDate *)today;
+ (void)setToday:(NSDate *)aDate;

// TODO: Add unit tests
//NSDate *year2010 = [NSDate dateWithTimeIntervalSince1970:(60*60*24*365.25*40)];
//[NSDate setToday:year2010];
//NSDate *pastDate = [year2010 dateByAddingTimeInterval:-60*60*24*4];
//NSLog(@"%@ is %@", pastDate, [pastDate relativeDate]);
//NSLog(@"%d", [pastDate week]);

@end
