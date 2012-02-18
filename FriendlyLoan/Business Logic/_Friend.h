// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Friend.h instead.

#import <CoreData/CoreData.h>


extern const struct FriendAttributes {
	__unsafe_unretained NSString *friendID;
} FriendAttributes;

extern const struct FriendRelationships {
	__unsafe_unretained NSString *transaction;
} FriendRelationships;

extern const struct FriendFetchedProperties {
} FriendFetchedProperties;

@class Transaction;



@interface FriendID : NSManagedObjectID {}
@end

@interface _Friend : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (FriendID*)objectID;




@property (nonatomic, strong) NSNumber *friendID;


@property int32_t friendIDValue;
- (int32_t)friendIDValue;
- (void)setFriendIDValue:(int32_t)value_;

//- (BOOL)validateFriendID:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) Transaction* transaction;

//- (BOOL)validateTransaction:(id*)value_ error:(NSError**)error_;





@end

@interface _Friend (CoreDataGeneratedAccessors)

@end

@interface _Friend (CoreDataGeneratedPrimitiveAccessors)


- (NSNumber *)primitiveFriendID;
- (void)setPrimitiveFriendID:(NSNumber *)value;

- (int32_t)primitiveFriendIDValue;
- (void)setPrimitiveFriendIDValue:(int32_t)value_;





- (Transaction*)primitiveTransaction;
- (void)setPrimitiveTransaction:(Transaction*)value;


@end
