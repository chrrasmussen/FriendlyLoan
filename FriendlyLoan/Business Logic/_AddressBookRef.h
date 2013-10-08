// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to AddressBookRef.h instead.

#import <CoreData/CoreData.h>


extern const struct AddressBookRefAttributes {
	__unsafe_unretained NSString *deviceUUID;
	__unsafe_unretained NSString *recordID;
} AddressBookRefAttributes;

extern const struct AddressBookRefRelationships {
	__unsafe_unretained NSString *person;
} AddressBookRefRelationships;

extern const struct AddressBookRefFetchedProperties {
} AddressBookRefFetchedProperties;

@class Person;




@interface AddressBookRefID : NSManagedObjectID {}
@end

@interface _AddressBookRef : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (AddressBookRefID*)objectID;




@property (nonatomic, strong) NSString *deviceUUID;


//- (BOOL)validateDeviceUUID:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSNumber *recordID;


@property int16_t recordIDValue;
- (int16_t)recordIDValue;
- (void)setRecordIDValue:(int16_t)value_;

//- (BOOL)validateRecordID:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) Person* person;

//- (BOOL)validatePerson:(id*)value_ error:(NSError**)error_;





@end

@interface _AddressBookRef (CoreDataGeneratedAccessors)

@end

@interface _AddressBookRef (CoreDataGeneratedPrimitiveAccessors)


- (NSString *)primitiveDeviceUUID;
- (void)setPrimitiveDeviceUUID:(NSString *)value;




- (NSNumber *)primitiveRecordID;
- (void)setPrimitiveRecordID:(NSNumber *)value;

- (int16_t)primitiveRecordIDValue;
- (void)setPrimitiveRecordIDValue:(int16_t)value_;





- (Person*)primitivePerson;
- (void)setPrimitivePerson:(Person*)value;


@end
