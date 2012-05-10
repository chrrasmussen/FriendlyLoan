//
//  Loan+Category.m
//  FriendlyLoan
//
//  Created by Christian Rasmussen on 26.09.11.
//  Copyright (c) 2011 Rasmussen I/O. All rights reserved.
//

#import "Loan+Category.h"
#import "CategoryList.h"


@implementation Loan (Category)

- (NSString *)categoryName
{
    return [CategoryList nameForCategoryID:self.categoryID];
}

- (UIImage *)categoryImage
{
    return [CategoryList imageForCategoryID:self.categoryID];
}

- (UIImage *)categoryHighlightedImage
{
    return [CategoryList highlightedImageForCategoryID:self.categoryID];
}

@end
