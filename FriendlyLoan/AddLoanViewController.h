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


@class AmountTextField;

@interface AddLoanViewController : UITableViewController <ABPeoplePickerNavigationControllerDelegate, UITextFieldDelegate, AmountTextFieldDelegate>

@property (nonatomic, strong, readonly) NSManagedObjectContext *managedObjectContext;

@property (nonatomic) BOOL lent;
@property (nonatomic) int personId;
@property (nonatomic, strong) NSString *personName;
@property (nonatomic) int category;

@property (nonatomic, strong) IBOutlet UITextField *amountTextField;
@property (nonatomic, strong) IBOutlet UITextField *noteTextField;
@property (nonatomic, strong) IBOutlet UIBarButtonItem *saveBarButtonItem;

@property (nonatomic, strong) IBOutlet UILabel *amountDescriptionLabel;
@property (nonatomic, strong) IBOutlet UILabel *personDescriptionLabel;
@property (nonatomic, strong) IBOutlet UILabel *personValueLabel;

- (IBAction)cancel:(id)sender;
- (IBAction)save:(id)sender;

- (IBAction)selectCategory:(id)sender;

@end
