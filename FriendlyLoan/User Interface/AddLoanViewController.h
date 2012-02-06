//
//  AddLoanViewController.h
//  FriendlyLoan
//
//  Created by Christian Rasmussen on 09.09.11.
//  Copyright (c) 2011 Rasmussen I/O. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AbstractLoanViewController.h"
#import "AppDelegateLocationDelegate.h"


@interface AddLoanViewController : AbstractLoanViewController <AppDelegateLocationDelegate>

@property (nonatomic, strong) IBOutlet UIBarButtonItem *borrowBarButtonItem;
@property (nonatomic, strong) IBOutlet UIBarButtonItem *lendBarButtonItem;
@property (nonatomic, strong) IBOutlet UISwitch *attachLocationSwitch;

- (void)popToBlankViewControllerAnimated:(BOOL)animated;

+ (BOOL)attachLocationStatus;
+ (void)saveAttachLocationStatus:(BOOL)status;

- (IBAction)textFieldDidBeginEditing:(id)sender;
- (IBAction)borrow:(id)sender;
- (IBAction)lend:(id)sender;
- (IBAction)changeAttachLocationStatus:(UISwitch *)sender;

@end
