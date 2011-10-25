//
//  NSCalendar+RIOAdditions.h
//  FriendlyLoan
//
//  Created by Christian Rasmussen on 22.10.11.
//  Copyright (c) 2011 Rasmussen I/O. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSCalendar (RIOAdditions)

// Calendar ranges
- (NSRange)dayOfMonthRangeForDate:(NSDate *)aDate;
- (NSRange)weekOfYearRangeForDate:(NSDate *)aDate;
- (NSRange)monthOfYearRangeForDate:(NSDate *)aDate;

@end
