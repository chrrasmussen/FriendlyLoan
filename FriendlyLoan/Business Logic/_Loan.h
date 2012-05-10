// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Loan.h instead.

#import <CoreData/CoreData.h>


extern const struct LoanAttributes {
	__unsafe_unretained NSString *amount;
	__unsafe_unretained NSString *attachLocation;
	__unsafe_unretained NSString *categoryID;
	__unsafe_unretained NSString *createdAt;
	__unsafe_unretained NSString *friendID;
	__unsafe_unretained NSString *locationLatitude;
	__unsafe_unretained NSString *locationLongitude;
	__unsafe_unretained NSString *note;
	__unsafe_unretained NSString *requestAccepted;
	__unsafe_unretained NSString *requestID;
	__unsafe_unretained NSString *settled;
	__unsafe_unretained NSString *updatedAt;
} LoanAttributes;

extern const struct LoanRelationships {
} LoanRelationships;

extern const struct LoanFetchedProperties {
} LoanFetchedProperties;















@interface LoanID : NSManagedObjectID {}
@end

@interface _Loan : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (LoanID*)objectID;




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




@property (nonatomic, strong) NSDate *createdAt;


//- (BOOL)validateCreatedAt:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSNumber *friendID;


@property int32_t friendIDValue;
- (int32_t)friendIDValue;
- (void)setFriendIDValue:(int32_t)value_;

//- (BOOL)validateFriendID:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSNumber *locationLatitude;


@property double locationLatitudeValue;
- (double)locationLatitudeValue;
- (void)setLocationLatitudeValue:(double)value_;

//- (BOOL)validateLocationLatitude:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSNumber *locationLongitude;


@property double locationLongitudeValue;
- (double)locationLongitudeValue;
- (void)setLocationLongitudeValue:(double)value_;

//- (BOOL)validateLocationLongitude:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSString *note;


//- (BOOL)validateNote:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSNumber *requestAccepted;


@property BOOL requestAcceptedValue;
- (BOOL)requestAcceptedValue;
- (void)setRequestAcceptedValue:(BOOL)value_;

//- (BOOL)validateRequestAccepted:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSString *requestID;


//- (BOOL)validateRequestID:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSNumber *settled;


@property BOOL settledValue;
- (BOOL)settledValue;
- (void)setSettledValue:(BOOL)value_;

//- (BOOL)validateSettled:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSDate *updatedAt;


//- (BOOL)validateUpdatedAt:(id*)value_ error:(NSError**)error_;





+ (NSArray*)fetchLoansWaitingForLocationFetchRequest:(NSManagedObjectContext*)moc_ dateLimit:(NSDate*)dateLimit_ ;
+ (NSArray*)fetchLoansWaitingForLocationFetchRequest:(NSManagedObjectContext*)moc_ dateLimit:(NSDate*)dateLimit_ error:(NSError**)error_;



+ (NSArray*)fetchNumberOfLoanRequestsFetchRequest:(NSManagedObjectContext*)moc_ ;
+ (NSArray*)fetchNumberOfLoanRequestsFetchRequest:(NSManagedObjectContext*)moc_ error:(NSError**)error_;




@end

@interface _Loan (CoreDataGeneratedAccessors)

@end

@interface _Loan (CoreDataGeneratedPrimitiveAccessors)


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




- (NSDate *)primitiveCreatedAt;
- (void)setPrimitiveCreatedAt:(NSDate *)value;




- (NSNumber *)primitiveFriendID;
- (void)setPrimitiveFriendID:(NSNumber *)value;

- (int32_t)primitiveFriendIDValue;
- (void)setPrimitiveFriendIDValue:(int32_t)value_;




- (NSNumber *)primitiveLocationLatitude;
- (void)setPrimitiveLocationLatitude:(NSNumber *)value;

- (double)primitiveLocationLatitudeValue;
- (void)setPrimitiveLocationLatitudeValue:(double)value_;




- (NSNumber *)primitiveLocationLongitude;
- (void)setPrimitiveLocationLongitude:(NSNumber *)value;

- (double)primitiveLocationLongitudeValue;
- (void)setPrimitiveLocationLongitudeValue:(double)value_;




- (NSString *)primitiveNote;
- (void)setPrimitiveNote:(NSString *)value;




- (NSNumber *)primitiveRequestAccepted;
- (void)setPrimitiveRequestAccepted:(NSNumber *)value;

- (BOOL)primitiveRequestAcceptedValue;
- (void)setPrimitiveRequestAcceptedValue:(BOOL)value_;




- (NSString *)primitiveRequestID;
- (void)setPrimitiveRequestID:(NSString *)value;




- (NSNumber *)primitiveSettled;
- (void)setPrimitiveSettled:(NSNumber *)value;

- (BOOL)primitiveSettledValue;
- (void)setPrimitiveSettledValue:(BOOL)value_;




- (NSDate *)primitiveUpdatedAt;
- (void)setPrimitiveUpdatedAt:(NSDate *)value;




@end
