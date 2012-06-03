//
//  PFDynamicObject.m
//  FriendlyLoan
//
//  Created by Christian Rasmussen on 07.05.12.
//  Copyright (c) 2012 Rasmussen I/O. All rights reserved.
//

#import "PFDynamicObject.h"
#import <objc/runtime.h>


// Prototypes
void addMethodsToClassForPropertiesInClass(Class targetClass, Class sourceClass);
void addMethodsToClassForProperty(Class targetClass, objc_property_t property);
void addGetterMethodToClass(Class targetClass, NSString *method, NSString *propertyName);
void addSetterMethodToClass(Class targetClass, NSString *method, NSString *propertyName);


@implementation PFDynamicObject

#pragma mark - Metadata for object creation

+ (NSString *)databaseClassName
{
    return nil;
}


#pragma mark - Convenience methods for creating an object

+ (id)object
{
    return [[self alloc] init];
}

+ (id)objectWithoutDataWithObjectId:(NSString *)objectId
{
    PFObject *object = [self object];
    object.objectId = objectId;
    
    return object;
}


- (id)init
{
    return [super initWithClassName:[[self class] databaseClassName]];
}


#pragma mark - Dynamically add methods for properties

+ (void)initialize
{
//    NSLog(@"Initalizing class:%@", NSStringFromClass(self));
    [self addMethodsToClass:self forPropertiesInClass:self];
}

// TODO: Potential problem: All methods are added to the PFObject class. What if a subclass has a specific implementation? It should actually not be a problem.
// TODO: I addMethod-funksjonen, bør jeg sjekke om klassen allerede har en implementasjon?
+ (id)objectWithDataObject:(PFObject *)object
{
    [self addMethodsToClass:[object class] forPropertiesInClass:self];
    
    return object;
}


+ (void)addMethodsToClass:(Class)targetClass forPropertiesInClass:(Class)sourceClass
{
    addMethodsToClassForPropertiesInClass(targetClass, sourceClass);
}

@end


void addMethodsToClassForPropertiesInClass(Class targetClass, Class sourceClass)
{
    unsigned int outCount, i;
    objc_property_t *properties = class_copyPropertyList(sourceClass, &outCount);
    for (i = 0; i < outCount; i++) {
        objc_property_t property = properties[i];
        addMethodsToClassForProperty(targetClass, property);
    }
    free(properties);
}

void addMethodsToClassForProperty(Class targetClass, objc_property_t property)
{
    // Parse property attributes
    NSString *propertyName = [NSString stringWithUTF8String:property_getName(property)];
    NSString *propertyAttributes = [NSString stringWithUTF8String:property_getAttributes(property)];
    
    BOOL isObjectType = NO;
    BOOL isDyamic = NO;
    BOOL isReadOnly = NO;
    BOOL isNonatomic = NO;
    NSString *getter;
    NSString *setter;
    
    NSArray *attributes = [propertyAttributes componentsSeparatedByString:@","];
    for (NSString *attribute in attributes) {
        if ([attribute hasPrefix:@"T"]) { // Type
            isObjectType = [attribute hasPrefix:@"T@"];
        }
        else if ([attribute hasPrefix:@"R"]) { // Read-only
            isReadOnly = YES;
        }
        else if ([attribute hasPrefix:@"D"]) { // Dynamic
            isDyamic = YES;
        }
        else if ([attribute hasPrefix:@"N"]) { // Nonatomic
            isNonatomic = YES;
        }
        else if ([attribute hasPrefix:@"G"]) { // Getter
            getter = [attribute substringFromIndex:1];
        }
        else if ([attribute hasPrefix:@"S"]) { // Setter
            setter = [attribute substringFromIndex:1];
        }
    }
    
    // Validate
    if (!(isObjectType == YES && isDyamic == YES)) {
        return;
    }
    
    // Add getter
    if (getter == nil) {
        getter = propertyName;
    }
    
    addGetterMethodToClass(targetClass, getter, propertyName);
    
    // Add setter
    if (isReadOnly == YES) {
        return;
    }
    
    if (setter == nil) {
        NSString *uppercaseFirstLetter = [[propertyName substringToIndex:1] uppercaseString];
        NSString *restOfString = [propertyName substringFromIndex:1];
        setter = [NSString stringWithFormat:@"set%@%@:", uppercaseFirstLetter, restOfString];
    }
    
    addSetterMethodToClass(targetClass, setter, propertyName);
}

void addGetterMethodToClass(Class targetClass, NSString *method, NSString *propertyName)
{
    id getter = (id)^(id s) {
//        NSLog(@"<%@> -%@ -- %@", NSStringFromClass([self class]), NSStringFromSelector(_cmd), propertyName);
        return [s objectForKey:propertyName];
    };
    IMP imp = imp_implementationWithBlock((__bridge void *)getter);
    class_addMethod(targetClass, NSSelectorFromString(method), imp, "@@:");
}

void addSetterMethodToClass(Class targetClass, NSString *method, NSString *propertyName)
{
    id setter = ^(id s, id value) {
//        NSLog(@"<%@> -%@ -- %@ = %@", NSStringFromClass([self class]), NSStringFromSelector(_cmd), propertyName, value);
        [s setObject:value forKey:propertyName];
    };
    IMP imp = imp_implementationWithBlock((__bridge void *)setter);
    class_addMethod(targetClass, NSSelectorFromString(method), imp, "v@:@");
}