//
//  Person.h
//  FriendlyLoan
//
//  Created by Christian Rasmussen on 09.09.11.
//  Copyright (c) 2011 Rasmussen I/O. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Person : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSNumber * id;
@property (nonatomic, retain) NSSet *transaction;
@end

@interface Person (CoreDataGeneratedAccessors)

- (void)addTransactionObject:(NSManagedObject *)value;
- (void)removeTransactionObject:(NSManagedObject *)value;
- (void)addTransaction:(NSSet *)values;
- (void)removeTransaction:(NSSet *)values;

@end
