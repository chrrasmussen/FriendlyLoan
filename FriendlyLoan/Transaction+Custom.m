//
//  Transaction+CustomMethods.m
//  FriendlyLoan
//
//  Created by Christian Rasmussen on 10.09.11.
//  Copyright (c) 2011 Rasmussen I/O. All rights reserved.
//

#import "Transaction+Custom.h"
#import <AddressBook/AddressBook.h>
#import "NSDecimalNumber+RIOAdditions.h"

@implementation Transaction (Custom)

// TODO: Change the outputted format
// TODO: Also check timezone for output + Substitute with fuzzy time
- (NSString *)historySectionName
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"d MMMM yyyy"];
    NSString *formattedDateString = [formatter stringFromDate:self.createdTimeStamp];
    
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

+ (NSString *)friendNameForID:(int)friendID
{
    // FIXME: Sync problems WILL arise
    // Check http://mattgemmell.com/2008/10/31/iphone-dev-tips-for-synced-contacts
    //    ABAddressBookRef addressBook = ABAddressBookCreate();
    //    ABRecordRef record = ABAddressBookGetPersonWithRecordID(addressBook, 1);
    ////    (__bridge_transfer NSString *)ABRecordCopyCompositeName(theSelectedPerson)
    //    NSLog(@"%08x %08x", record, NULL);
    //    if (record != NULL)
    //        NSLog(@"Test:%@", ABRecordCopyCompositeName(record));
    //    
    //    CFArrayRef array = ABAddressBookCopyPeopleWithName(addressBook, @"b c");
    //    NSLog(@"%@", array);
    ABAddressBookRef addressBook = ABAddressBookCreate();
    ABRecordRef personRef = ABAddressBookGetPersonWithRecordID(addressBook, friendID);
    
    if (personRef != NULL)
        return (__bridge_transfer NSString *)ABRecordCopyCompositeName(personRef);
    
    return nil;
}

- (NSString *)friendName
{
    int friendID = [self.friendID intValue];
    
    return [Transaction friendNameForID:friendID];
}

- (BOOL)lent
{
    return ([self.amount isNegative] == NO);
}

- (NSDecimalNumber *)absoluteAmount
{
    return (self.lent == YES) ? self.amount: [self.amount decimalNumberByNegating];
}

- (BOOL)hasLocation
{
    return (self.createdLatitude != nil && self.createdLongitude != nil);
}

#pragma mark - MKAnnotation methods

- (CLLocationCoordinate2D)coordinate
{
    CLLocationCoordinate2D location;
    location.latitude = [self.createdLatitude doubleValue];
    location.longitude = [self.createdLongitude doubleValue];
    
    return location;
}

@end
