//
//  AddLoanViewController.h
//  FriendlyLoan
//
//  Created by Christian Rasmussen on 09.09.11.
//  Copyright (c) 2011 Rasmussen I/O. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AddressBookUI/AddressBookUI.h>

#import "AmountTextField.h"

@class Person, AmountTextField;

@interface AddLoanViewController : UITableViewController <ABPeoplePickerNavigationControllerDelegate, UITextFieldDelegate, AmountTextFieldDelegate>

@property (nonatomic, strong, readonly) NSManagedObjectContext *managedObjectContext;

@property (nonatomic, strong) Person *person;
@property (nonatomic) NSInteger category;

// FIXME: Temp
@property (nonatomic) int personId;
@property (nonatomic, strong) NSString *personName;

@property (nonatomic, strong) IBOutlet UIBarButtonItem *saveBarButtonItem;

@property (nonatomic, strong) IBOutlet UILabel *amountDescriptionLabel;
@property (nonatomic, strong) IBOutlet AmountTextField *amountTextField;
@property (nonatomic, strong) IBOutlet UILabel *personDescriptionLabel;
@property (nonatomic, strong) IBOutlet UILabel *personValueLabel;

@property (nonatomic, strong) IBOutlet UITextField *noteTextField;

- (IBAction)save:(id)sender;

@end
