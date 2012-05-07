//
//  Transaction+Category.h
//  FriendlyLoan
//
//  Created by Christian Rasmussen on 26.09.11.
//  Copyright (c) 2011 Rasmussen I/O. All rights reserved.
//

#import "Transaction.h"


@interface Transaction (Category)

- (NSString *)categoryName;
- (UIImage *)categoryImage;
- (UIImage *)categoryHighlightedImage;

@end
