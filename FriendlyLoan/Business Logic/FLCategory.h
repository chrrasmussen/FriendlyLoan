//
//  FLCategory.h
//  FriendlyLoan
//
//  Created by Christian Rasmussen on 16.07.12.
//  Copyright (c) 2012 Rasmussen I/O. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol FLCategory <NSObject>

@property (nonatomic, readonly) NSNumber *categoryID;
@property (nonatomic, readonly) NSString *title;
@property (nonatomic, readonly) UIImage *image;
@property (nonatomic, readonly) UIImage *highlightedImage;

@end
