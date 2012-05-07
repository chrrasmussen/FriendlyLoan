// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Transaction.m instead.

#import "_Transaction.h"

const struct TransactionAttributes TransactionAttributes = {
	.amount = @"amount",
	.attachLocation = @"attachLocation",
	.categoryID = @"categoryID",
	.createdAt = @"createdAt",
	.friendID = @"friendID",
	.locationLatitude = @"locationLatitude",
	.locationLongitude = @"locationLongitude",
	.note = @"note",
	.requestAccepted = @"requestAccepted",
	.requestID = @"requestID",
	.settled = @"settled",
	.updatedAt = @"updatedAt",
};

const struct TransactionRelationships TransactionRelationships = {
};

const struct TransactionFetchedProperties TransactionFetchedProperties = {
};

@implementation TransactionID
@end

@implementation _Transaction

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"Transaction" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"Transaction";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"Transaction" inManagedObjectContext:moc_];
}

- (TransactionID*)objectID {
	return (TransactionID*)[super objectID];
}

+ (NSSet *)keyPathsForValuesAffectingValueForKey:(NSString *)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	
	if ([key isEqualToString:@"attachLocationValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"attachLocation"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
	}
	if ([key isEqualToString:@"categoryIDValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"categoryID"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
	}
	if ([key isEqualToString:@"friendIDValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"friendID"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
	}
	if ([key isEqualToString:@"locationLatitudeValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"locationLatitude"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
	}
	if ([key isEqualToString:@"locationLongitudeValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"locationLongitude"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
	}
	if ([key isEqualToString:@"requestAcceptedValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"requestAccepted"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
	}
	if ([key isEqualToString:@"settledValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"settled"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
	}

	return keyPaths;
}




@dynamic amount;






@dynamic attachLocation;



- (BOOL)attachLocationValue {
	NSNumber *result = [self attachLocation];
	return [result boolValue];
}

- (void)setAttachLocationValue:(BOOL)value_ {
	[self setAttachLocation:[NSNumber numberWithBool:value_]];
}

- (BOOL)primitiveAttachLocationValue {
	NSNumber *result = [self primitiveAttachLocation];
	return [result boolValue];
}

- (void)setPrimitiveAttachLocationValue:(BOOL)value_ {
	[self setPrimitiveAttachLocation:[NSNumber numberWithBool:value_]];
}





@dynamic categoryID;



- (int16_t)categoryIDValue {
	NSNumber *result = [self categoryID];
	return [result shortValue];
}

- (void)setCategoryIDValue:(int16_t)value_ {
	[self setCategoryID:[NSNumber numberWithShort:value_]];
}

- (int16_t)primitiveCategoryIDValue {
	NSNumber *result = [self primitiveCategoryID];
	return [result shortValue];
}

- (void)setPrimitiveCategoryIDValue:(int16_t)value_ {
	[self setPrimitiveCategoryID:[NSNumber numberWithShort:value_]];
}





@dynamic createdAt;






@dynamic friendID;



- (int32_t)friendIDValue {
	NSNumber *result = [self friendID];
	return [result intValue];
}

- (void)setFriendIDValue:(int32_t)value_ {
	[self setFriendID:[NSNumber numberWithInt:value_]];
}

- (int32_t)primitiveFriendIDValue {
	NSNumber *result = [self primitiveFriendID];
	return [result intValue];
}

- (void)setPrimitiveFriendIDValue:(int32_t)value_ {
	[self setPrimitiveFriendID:[NSNumber numberWithInt:value_]];
}





@dynamic locationLatitude;



- (double)locationLatitudeValue {
	NSNumber *result = [self locationLatitude];
	return [result doubleValue];
}

- (void)setLocationLatitudeValue:(double)value_ {
	[self setLocationLatitude:[NSNumber numberWithDouble:value_]];
}

- (double)primitiveLocationLatitudeValue {
	NSNumber *result = [self primitiveLocationLatitude];
	return [result doubleValue];
}

- (void)setPrimitiveLocationLatitudeValue:(double)value_ {
	[self setPrimitiveLocationLatitude:[NSNumber numberWithDouble:value_]];
}





@dynamic locationLongitude;



- (double)locationLongitudeValue {
	NSNumber *result = [self locationLongitude];
	return [result doubleValue];
}

- (void)setLocationLongitudeValue:(double)value_ {
	[self setLocationLongitude:[NSNumber numberWithDouble:value_]];
}

- (double)primitiveLocationLongitudeValue {
	NSNumber *result = [self primitiveLocationLongitude];
	return [result doubleValue];
}

- (void)setPrimitiveLocationLongitudeValue:(double)value_ {
	[self setPrimitiveLocationLongitude:[NSNumber numberWithDouble:value_]];
}





@dynamic note;






@dynamic requestAccepted;



- (BOOL)requestAcceptedValue {
	NSNumber *result = [self requestAccepted];
	return [result boolValue];
}

- (void)setRequestAcceptedValue:(BOOL)value_ {
	[self setRequestAccepted:[NSNumber numberWithBool:value_]];
}

- (BOOL)primitiveRequestAcceptedValue {
	NSNumber *result = [self primitiveRequestAccepted];
	return [result boolValue];
}

- (void)setPrimitiveRequestAcceptedValue:(BOOL)value_ {
	[self setPrimitiveRequestAccepted:[NSNumber numberWithBool:value_]];
}





@dynamic requestID;






@dynamic settled;



- (BOOL)settledValue {
	NSNumber *result = [self settled];
	return [result boolValue];
}

- (void)setSettledValue:(BOOL)value_ {
	[self setSettled:[NSNumber numberWithBool:value_]];
}

- (BOOL)primitiveSettledValue {
	NSNumber *result = [self primitiveSettled];
	return [result boolValue];
}

- (void)setPrimitiveSettledValue:(BOOL)value_ {
	[self setPrimitiveSettled:[NSNumber numberWithBool:value_]];
}





@dynamic updatedAt;











+ (NSArray*)fetchTransactionsWaitingForLocationFetchRequest:(NSManagedObjectContext*)moc_ dateLimit:(NSDate*)dateLimit_ {
	NSError *error = nil;
	NSArray *result = [self fetchTransactionsWaitingForLocationFetchRequest:moc_ dateLimit:dateLimit_ error:&error];
	if (error) {
#if TARGET_OS_IPHONE
		NSLog(@"error: %@", error);
#else
		[NSApp presentError:error];
#endif
	}
	return result;
}
+ (NSArray*)fetchTransactionsWaitingForLocationFetchRequest:(NSManagedObjectContext*)moc_ dateLimit:(NSDate*)dateLimit_ error:(NSError**)error_ {
	NSParameterAssert(moc_);
	NSError *error = nil;
	
	NSManagedObjectModel *model = [[moc_ persistentStoreCoordinator] managedObjectModel];
	
	NSDictionary *substitutionVariables = [NSDictionary dictionaryWithObjectsAndKeys:
														
														dateLimit_, @"dateLimit",
														
														nil];
										
	NSFetchRequest *fetchRequest = [model fetchRequestFromTemplateWithName:@"TransactionsWaitingForLocationFetchRequest"
													 substitutionVariables:substitutionVariables];
	NSAssert(fetchRequest, @"Can't find fetch request named \"TransactionsWaitingForLocationFetchRequest\".");
	
	NSArray *result = [moc_ executeFetchRequest:fetchRequest error:&error];
	if (error_) *error_ = error;
	return result;
}



+ (NSArray*)fetchNumberOfTransactionRequestsFetchRequest:(NSManagedObjectContext*)moc_ {
	NSError *error = nil;
	NSArray *result = [self fetchNumberOfTransactionRequestsFetchRequest:moc_ error:&error];
	if (error) {
#if TARGET_OS_IPHONE
		NSLog(@"error: %@", error);
#else
		[NSApp presentError:error];
#endif
	}
	return result;
}
+ (NSArray*)fetchNumberOfTransactionRequestsFetchRequest:(NSManagedObjectContext*)moc_ error:(NSError**)error_ {
	NSParameterAssert(moc_);
	NSError *error = nil;
	
	NSManagedObjectModel *model = [[moc_ persistentStoreCoordinator] managedObjectModel];
	
	NSDictionary *substitutionVariables = [NSDictionary dictionary];
										
	NSFetchRequest *fetchRequest = [model fetchRequestFromTemplateWithName:@"NumberOfTransactionRequestsFetchRequest"
													 substitutionVariables:substitutionVariables];
	NSAssert(fetchRequest, @"Can't find fetch request named \"NumberOfTransactionRequestsFetchRequest\".");
	
	NSArray *result = [moc_ executeFetchRequest:fetchRequest error:&error];
	if (error_) *error_ = error;
	return result;
}



@end
