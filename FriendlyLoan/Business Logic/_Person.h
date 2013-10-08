// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Person.h instead.

#import <CoreData/CoreData.h>


extern const struct PersonAttributes {
	__unsafe_unretained NSString *email;
	__unsafe_unretained NSString *firstName;
	__unsafe_unretained NSString *lastName;
	__unsafe_unretained NSString *personUUID;
	__unsafe_unretained NSString *phone;
} PersonAttributes;

extern const struct PersonRelationships {
	__unsafe_unretained NSString *addressBookRef;
	__unsafe_unretained NSString *loan;
} PersonRelationships;

extern const struct PersonFetchedProperties {
} PersonFetchedProperties;

@class AddressBookRef;
@class Loan;







@interface PersonID : NSManagedObjectID {}
@end

@interface _Person : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (PersonID*)objectID;




@property (nonatomic, strong) NSString *email;


//- (BOOL)validateEmail:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSString *firstName;


//- (BOOL)validateFirstName:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSString *lastName;


//- (BOOL)validateLastName:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSString *personUUID;


//- (BOOL)validatePersonUUID:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSString *phone;


//- (BOOL)validatePhone:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSSet* addressBookRef;

- (NSMutableSet*)addressBookRefSet;




@property (nonatomic, strong) NSSet* loan;

- (NSMutableSet*)loanSet;





@end

@interface _Person (CoreDataGeneratedAccessors)

- (void)addAddressBookRef:(NSSet*)value_;
- (void)removeAddressBookRef:(NSSet*)value_;
- (void)addAddressBookRefObject:(AddressBookRef*)value_;
- (void)removeAddressBookRefObject:(AddressBookRef*)value_;

- (void)addLoan:(NSSet*)value_;
- (void)removeLoan:(NSSet*)value_;
- (void)addLoanObject:(Loan*)value_;
- (void)removeLoanObject:(Loan*)value_;

@end

@interface _Person (CoreDataGeneratedPrimitiveAccessors)


- (NSString *)primitiveEmail;
- (void)setPrimitiveEmail:(NSString *)value;




- (NSString *)primitiveFirstName;
- (void)setPrimitiveFirstName:(NSString *)value;




- (NSString *)primitiveLastName;
- (void)setPrimitiveLastName:(NSString *)value;




- (NSString *)primitivePersonUUID;
- (void)setPrimitivePersonUUID:(NSString *)value;




- (NSString *)primitivePhone;
- (void)setPrimitivePhone:(NSString *)value;





- (NSMutableSet*)primitiveAddressBookRef;
- (void)setPrimitiveAddressBookRef:(NSMutableSet*)value;



- (NSMutableSet*)primitiveLoan;
- (void)setPrimitiveLoan:(NSMutableSet*)value;


@end
