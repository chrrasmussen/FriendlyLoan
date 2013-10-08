// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Location.h instead.

#import <CoreData/CoreData.h>


extern const struct LocationAttributes {
	__unsafe_unretained NSString *latitude;
	__unsafe_unretained NSString *longitude;
} LocationAttributes;

extern const struct LocationRelationships {
	__unsafe_unretained NSString *loan;
} LocationRelationships;

extern const struct LocationFetchedProperties {
} LocationFetchedProperties;

@class Loan;




@interface LocationID : NSManagedObjectID {}
@end

@interface _Location : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (LocationID*)objectID;




@property (nonatomic, strong) NSNumber *latitude;


@property double latitudeValue;
- (double)latitudeValue;
- (void)setLatitudeValue:(double)value_;

//- (BOOL)validateLatitude:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSNumber *longitude;


@property double longitudeValue;
- (double)longitudeValue;
- (void)setLongitudeValue:(double)value_;

//- (BOOL)validateLongitude:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) Loan* loan;

//- (BOOL)validateLoan:(id*)value_ error:(NSError**)error_;





@end

@interface _Location (CoreDataGeneratedAccessors)

@end

@interface _Location (CoreDataGeneratedPrimitiveAccessors)


- (NSNumber *)primitiveLatitude;
- (void)setPrimitiveLatitude:(NSNumber *)value;

- (double)primitiveLatitudeValue;
- (void)setPrimitiveLatitudeValue:(double)value_;




- (NSNumber *)primitiveLongitude;
- (void)setPrimitiveLongitude:(NSNumber *)value;

- (double)primitiveLongitudeValue;
- (void)setPrimitiveLongitudeValue:(double)value_;





- (Loan*)primitiveLoan;
- (void)setPrimitiveLoan:(Loan*)value;


@end
