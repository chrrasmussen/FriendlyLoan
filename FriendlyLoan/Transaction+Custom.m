//
//  Transaction+CustomMethods.m
//  FriendlyLoan
//
//  Created by Christian Rasmussen on 10.09.11.
//  Copyright (c) 2011 Rasmussen I/O. All rights reserved.
//

#import "Transaction+Custom.h"

@implementation Transaction (Custom)

// TODO: Change the outputted format
- (NSString *)historySectionName
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"d MMMM yyyy"];
    NSString *formattedDateString = [formatter stringFromDate:self.timeStamp];
    
    return formattedDateString;
//    NSString *rawDateString = [[[self.fetchedResultsController sections] objectAtIndex:section] name];
//    
//    // Parse raw date
//    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss ZZ"];
//    NSDate *date = [formatter dateFromString:rawDateString];
//    
//    // Convert date to desired format 
//    [formatter setDateFormat:@"d MMMM yyyy"];
//    NSString *formattedDateString = [formatter stringFromDate:date];
//    
//    return formattedDateString;  
}

@end
