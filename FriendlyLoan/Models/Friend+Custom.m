//
//  Friend+Custom.m
//  FriendlyLoan
//
//  Created by Christian Rasmussen on 06.10.11.
//  Copyright (c) 2011 Rasmussen I/O. All rights reserved.
//

#import "Friend+Custom.h"
#import <AddressBook/AddressBook.h>

#import "UIImage+RIOAdditions.h"


const CGFloat kThumbnailImageLength = 43.0;


@implementation Friend (Custom)

static NSCache *_thumbnailImages;

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
    
    NSString *friendName = (personRef != NULL) ? (__bridge_transfer NSString *)ABRecordCopyCompositeName(personRef) : nil;
    
    CFRelease(addressBook);
    
    return friendName;
}

+ (UIImage *)friendImageForFriendID:(NSNumber *)friendID
{
    // Create a cache
    if (_thumbnailImages == nil)
        _thumbnailImages = [[NSCache alloc] init];
    
    // Retreive thumbnail image from cache
    UIImage *thumbnailImage = [_thumbnailImages objectForKey:friendID];
    if (thumbnailImage == nil)
    {
        // Get person from address book
        ABAddressBookRef addressBook = ABAddressBookCreate();
        ABRecordID recordId = (ABRecordID)[friendID intValue];
        ABRecordRef personRef = ABAddressBookGetPersonWithRecordID(addressBook, recordId);
        
        // Create a thumbnail image
        if (personRef != NULL && ABPersonHasImageData(personRef))
        {
            CGFloat scale = [[UIScreen mainScreen] scale];
            CGSize thumbnailSize = CGSizeMake(kThumbnailImageLength * scale, kThumbnailImageLength * scale);
            
            UIImage *originalImage = [UIImage imageWithData:(__bridge_transfer NSData *)ABPersonCopyImageDataWithFormat(personRef, kABPersonImageFormatThumbnail)];
            thumbnailImage = [originalImage scaledImageWithSize:thumbnailSize];
            
            // Save to cache
            [_thumbnailImages setObject:thumbnailImage forKey:friendID];
        }
        
        CFRelease(addressBook);
    }
    
    return thumbnailImage;
}

// TODO: Add more fields
- (void)populateFieldsWithFriendID:(NSNumber *)friendID;
{
    // TODO: May need to clean up an existing Friend-entity
    
//    ABAddressBookRef addressBook = ABAddressBookCreate();
//    ABRecordID recordId = (ABRecordID)[friendID intValue];
//    ABRecordRef personRef = ABAddressBookGetPersonWithRecordID(addressBook, recordId);

    self.friendID = friendID;
}

- (NSString *)fullName
{
    return [[self class] friendNameForFriendID:self.friendID];
}

@end
