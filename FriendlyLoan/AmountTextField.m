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

//- (UIView *)inputView
//{
//    
//    UIView *buttonView = [[UIView alloc] initWithFrame:CGRectMake(100.0, 100.0, 100.0, 100.0)];
//    buttonView.backgroundColor = [UIColor blueColor];
//    return nil;
//}

// TODO: Find the correct tint color and button width -- Will be replaced by another solution
- (UIView *)inputAccessoryView
{
//    UIToolbar *toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0.0, 0.0, 0.0, 44.0)];
//    [toolbar setTintColor:[UIColor colorWithRed:(93.0/255.0) green:(100.0/255.0) blue:(114.0/255.0) alpha:1.0]];
//    
////    borrowBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"Borrow", nil) style:UIBarButtonItemStyleBordered target:self action:@selector(forwardBorrowAction)];
////    borrowBarButtonItem.width = 151.0;
////    
////    lendBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"Lend", nil) style:UIBarButtonItemStyleBordered target:self action:@selector(forwardLendAction)];
////    lendBarButtonItem.width = 151.0;
//    
//    UIBarButtonItem *doneBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(hideKeyboard:)];
//    
////    UIBarButtonItem *flexibleSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:NULL];
////    [toolbar setItems:[NSArray arrayWithObjects:borrowBarButtonItem, flexibleSpace, lendBarButtonItem, nil]];
//    [toolbar setItems:[NSArray arrayWithObjects:doneBarButtonItem, nil]];
    
    // BUTTON
    UIButton *hideKeyboardButton = [UIButton buttonWithType:UIButtonTypeCustom];
    hideKeyboardButton.frame = CGRectMake(0, 0, 0, 54);
    
    UIImage *keyboardBackgroundImage = [UIImage imageNamed:@"KeyboardBackground-Normal"];
    UIImage *keyboardBackgroundHighlightedImage = [UIImage imageNamed:@"KeyboardBackground-Highlighted"];
    
//    UIImage *keyboardBackgroundStretchableImage = [keyboardBackgroundImage stretchableImageWithLeftCapWidth:0 topCapHeight:0];
    
    [hideKeyboardButton setBackgroundImage:keyboardBackgroundImage forState:UIControlStateNormal];
    [hideKeyboardButton setBackgroundImage:keyboardBackgroundHighlightedImage forState:UIControlStateHighlighted];
    
    [hideKeyboardButton setTitle:NSLocalizedString(@"Hide Keyboard", nil) forState:UIControlStateNormal];
    
    [hideKeyboardButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [hideKeyboardButton setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
    [hideKeyboardButton setTitleShadowColor:[UIColor blackColor] forState:UIControlStateNormal];
    [hideKeyboardButton setTitleShadowColor:[UIColor clearColor] forState:UIControlStateHighlighted];
    
    hideKeyboardButton.titleLabel.shadowOffset = CGSizeMake(0, -1);
    hideKeyboardButton.titleLabel.font = [UIFont boldSystemFontOfSize:22.0]; // 28 is the size of the digits
    
    [hideKeyboardButton addTarget:self action:@selector(hideKeyboard:) forControlEvents:UIControlEventTouchUpInside];
    
    return hideKeyboardButton;
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
