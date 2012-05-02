//
//  FFTextField.h
//  FriendlyLoan
//
//  Created by Christian Rasmussen on 10.09.11.
//  Copyright (c) 2011 Rasmussen I/O. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol AmountTextFieldDelegate <NSObject>

@optional
- (void)textFieldBorrowButtonTapped:(UITextField *)textField;
- (void)textFieldLendButtonTapped:(UITextField *)textField;

@end


@interface FFTextField : UITextField

@end
