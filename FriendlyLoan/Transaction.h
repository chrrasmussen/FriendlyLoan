//
//  Transaction.h
//  FriendlyLoan
//
//  Created by Christian Rasmussen on 12.09.11.
//  Copyright (c) 2011 Rasmussen I/O. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Transaction : NSManagedObject

@property (nonatomic, retain) NSDecimalNumber * amount;
@property (nonatomic, retain) NSNumber * category;
@property (nonatomic, retain) NSNumber * lent;
@property (nonatomic, retain) NSString * location;
@property (nonatomic, retain) NSString * note;
@property (nonatomic, retain) NSNumber * personId;
@property (nonatomic, retain) NSDate * timeStamp;

@end
