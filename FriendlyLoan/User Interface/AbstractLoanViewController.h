//
//  AbstractLoanViewController.h
//  FriendlyLoan
//
//  Created by Christian Rasmussen on 19.09.11.
//  Copyright (c) 2011 Rasmussen I/O. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "FriendViewControllerDelegate.h"
#import "CategoryViewControllerDelegate.h"


@protocol FLLoanManager;
@protocol FLLoan;


@interface AbstractLoanViewController : UITableViewController <UITextFieldDelegate, FriendViewControllerDelegate, CategoryViewControllerDelegate>

@property (nonatomic, weak) IBOutlet UITableViewCell *friendCell;

@property (nonatomic, strong) IBOutlet UITextField *amountTextField;
@property (nonatomic, strong) IBOutlet UILabel *friendValueLabel;
@property (nonatomic, strong) IBOutlet UILabel *categoryValueLabel;
@property (nonatomic, strong) IBOutlet UITextField *noteTextField;

@property (nonatomic) BOOL lentStatus;
@property (nonatomic, strong) NSDecimalNumber *amount;
@property (nonatomic, strong) NSNumber *selectedFriendID;
@property (nonatomic, strong) NSNumber *selectedCategoryID;
@property (nonatomic, strong) NSString *note;

- (void)hideKeyboard;
- (void)validateAmountAndFriend;

// Override methods
//- (BOOL)isViewInfoEqualToLoan:(Loan *)loan;
- (void)setSaveButtonsEnabledState:(BOOL)enabled;
- (void)updateLoanBasedOnViewInfo:(id<FLLoan>)loan;
- (void)resetFields;

@end
