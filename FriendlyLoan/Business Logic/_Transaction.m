// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Transaction.m instead.

#import "_Transaction.h"

const struct TransactionAttributes TransactionAttributes = {
	.accepted = @"accepted",
	.amount = @"amount",
	.attachLocation = @"attachLocation",
	.categoryID = @"categoryID",
	.createdAt = @"createdAt",
	.note = @"note",
	.settled = @"settled",
	.updatedAt = @"updatedAt",
};

const struct TransactionRelationships TransactionRelationships = {
	.friend = @"friend",
	.location = @"location",
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
	
	if ([key isEqualToString:@"acceptedValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"accepted"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
	}
	if ([key isEqualToString:@"attachLocationValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"attachLocation"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
	}
	if ([key isEqualToString:@"categoryIDValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"categoryID"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
	}
	if ([key isEqualToString:@"settledValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"settled"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
	}

	return keyPaths;
}




@dynamic accepted;



- (BOOL)acceptedValue {
	NSNumber *result = [self accepted];
	return [result boolValue];
}

- (void)setAcceptedValue:(BOOL)value_ {
	[self setAccepted:[NSNumber numberWithBool:value_]];
}

- (BOOL)primitiveAcceptedValue {
	NSNumber *result = [self primitiveAccepted];
	return [result boolValue];
}

- (void)setPrimitiveAcceptedValue:(BOOL)value_ {
	[self setPrimitiveAccepted:[NSNumber numberWithBool:value_]];
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






@dynamic note;






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






@dynamic friend;

	

@dynamic location;

	






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



@end
