//
//  AddLoanViewController.m
//  FriendlyLoan
//
//  Created by Christian Rasmussen on 09.09.11.
//  Copyright (c) 2011 Rasmussen I/O. All rights reserved.
//

#import "AddLoanViewController.h"
#import <CoreLocation/CoreLocation.h>

#import "FriendlyLoan.h"

#import "DetailsViewController.h"
#import "CategoryViewController.h"


@implementation AddLoanViewController


#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setUpNotificationObservers];
    //    CGRect screenBounds = [[UIScreen mainScreen] bounds];
    //    UIWindow * alertWindow = [[UIWindow alloc] initWithFrame:screenBounds];
    //    alertWindow.windowLevel = UIWindowLevelAlert;
    //    
    //    alertWindow.rootViewController = [[UIViewController alloc] init];
    //    
    //    [alertWindow makeKeyAndVisible];
    
//    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"FriendlyLoan" bundle:nil];
//    UINavigationController *navigationController = [storyboard instantiateViewControllerWithIdentifier:@"LoanRequestNavigationController"];
    //    UITabBarController *tbc = (UITabBarController *)self.window.rootViewController;
    //    UINavigationController *nc = (UINavigationController *)[tbc.viewControllers objectAtIndex:0];
    //    AddLoanViewController *alvc = (AddLoanViewController *)nc.topViewController;
//    [self presentModalViewController:navigationController animated:YES];
    
//    [[LoanManager sharedManager] addObserver:self forKeyPath:@"calculatedAttachLocationValue" options:(NSKeyValueObservingOptionInitial | NSKeyValueObservingOptionNew) context:NULL];
//    [[LoanManager sharedManager] addObserver:self forKeyPath:@"calculatedShareLoanValue" options:(NSKeyValueObservingOptionInitial | NSKeyValueObservingOptionNew) context:NULL];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    // Avoid the keyboard to be active when application is started
    // Hide keyboard in order to avoid it becoming first responder when the view appears
    [self hideKeyboard];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}


#pragma mark - Override methods

- (void)setSaveButtonsEnabledState:(BOOL)enabled
{
    self.borrowBarButtonItem.enabled = enabled;
    self.lendBarButtonItem.enabled = enabled;
}

- (void)updateLoanBasedOnViewInfo:(id<FLLoan>)loan
{
    [super updateLoanBasedOnViewInfo:loan];
    
    // FIXME: Fix code
//    theLoan.attachLocationValue = [[LoanManager sharedManager] calculatedAttachLocationValue];
}

- (void)resetFields
{
    [super resetFields];
}


#pragma mark - Managing the hierarchy

- (void)popToBlankViewControllerAnimated:(BOOL)animated
{
    [self.navigationController popToRootViewControllerAnimated:animated];
    [self resetFields];
}


#pragma mark - Actions

- (IBAction)textFieldDidBeginEditing:(id)sender
{
}

- (IBAction)borrow:(id)sender
{
    self.lentStatus = NO;
    
    [self performSegueWithIdentifier:@"SaveSegue" sender:sender];
}

- (IBAction)lend:(id)sender
{
    self.lentStatus = YES;
    
    [self performSegueWithIdentifier:@"SaveSegue" sender:sender];
}

- (IBAction)changeAddLocationValue:(UISwitch *)sender
{
    // FIXME: Fix code
//    [[LoanManager sharedManager] setAttachLocationValue:sender.on];
}

- (IBAction)changeShareLoanValue:(UISwitch *)sender
{
    // FIXME: Fix code
//    [[LoanManager sharedManager] setShareLoanValue:sender.on];
}

- (IBAction)detailsViewControllerAdd:(id)sender
{
    [self popToBlankViewControllerAnimated:YES];
}

#pragma mark - Storyboard methods

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    [super prepareForSegue:segue sender:sender];
    
    if ([segue.identifier isEqualToString:@"SaveSegue"])
    {
        // Add loan
        id<FLLoan> loan = [self addLoan];
        
        // Set up details view controller
        DetailsViewController *detailsViewController = [segue destinationViewController];
        [self configureDetailsViewController:detailsViewController];
        detailsViewController.loan = loan;
        
//        // Hide keyboard in order to avoid it becoming first responder when the view appears
//        [self hideKeyboard];
    }
}


#pragma mark - Private methods

- (void)setUpNotificationObservers
{
//    typeof(self) bself = self;
//
//    [NSNotificationCenter.defaultCenter addObserverForName:FLLoanManagerDidUpdateAttachLocation object:nil queue:nil usingBlock:^(NSNotification *note) {
//        BOOL attachLocation = [note.userInfo[FLLoanManagerAttachLocationNotificationKey] boolValue];
//        [bself.attachLocationSwitch setOn:attachLocation animated:YES];
//    }];
}

- (id<FLLoan>)addLoan
{
    // TODO: Fix code
//    id<FLLoan> loan = [self.loanManager addLoanWithAmount:self.amount friendID:self.selectedFriendID categoryID:self.selectedCategoryID note:self.note];//self.location];
    
//    [self updateLoanBasedOnViewInfo:loan];
    
    return nil;
}

- (void)configureDetailsViewController:(DetailsViewController *)detailsViewController
{
    detailsViewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(detailsViewControllerAdd:)];
    detailsViewController.navigationItem.rightBarButtonItem = nil;
}

@end
