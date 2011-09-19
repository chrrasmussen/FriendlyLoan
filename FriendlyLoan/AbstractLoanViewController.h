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

@property (nonatomic) BOOL lent;
@property (nonatomic) int selectedPersonID;
@property (nonatomic) int selectedCategoryID;

@property (nonatomic, strong) IBOutlet UITextField *amountTextField;
@property (nonatomic, strong) IBOutlet UILabel *personValueLabel;
@property (nonatomic, strong) IBOutlet UILabel *categoryValueLabel;
@property (nonatomic, strong) IBOutlet UITextField *noteTextField;

- (void)saveContext;
- (void)updateTransaction:(Transaction *)transaction;

- (void)updateSelectedPersonID:(int)personID;
- (void)updateSelectedCategoryID:(int)categoryID;

- (void)hideKeyboard;
- (void)showPeoplePickerController;
- (void)validateAmountAndPerson;

// Override methods
- (void)setSaveButtonsEnabledState:(BOOL)enabled;

@end
