//
//  CategoryList.h
//  FriendlyLoan
//
//  Created by Christian Rasmussen on 07.05.12.
//  Copyright (c) 2012 Rasmussen I/O. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CategoryList : NSObject

+ (NSArray *)categoryIDs;
+ (NSString *)nameForCategoryID:(NSNumber *)categoryID;
+ (UIImage *)imageForCategoryID:(NSNumber *)categoryID;
+ (UIImage *)highlightedImageForCategoryID:(NSNumber *)categoryID;

@end
