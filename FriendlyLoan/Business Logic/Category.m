//
//  Category.m
//  FriendlyLoan
//
//  Created by Christian Rasmussen on 17.07.12.
//  Copyright (c) 2012 Rasmussen I/O. All rights reserved.
//

#import "Category.h"
#import "CategoryList.h"


@implementation Category

- (NSNumber *)categoryID
{
    return nil;
}

- (NSString *)title
{
    return nil;//[CategoryList nameForCategoryID:self.categoryID];
}

- (UIImage *)image
{
    return nil;//[CategoryList imageForCategoryID:self.categoryID];
}

- (UIImage *)highlightedImage
{
    return nil;//[CategoryList highlightedImageForCategoryID:self.categoryID];
}

@end
