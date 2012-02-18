// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Friend.m instead.

#import "_Friend.h"

const struct FriendAttributes FriendAttributes = {
	.friendID = @"friendID",
};

const struct FriendRelationships FriendRelationships = {
	.transaction = @"transaction",
};

const struct FriendFetchedProperties FriendFetchedProperties = {
};

@implementation FriendID
@end

@implementation _Friend

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"Friend" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"Friend";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"Friend" inManagedObjectContext:moc_];
}

- (FriendID*)objectID {
	return (FriendID*)[super objectID];
}

+ (NSSet *)keyPathsForValuesAffectingValueForKey:(NSString *)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	
	if ([key isEqualToString:@"friendIDValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"friendID"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
	}

	return keyPaths;
}




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





@dynamic transaction;

	






@end
