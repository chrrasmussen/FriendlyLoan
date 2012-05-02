//
//  Transaction.h
//  FriendlyLoan
//
//  Created by Christian Rasmussen on 15.06.11.
//  Copyright (c) 2011 Rasmussen I/O. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Transaction : NSManagedObject {
@private
}
@property (nonatomic, retain) NSDate * timeStamp;
@property (nonatomic, retain) NSString * value;
@property (nonatomic, retain) NSString * person;
@property (nonatomic, retain) NSNumber * lent;

@end
