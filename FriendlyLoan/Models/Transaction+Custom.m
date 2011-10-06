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

- (id)copyWithZone:(NSZone *)zone
{
    Transaction *copy = [[self class] allocWithZone:zone];
    
    
    return copy;
}

#pragma mark - Fix

// TODO: Replace with RIORelativeTime
- (NSString *)historySectionName
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"d MMMM yyyy"];
    NSString *formattedDateString = [formatter stringFromDate:self.createdTimestamp];
    
    return formattedDateString;
}


#pragma mark - Friend methods

// TODO: Sync problems WILL arise
+ (NSString *)friendNameForFriendID:(NSNumber *)friendID
{
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
    ABRecordID recordId = (ABRecordID)[friendID intValue];
    ABRecordRef personRef = ABAddressBookGetPersonWithRecordID(addressBook, recordId);
    
    if (personRef != NULL)
        return (__bridge_transfer NSString *)ABRecordCopyCompositeName(personRef);
    
    return nil;
}

// TODO: Resize (219x219 thumbnail size) and cache images
+ (UIImage *)friendImageForFriendID:(NSNumber *)friendID
{
    ABAddressBookRef addressBook = ABAddressBookCreate();
    ABRecordID recordId = (ABRecordID)[friendID intValue];
    ABRecordRef personRef = ABAddressBookGetPersonWithRecordID(addressBook, recordId);
    
    if (personRef != nil && ABPersonHasImageData(personRef))
    {
        return [UIImage imageWithData:(__bridge_transfer NSData *)ABPersonCopyImageDataWithFormat(personRef, kABPersonImageFormatThumbnail)];
    }
    return nil;
}

- (NSString *)friendName
{
    return [Transaction friendNameForFriendID:self.friendID];
}

#pragma mark - Lent methods

- (BOOL)lent
{
    return ([self.amount isNegative] == NO);
}

- (NSDecimalNumber *)absoluteAmount
{
    return (self.lent == YES) ? self.amount: [self.amount decimalNumberByNegating];
}

- (NSString *)lentDescriptionString
{
    return (self.lent == YES) ? NSLocalizedString(@"Lent", nil) : NSLocalizedString(@"Borrowed", nil);
}

- (NSString *)lentPrepositionString
{
    return (self.lent == YES) ? NSLocalizedString(@"To", nil) : NSLocalizedString(@"From", nil);
}

@end
