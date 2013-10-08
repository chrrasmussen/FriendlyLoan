// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Loan.m instead.

#import "_Loan.h"

const struct LoanAttributes LoanAttributes = {
	.addLocation = @"addLocation",
	.amount = @"amount",
	.categoryUUID = @"categoryUUID",
	.createdAt = @"createdAt",
	.note = @"note",
	.settled = @"settled",
	.updatedAt = @"updatedAt",
};

const struct LoanRelationships LoanRelationships = {
	.location = @"location",
	.person = @"person",
};

const struct LoanFetchedProperties LoanFetchedProperties = {
};

@implementation LoanID
@end

@implementation _Loan

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"Loan" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"Loan";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"Loan" inManagedObjectContext:moc_];
}

- (LoanID*)objectID {
	return (LoanID*)[super objectID];
}

+ (NSSet *)keyPathsForValuesAffectingValueForKey:(NSString *)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	
	if ([key isEqualToString:@"addLocationValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"addLocation"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
	}
	if ([key isEqualToString:@"settledValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"settled"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
	}

	return keyPaths;
}




@dynamic addLocation;



- (BOOL)addLocationValue {
	NSNumber *result = [self addLocation];
	return [result boolValue];
}

- (void)setAddLocationValue:(BOOL)value_ {
	[self setAddLocation:[NSNumber numberWithBool:value_]];
}

- (BOOL)primitiveAddLocationValue {
	NSNumber *result = [self primitiveAddLocation];
	return [result boolValue];
}

- (void)setPrimitiveAddLocationValue:(BOOL)value_ {
	[self setPrimitiveAddLocation:[NSNumber numberWithBool:value_]];
}





@dynamic amount;






@dynamic categoryUUID;






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






@dynamic location;

	

@dynamic person;

	






+ (NSArray*)fetchLoansWaitingForLocation:(NSManagedObjectContext*)moc_ dateLimit:(NSDate*)dateLimit_ {
	NSError *error = nil;
	NSArray *result = [self fetchLoansWaitingForLocation:moc_ dateLimit:dateLimit_ error:&error];
	if (error) {
#if TARGET_OS_IPHONE
		NSLog(@"error: %@", error);
#else
		[NSApp presentError:error];
#endif
	}
	return result;
}
+ (NSArray*)fetchLoansWaitingForLocation:(NSManagedObjectContext*)moc_ dateLimit:(NSDate*)dateLimit_ error:(NSError**)error_ {
	NSParameterAssert(moc_);
	NSError *error = nil;
	
	NSManagedObjectModel *model = [[moc_ persistentStoreCoordinator] managedObjectModel];
	
	NSDictionary *substitutionVariables = [NSDictionary dictionaryWithObjectsAndKeys:
														
														dateLimit_, @"dateLimit",
														
														nil];
										
	NSFetchRequest *fetchRequest = [model fetchRequestFromTemplateWithName:@"LoansWaitingForLocation"
													 substitutionVariables:substitutionVariables];
	NSAssert(fetchRequest, @"Can't find fetch request named \"LoansWaitingForLocation\".");
	
	NSArray *result = [moc_ executeFetchRequest:fetchRequest error:&error];
	if (error_) *error_ = error;
	return result;
}



+ (NSArray*)fetchNumberOfLoanRequests:(NSManagedObjectContext*)moc_ {
	NSError *error = nil;
	NSArray *result = [self fetchNumberOfLoanRequests:moc_ error:&error];
	if (error) {
#if TARGET_OS_IPHONE
		NSLog(@"error: %@", error);
#else
		[NSApp presentError:error];
#endif
	}
	return result;
}
+ (NSArray*)fetchNumberOfLoanRequests:(NSManagedObjectContext*)moc_ error:(NSError**)error_ {
	NSParameterAssert(moc_);
	NSError *error = nil;
	
	NSManagedObjectModel *model = [[moc_ persistentStoreCoordinator] managedObjectModel];
	
	NSDictionary *substitutionVariables = [NSDictionary dictionary];
										
	NSFetchRequest *fetchRequest = [model fetchRequestFromTemplateWithName:@"NumberOfLoanRequests"
													 substitutionVariables:substitutionVariables];
	NSAssert(fetchRequest, @"Can't find fetch request named \"NumberOfLoanRequests\".");
	
	NSArray *result = [moc_ executeFetchRequest:fetchRequest error:&error];
	if (error_) *error_ = error;
	return result;
}



+ (NSArray*)fetchNumberOfUnseenLoanRequests:(NSManagedObjectContext*)moc_ {
	NSError *error = nil;
	NSArray *result = [self fetchNumberOfUnseenLoanRequests:moc_ error:&error];
	if (error) {
#if TARGET_OS_IPHONE
		NSLog(@"error: %@", error);
#else
		[NSApp presentError:error];
#endif
	}
	return result;
}
+ (NSArray*)fetchNumberOfUnseenLoanRequests:(NSManagedObjectContext*)moc_ error:(NSError**)error_ {
	NSParameterAssert(moc_);
	NSError *error = nil;
	
	NSManagedObjectModel *model = [[moc_ persistentStoreCoordinator] managedObjectModel];
	
	NSDictionary *substitutionVariables = [NSDictionary dictionary];
										
	NSFetchRequest *fetchRequest = [model fetchRequestFromTemplateWithName:@"NumberOfUnseenLoanRequests"
													 substitutionVariables:substitutionVariables];
	NSAssert(fetchRequest, @"Can't find fetch request named \"NumberOfUnseenLoanRequests\".");
	
	NSArray *result = [moc_ executeFetchRequest:fetchRequest error:&error];
	if (error_) *error_ = error;
	return result;
}



@end
