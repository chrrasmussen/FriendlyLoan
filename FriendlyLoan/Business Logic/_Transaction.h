// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Transaction.h instead.

#import <CoreData/CoreData.h>


extern const struct TransactionAttributes {
	__unsafe_unretained NSString *amount;
	__unsafe_unretained NSString *attachLocation;
	__unsafe_unretained NSString *categoryID;
	__unsafe_unretained NSString *createdTimestamp;
	__unsafe_unretained NSString *modifiedTimestamp;
	__unsafe_unretained NSString *note;
	__unsafe_unretained NSString *settled;
} TransactionAttributes;

extern const struct TransactionRelationships {
	__unsafe_unretained NSString *friend;
	__unsafe_unretained NSString *location;
} TransactionRelationships;

extern const struct TransactionFetchedProperties {
} TransactionFetchedProperties;

@class Friend;
@class Location;









@interface TransactionID : NSManagedObjectID {}
@end

@interface _Transaction : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (TransactionID*)objectID;




@property (nonatomic, strong) NSDecimalNumber *amount;


//- (BOOL)validateAmount:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSNumber *attachLocation;


@property BOOL attachLocationValue;
- (BOOL)attachLocationValue;
- (void)setAttachLocationValue:(BOOL)value_;

//- (BOOL)validateAttachLocation:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSNumber *categoryID;


@property int16_t categoryIDValue;
- (int16_t)categoryIDValue;
- (void)setCategoryIDValue:(int16_t)value_;

//- (BOOL)validateCategoryID:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSDate *createdTimestamp;


//- (BOOL)validateCreatedTimestamp:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSDate *modifiedTimestamp;


//- (BOOL)validateModifiedTimestamp:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSString *note;


//- (BOOL)validateNote:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSNumber *settled;


@property BOOL settledValue;
- (BOOL)settledValue;
- (void)setSettledValue:(BOOL)value_;

//- (BOOL)validateSettled:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) Friend* friend;

//- (BOOL)validateFriend:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) Location* location;

//- (BOOL)validateLocation:(id*)value_ error:(NSError**)error_;




+ (NSArray*)fetchTransactionsWaitingForLocationFetchRequest:(NSManagedObjectContext*)moc_ dateLimit:(NSDate*)dateLimit_ ;
+ (NSArray*)fetchTransactionsWaitingForLocationFetchRequest:(NSManagedObjectContext*)moc_ dateLimit:(NSDate*)dateLimit_ error:(NSError**)error_;




@end

@interface _Transaction (CoreDataGeneratedAccessors)

@end

@interface _Transaction (CoreDataGeneratedPrimitiveAccessors)


- (NSDecimalNumber *)primitiveAmount;
- (void)setPrimitiveAmount:(NSDecimalNumber *)value;




- (NSNumber *)primitiveAttachLocation;
- (void)setPrimitiveAttachLocation:(NSNumber *)value;

- (BOOL)primitiveAttachLocationValue;
- (void)setPrimitiveAttachLocationValue:(BOOL)value_;




- (NSNumber *)primitiveCategoryID;
- (void)setPrimitiveCategoryID:(NSNumber *)value;

- (int16_t)primitiveCategoryIDValue;
- (void)setPrimitiveCategoryIDValue:(int16_t)value_;




- (NSDate *)primitiveCreatedTimestamp;
- (void)setPrimitiveCreatedTimestamp:(NSDate *)value;




- (NSDate *)primitiveModifiedTimestamp;
- (void)setPrimitiveModifiedTimestamp:(NSDate *)value;




- (NSString *)primitiveNote;
- (void)setPrimitiveNote:(NSString *)value;




- (NSNumber *)primitiveSettled;
- (void)setPrimitiveSettled:(NSNumber *)value;

- (BOOL)primitiveSettledValue;
- (void)setPrimitiveSettledValue:(BOOL)value_;





- (Friend*)primitiveFriend;
- (void)setPrimitiveFriend:(Friend*)value;



- (Location*)primitiveLocation;
- (void)setPrimitiveLocation:(Location*)value;


@end
