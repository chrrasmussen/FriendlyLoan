//
//  Transaction+CustomMethods.m
//  FriendlyLoan
//
//  Created by Christian Rasmussen on 10.09.11.
//  Copyright (c) 2011 Rasmussen I/O. All rights reserved.
//

#import "Transaction+Custom.h"
#import <AddressBook/AddressBook.h>

@implementation Transaction (Custom)

// TODO: Change the outputted format
// TODO: Also check timezone for output + Substitute with fuzzy time
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

+ (NSString *)personNameForId:(int)personId
{
    ABAddressBookRef addressBook = ABAddressBookCreate();
    ABRecordRef personRef = ABAddressBookGetPersonWithRecordID(addressBook, personId);
    
    if (personRef != NULL)
        return (__bridge_transfer NSString *)ABRecordCopyCompositeName(personRef);
    
    return nil;
}

- (NSString *)personName
{
    int personId = [self.personId intValue];
    
    return [Transaction personNameForId:personId];
}

@end
