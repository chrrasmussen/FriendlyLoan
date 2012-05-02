//
//  FFTextField.m
//  FriendlyLoan
//
//  Created by Christian Rasmussen on 10.09.11.
//  Copyright (c) 2011 Rasmussen I/O. All rights reserved.
//

#import "FFTextField.h"

@interface FFTextField ()

- (void)forwardBorrowAction;
- (void)forwardLendAction;

@end


@implementation FFTextField

// TODO: Find the correct tint color and button width
- (UIView *)inputAccessoryView
{
    UIToolbar *toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0.0, 0.0, 0.0, 44.0)];
    [toolbar setTintColor:[UIColor colorWithRed:(93.0/255.0) green:(100.0/255.0) blue:(114.0/255.0) alpha:1.0]];
    
    UIBarButtonItem *flexibleSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:NULL];
    UIBarButtonItem *borrowBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"Borrow", nil) style:UIBarButtonItemStyleBordered target:self action:@selector(forwardBorrowAction)];
    borrowBarButtonItem.width = 151.0;
    UIBarButtonItem *lendBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"Lend", nil) style:UIBarButtonItemStyleBordered target:self action:@selector(forwardLendAction)];
    lendBarButtonItem.width = 151.0;
    [toolbar setItems:[NSArray arrayWithObjects:borrowBarButtonItem, flexibleSpace, lendBarButtonItem, nil]];
    
    return toolbar;
}

- (void)forwardBorrowAction
{
    if ([self.delegate respondsToSelector:@selector(textFieldBorrowButtonTapped:)])
        [self.delegate performSelector:@selector(textFieldBorrowButtonTapped:)];
}

- (void)forwardLendAction
{
    if ([self.delegate respondsToSelector:@selector(textFieldLendButtonTapped:)])
        [self.delegate performSelector:@selector(textFieldLendButtonTapped:)];
}

@end