//
//  AddLoanViewController.h
//  FriendlyLoan
//
//  Created by Christian Rasmussen on 09.09.11.
//  Copyright (c) 2011 Rasmussen I/O. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddLoanViewController : UITableViewController

@property (nonatomic, strong, readonly) NSManagedObjectContext *managedObjectContext;

@property (nonatomic, strong) IBOutlet UISegmentedControl *lentSelection;
@property (nonatomic, strong) IBOutlet UITextField *amountField;
@property (nonatomic, strong) IBOutlet UITextField *personField;
@property (nonatomic, strong) IBOutlet UISegmentedControl *categorySelection;
@property (nonatomic, strong) IBOutlet UITextField *noteField;

- (IBAction)cancel:(id)sender;
- (IBAction)save:(id)sender;

@end
