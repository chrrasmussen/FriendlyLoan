//
//  CategoryMock.h
//  FriendlyLoan
//
//  Created by Christian Rasmussen on 20.07.12.
//  Copyright (c) 2012 Rasmussen I/O. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FLCategory.h"


@interface CategoryMock : NSObject <FLCategory>

@property (nonatomic, strong) NSNumber *categoryID;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) UIImage *image;
@property (nonatomic, strong) UIImage *highlightedImage;

@end
