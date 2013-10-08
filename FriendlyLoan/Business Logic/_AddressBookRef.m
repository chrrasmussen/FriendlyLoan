// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to AddressBookRef.m instead.

#import "_AddressBookRef.h"

const struct AddressBookRefAttributes AddressBookRefAttributes = {
	.deviceUUID = @"deviceUUID",
	.recordID = @"recordID",
};

const struct AddressBookRefRelationships AddressBookRefRelationships = {
	.person = @"person",
};

const struct AddressBookRefFetchedProperties AddressBookRefFetchedProperties = {
};

@implementation AddressBookRefID
@end

@implementation _AddressBookRef

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"AddressBookRef" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"AddressBookRef";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"AddressBookRef" inManagedObjectContext:moc_];
}

- (AddressBookRefID*)objectID {
	return (AddressBookRefID*)[super objectID];
}

+ (NSSet *)keyPathsForValuesAffectingValueForKey:(NSString *)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	
	if ([key isEqualToString:@"recordIDValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"recordID"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
	}

	return keyPaths;
}




@dynamic deviceUUID;






@dynamic recordID;



- (int16_t)recordIDValue {
	NSNumber *result = [self recordID];
	return [result shortValue];
}

- (void)setRecordIDValue:(int16_t)value_ {
	[self setRecordID:[NSNumber numberWithShort:value_]];
}

- (int16_t)primitiveRecordIDValue {
	NSNumber *result = [self primitiveRecordID];
	return [result shortValue];
}

- (void)setPrimitiveRecordIDValue:(int16_t)value_ {
	[self setPrimitiveRecordID:[NSNumber numberWithShort:value_]];
}





@dynamic person;

	






@end
