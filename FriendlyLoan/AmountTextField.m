//
//  FFTextField.m
//  FriendlyLoan
//
//  Created by Christian Rasmussen on 10.09.11.
//  Copyright (c) 2011 Rasmussen I/O. All rights reserved.
//

#import "AmountTextField.h"

@interface AmountTextField ()

//- (void)forwardBorrowAction;
//- (void)forwardLendAction;
- (void)hideKeyboard:(id)sender;

@end


@implementation AmountTextField

//@synthesize borrowBarButtonItem, lendBarButtonItem;

// TODO: Find the correct tint color and button width
- (UIView *)inputAccessoryView
{
    UIToolbar *toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0.0, 0.0, 0.0, 44.0)];
    [toolbar setTintColor:[UIColor colorWithRed:(93.0/255.0) green:(100.0/255.0) blue:(114.0/255.0) alpha:1.0]];
    
//    borrowBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"Borrow", nil) style:UIBarButtonItemStyleBordered target:self action:@selector(forwardBorrowAction)];
//    borrowBarButtonItem.width = 151.0;
//    
//    lendBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"Lend", nil) style:UIBarButtonItemStyleBordered target:self action:@selector(forwardLendAction)];
//    lendBarButtonItem.width = 151.0;
    
    UIBarButtonItem *doneBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(hideKeyboard:)];
    
//    UIBarButtonItem *flexibleSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:NULL];
//    [toolbar setItems:[NSArray arrayWithObjects:borrowBarButtonItem, flexibleSpace, lendBarButtonItem, nil]];
    [toolbar setItems:[NSArray arrayWithObjects:doneBarButtonItem, nil]];
    
    return toolbar;
}

#pragma mark - Private methods

//- (void)forwardBorrowAction
//{
//    if ([self.delegate respondsToSelector:@selector(textFieldBorrowButtonTapped:)])
//        [self.delegate performSelector:@selector(textFieldBorrowButtonTapped:) withObject:self];
//}
//
//- (void)forwardLendAction
//{
//    if ([self.delegate respondsToSelector:@selector(textFieldLendButtonTapped:)])
//        [self.delegate performSelector:@selector(textFieldLendButtonTapped:) withObject:self];
//}

- (void)hideKeyboard:(id)sender
{
    [self resignFirstResponder];
}

@end
