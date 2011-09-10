//
//  AddLoanViewController.h
//  FriendlyLoan
//
//  Created by Christian Rasmussen on 09.09.11.
//  Copyright (c) 2011 Rasmussen I/O. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AmountTextField.h"

@interface AddLoanViewController : UITableViewController <UITextFieldDelegate, AmountTextFieldDelegate>

@property (nonatomic, strong, readonly) NSManagedObjectContext *managedObjectContext;

@property (nonatomic, strong) IBOutlet UITextField *amountTextField;
@property (nonatomic, strong) IBOutlet UITextField *personTextField;
@property (nonatomic, strong) IBOutlet UISegmentedControl *categorySegmentedControl;
@property (nonatomic, strong) IBOutlet UITextField *noteTextField;

- (IBAction)cancel:(id)sender;
- (IBAction)save:(id)sender;

@end
