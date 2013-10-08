// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Loan.h instead.

#import <CoreData/CoreData.h>


extern const struct LoanAttributes {
	__unsafe_unretained NSString *addLocation;
	__unsafe_unretained NSString *amount;
	__unsafe_unretained NSString *categoryUUID;
	__unsafe_unretained NSString *createdAt;
	__unsafe_unretained NSString *note;
	__unsafe_unretained NSString *settled;
	__unsafe_unretained NSString *updatedAt;
} LoanAttributes;

extern const struct LoanRelationships {
	__unsafe_unretained NSString *location;
	__unsafe_unretained NSString *person;
} LoanRelationships;

extern const struct LoanFetchedProperties {
} LoanFetchedProperties;

@class Location;
@class Person;









@interface LoanID : NSManagedObjectID {}
@end

@interface _Loan : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (LoanID*)objectID;




@property (nonatomic, strong) NSNumber *addLocation;


@property BOOL addLocationValue;
- (BOOL)addLocationValue;
- (void)setAddLocationValue:(BOOL)value_;

//- (BOOL)validateAddLocation:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSDecimalNumber *amount;


//- (BOOL)validateAmount:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSString *categoryUUID;


//- (BOOL)validateCategoryUUID:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSDate *createdAt;


//- (BOOL)validateCreatedAt:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSString *note;


//- (BOOL)validateNote:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSNumber *settled;


@property BOOL settledValue;
- (BOOL)settledValue;
- (void)setSettledValue:(BOOL)value_;

//- (BOOL)validateSettled:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSDate *updatedAt;


//- (BOOL)validateUpdatedAt:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) Location* location;

//- (BOOL)validateLocation:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) Person* person;

//- (BOOL)validatePerson:(id*)value_ error:(NSError**)error_;




+ (NSArray*)fetchLoansWaitingForLocation:(NSManagedObjectContext*)moc_ dateLimit:(NSDate*)dateLimit_ ;
+ (NSArray*)fetchLoansWaitingForLocation:(NSManagedObjectContext*)moc_ dateLimit:(NSDate*)dateLimit_ error:(NSError**)error_;



+ (NSArray*)fetchNumberOfLoanRequests:(NSManagedObjectContext*)moc_ ;
+ (NSArray*)fetchNumberOfLoanRequests:(NSManagedObjectContext*)moc_ error:(NSError**)error_;



+ (NSArray*)fetchNumberOfUnseenLoanRequests:(NSManagedObjectContext*)moc_ ;
+ (NSArray*)fetchNumberOfUnseenLoanRequests:(NSManagedObjectContext*)moc_ error:(NSError**)error_;




@end

@interface _Loan (CoreDataGeneratedAccessors)

@end

@interface _Loan (CoreDataGeneratedPrimitiveAccessors)


- (NSNumber *)primitiveAddLocation;
- (void)setPrimitiveAddLocation:(NSNumber *)value;

- (BOOL)primitiveAddLocationValue;
- (void)setPrimitiveAddLocationValue:(BOOL)value_;




- (NSDecimalNumber *)primitiveAmount;
- (void)setPrimitiveAmount:(NSDecimalNumber *)value;




- (NSString *)primitiveCategoryUUID;
- (void)setPrimitiveCategoryUUID:(NSString *)value;




- (NSDate *)primitiveCreatedAt;
- (void)setPrimitiveCreatedAt:(NSDate *)value;




- (NSString *)primitiveNote;
- (void)setPrimitiveNote:(NSString *)value;




- (NSNumber *)primitiveSettled;
- (void)setPrimitiveSettled:(NSNumber *)value;

- (BOOL)primitiveSettledValue;
- (void)setPrimitiveSettledValue:(BOOL)value_;




- (NSDate *)primitiveUpdatedAt;
- (void)setPrimitiveUpdatedAt:(NSDate *)value;





- (Location*)primitiveLocation;
- (void)setPrimitiveLocation:(Location*)value;



- (Person*)primitivePerson;
- (void)setPrimitivePerson:(Person*)value;


@end
