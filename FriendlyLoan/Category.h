//
//  Categories.h
//  FriendlyLoan
//
//  Created by Christian Rasmussen on 26.09.11.
//  Copyright (c) 2011 Rasmussen I/O. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Category : NSObject

+ (NSUInteger)numberOfCategories;
+ (Category *)unknownCategory;
+ (Category *)categoryForIndex:(NSUInteger)index;
+ (Category *)categoryForCategoryID:(NSNumber *)categoryID;

- (NSNumber *)categoryID;
- (NSString *)categoryName;
- (NSString *)imageName;
- (NSString *)highlightedImageName;

@end
