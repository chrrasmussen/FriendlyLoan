//
//  PFDynamicObject.h
//  FriendlyLoan
//
//  Created by Christian Rasmussen on 07.05.12.
//  Copyright (c) 2012 Rasmussen I/O. All rights reserved.
//

#import <Parse/Parse.h>


@interface PFDynamicObject : PFObject

// Metadata for object creation
+ (NSString *)databaseClassName;

// Convenience methods for creating an object
+ (id)object;
+ (id)objectWithoutDataWithObjectId:(NSString *)objectId;
- (id)init;

+ (id)objectWithDataObject:(PFObject *)object;
+ (void)addMethodsToClass:(Class)targetClass forPropertiesInClass:(Class)sourceClass;

// TODO: Copy values from an existing PFObject? May I use objectWithoutDataWithObjectId?
// TODO: How could I easily copy value from an PFDynamicObject to somewhere else? Like Loan
//       (Create som kind of proxy? It should work for other types too. Can I take any objectId?)
// TODO: I don't want mapping to database, but maybe between other classes? Use categories and manual mapping (like Loan+PFObject)?
// TODO: Create a method in Loan: shareInBackgroundWithBlock:
// TODO: Create User-class, which is an augmented PFUser-class?
// TODO: Does observers work on PFObject? Even with -refresh? Create bindings between Loan and LoanRequest?

@end
