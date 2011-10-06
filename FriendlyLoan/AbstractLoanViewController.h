//
//  AbstractLoanViewController.h
//  FriendlyLoan
//
//  Created by Christian Rasmussen on 19.09.11.
//  Copyright (c) 2011 Rasmussen I/O. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AddressBookUI/AddressBookUI.h>

#import "CategoriesViewControllerDelegate.h"


@class Transaction;

@interface AbstractLoanViewController : UITableViewController <ABPeoplePickerNavigationControllerDelegate, UITextFieldDelegate, CategoriesViewControllerDelegate>

@property (nonatomic, strong, readonly) NSManagedObjectContext *managedObjectContext;

@property (nonatomic) BOOL lentState;
@property (nonatomic, strong) NSNumber *selectedFriendID;
@property (nonatomic, strong) NSNumber *selectedCategoryID;

@property (nonatomic, strong) IBOutlet UITextField *amountTextField;
@property (nonatomic, strong) IBOutlet UILabel *friendValueLabel;
@property (nonatomic, strong) IBOutlet UILabel *categoryValueLabel;
@property (nonatomic, strong) IBOutlet UITextField *noteTextField;
@property (nonatomic, strong) IBOutlet UITableViewCell *friendCell;

- (void)saveContext;

- (void)updateSelectedFriendID:(NSNumber *)friendID;
- (void)updateSelectedCategoryID:(NSNumber *)categoryID;

- (void)hideKeyboard;
- (void)showPeoplePickerController;
- (void)validateAmountAndFriend;

// Override methods
- (BOOL)hasChanges;
- (void)setSaveButtonsEnabledState:(BOOL)enabled;
- (void)updateTransactionBasedOnViewInfo:(Transaction *)transaction;
- (void)resetFields;

@end
