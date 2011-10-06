//
//  Friend+Custom.m
//  FriendlyLoan
//
//  Created by Christian Rasmussen on 06.10.11.
//  Copyright (c) 2011 Rasmussen I/O. All rights reserved.
//

#import "Friend+Custom.h"
#import <AddressBook/AddressBook.h>

@implementation Friend (Custom)

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

- (NSString *)fullName
{
    return [[self class] friendNameForFriendID:self.friendID];
}

@end
