//
//  Transaction.h
//  FriendlyLoan
//
//  Created by Christian Rasmussen on 22.09.11.
//  Copyright (c) 2011 Rasmussen I/O. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Transaction : NSManagedObject

@property (nonatomic, retain) NSDecimalNumber * amount;
@property (nonatomic, retain) NSNumber * categoryID;
@property (nonatomic, retain) NSNumber * createdLatitude;
@property (nonatomic, retain) NSNumber * createdLongitude;
@property (nonatomic, retain) NSDate * createdTimeStamp;
@property (nonatomic, retain) NSDate * modifiedTimeStamp;
@property (nonatomic, retain) NSString * note;
@property (nonatomic, retain) NSNumber * friendID;

@end
