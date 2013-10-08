// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Person.m instead.

#import "_Person.h"

const struct PersonAttributes PersonAttributes = {
	.email = @"email",
	.firstName = @"firstName",
	.lastName = @"lastName",
	.personUUID = @"personUUID",
	.phone = @"phone",
};

const struct PersonRelationships PersonRelationships = {
	.addressBookRef = @"addressBookRef",
	.loan = @"loan",
};

const struct PersonFetchedProperties PersonFetchedProperties = {
};

@implementation PersonID
@end

@implementation _Person

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"Person" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"Person";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"Person" inManagedObjectContext:moc_];
}

- (PersonID*)objectID {
	return (PersonID*)[super objectID];
}

+ (NSSet *)keyPathsForValuesAffectingValueForKey:(NSString *)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	

	return keyPaths;
}




@dynamic email;






@dynamic firstName;






@dynamic lastName;






@dynamic personUUID;






@dynamic phone;






@dynamic addressBookRef;

	
- (NSMutableSet*)addressBookRefSet {
	[self willAccessValueForKey:@"addressBookRef"];
  
	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"addressBookRef"];
  
	[self didAccessValueForKey:@"addressBookRef"];
	return result;
}
	

@dynamic loan;

	
- (NSMutableSet*)loanSet {
	[self willAccessValueForKey:@"loan"];
  
	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"loan"];
  
	[self didAccessValueForKey:@"loan"];
	return result;
}
	






@end
