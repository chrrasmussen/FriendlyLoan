//
//  Transaction+Friend.m
//  FriendlyLoan
//
//  Created by Christian Rasmussen on 06.10.11.
//  Copyright (c) 2011 Rasmussen I/O. All rights reserved.
//

#import "Transaction+Friend.h"

#import "FriendList.h"


@implementation Transaction (Friend)

//- (void)populateFieldsWithFriendID:(NSNumber *)friendID;
//{
//    // TODO: May need to clean up an existing Friend-entity
//    // TODO: Add more fields
//    //    ABAddressBookRef addressBook = ABAddressBookCreate();
//    //    ABRecordID recordId = (ABRecordID)[friendID intValue];
//    //    ABRecordRef personRef = ABAddressBookGetPersonWithRecordID(addressBook, recordId);
//    
//    self.friendID = friendID;
//}

- (NSString *)friendFullName
{
    return [FriendList friendNameForFriendID:self.friendID];
}

@end
