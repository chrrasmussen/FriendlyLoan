//
//  Categories.h
//  FriendlyLoan
//
//  Created by Christian Rasmussen on 26.09.11.
//  Copyright (c) 2011 Rasmussen I/O. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Categories : NSObject

+ (NSArray *)categoryIDs;
+ (NSNumber *)categoryIDForIndex:(NSUInteger)index;

+ (NSString *)categoryNameForID:(NSNumber *)categoryID;
+ (NSString *)imageNameForID:(NSNumber *)categoryID;
+ (NSString *)highlightedImageNameForID:(NSNumber *)categoryID;

@end
