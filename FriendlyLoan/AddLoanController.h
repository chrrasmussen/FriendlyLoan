//
//  AddLoanController.h
//  FriendlyLoan
//
//  Created by Christian Rasmussen on 12.06.11.
//  Copyright 2011 Rasmussen I/O. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface AddLoanController : UITableViewController

@property (nonatomic, strong) IBOutlet UITextField *peopleTextField;
@property (nonatomic, strong) IBOutlet UITextField *valueTextField;

- (IBAction)borrow:(id)sender;
- (IBAction)lend:(id)sender;

@end
