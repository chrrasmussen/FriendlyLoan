//
//  FFTextField.m
//  FriendlyLoan
//
//  Created by Christian Rasmussen on 10.09.11.
//  Copyright (c) 2011 Rasmussen I/O. All rights reserved.
//

#import "AmountTextField.h"

@interface AmountTextField ()

- (void)hideKeyboard:(id)sender;

@end


@implementation AmountTextField

- (UIView *)inputAccessoryView
{
    UIButton *hideKeyboardButton = [UIButton buttonWithType:UIButtonTypeCustom];
    hideKeyboardButton.frame = CGRectMake(0, 0, 0, 54);
    
    UIImage *keyboardBackgroundImage = [UIImage imageNamed:@"KeyboardBackground-Normal"];
    UIImage *keyboardBackgroundHighlightedImage = [UIImage imageNamed:@"KeyboardBackground-Highlighted"];
    
    [hideKeyboardButton setBackgroundImage:keyboardBackgroundImage forState:UIControlStateNormal];
    [hideKeyboardButton setBackgroundImage:keyboardBackgroundHighlightedImage forState:UIControlStateHighlighted];
    
    [hideKeyboardButton setTitle:NSLocalizedString(@"Hide Keyboard", @"Button text for the numeric keyboard in Add Loan-tab") forState:UIControlStateNormal];
    
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

- (void)hideKeyboard:(id)sender
{
    [self resignFirstResponder];
}

@end
