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
NSString *propertyNameForSetter(NSString *method);
BOOL resolvePropertyForClass(NSString *targetPropertyName, Class class);
id accessorGetter(id self, SEL _cmd);
void accessorSetter(id self, SEL _cmd, id value);


@implementation PFDynamicObject

#pragma mark - Metadata for object creation

+ (NSString *)databaseClassName
{
    return nil;
}

//+ (NSDictionary *)databaseFieldToPropertyMappings
//{
//    return [NSDictionary dictionary];
//}


#pragma mark - Convenience methods for creating an object

+ (id)object
{
    return [[[self class] alloc] init];
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


#pragma mark - Resolve property methods

+ (BOOL)resolveInstanceMethod:(SEL)selector
{
    // Use the existing implementation if it exists
    if ([super resolveInstanceMethod:selector] == YES) {
        return YES;
    }
    
    // Get target property name
    NSString *method = NSStringFromSelector(selector);
    BOOL isSetter = [method hasPrefix:@"set"] && [method hasSuffix:@":"];
    NSString *targetPropertyName = method;
    if (isSetter) {
        targetPropertyName = propertyNameForSetter(method);
    }
    
    // Search for property in class and its superclasses
    Class class = [self class];
    while (class != [PFDynamicObject class]) {
        if (resolvePropertyForClass(targetPropertyName, class)) {
            // Add custom implementation
            if (isSetter) {
                class_addMethod(class, selector, (IMP)accessorSetter, "v@:@");
            }
            else {
                class_addMethod(class, selector, (IMP)accessorGetter, "@@:");
            }
            
            return YES;
        }
        
        class = class_getSuperclass(class);
    }
    
    return NO;
}

@end


// TODO: Check if class responds to selector instead - May be problematic
NSString *propertyNameForSetter(NSString *method)
{
    // Get name from setter method
    NSString *name = [method substringWithRange:NSMakeRange(3, method.length - 4)];
    
    // Keep name if length is 2 or below
    if (name.length <= 1) {
        return name;
    }
    
    // Get letter casing for second and third letter
    NSCharacterSet *uppercaseLetterCharacterSet = [NSCharacterSet uppercaseLetterCharacterSet];
    BOOL isSecondLetterUppercase = [uppercaseLetterCharacterSet characterIsMember:[name characterAtIndex:1]];
    BOOL isThirdLetterUppercase = [uppercaseLetterCharacterSet characterIsMember:[name characterAtIndex:2]];
    
    // Keep the first letter casing if the following two characters are uppercase
    NSString *firstLetter = [name substringToIndex:1];
    BOOL shouldKeepFirstLetterCasing = (isSecondLetterUppercase && isThirdLetterUppercase);
    if (shouldKeepFirstLetterCasing == NO) {
        firstLetter = [firstLetter lowercaseString];
    }
    
    // Concatenate first letter with the rest of the string
    NSString *restOfString = [name substringFromIndex:1];
    NSString *concatenatedString = [firstLetter stringByAppendingString:restOfString];
    return concatenatedString;
}

BOOL resolvePropertyForClass(NSString *targetPropertyName, Class class) {
    unsigned int outCount, i;
    objc_property_t *properties = class_copyPropertyList(class, &outCount);
    for (i = 0; i < outCount; i++) {
        // Get property name
        objc_property_t property = properties[i];
        NSString *propertyName = [NSString stringWithUTF8String:property_getName(property)];
        
        // Return if property is found
        if ([targetPropertyName isEqualToString:propertyName]) {
            return YES;
        }
    }
    
    return NO;
}

id accessorGetter(id self, SEL _cmd)
{
    NSString *key = NSStringFromSelector(_cmd);
    
    return [self objectForKey:key];
}

void accessorSetter(id self, SEL _cmd, id value)
{
    NSString *key = propertyNameForSetter(NSStringFromSelector(_cmd));
    
    [self setObject:value forKey:key];
}