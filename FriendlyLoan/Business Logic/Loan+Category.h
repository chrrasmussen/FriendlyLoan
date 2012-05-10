//
//  Loan+Category.h
//  FriendlyLoan
//
//  Created by Christian Rasmussen on 26.09.11.
//  Copyright (c) 2011 Rasmussen I/O. All rights reserved.
//

#import "Loan.h"


@interface Loan (Category)

- (NSString *)categoryName;
- (UIImage *)categoryImage;
- (UIImage *)categoryHighlightedImage;

@end
