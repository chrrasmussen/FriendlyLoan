//
//  Test.m
//  FriendlyLoan
//
//  Created by Christian Rasmussen on 08.05.12.
//  Copyright (c) 2012 Rasmussen I/O. All rights reserved.
//

#import "Test.h"


@implementation Test

@dynamic testMethod;

+ (NSString *)databaseClassName
{
    return @"Test";
}

//+ (NSDictionary *)databaseFieldToPropertyMappings
//{
//    return [NSDictionary dictionaryWithObjectsAndKeys:@"testMethod", @"note", nil];
//}

//- (void)setTestMethod:(NSString *)string
//{
//    NSLog(@"Test method:%@", string);
//}

@end
