//
//  AddLoanViewController.m
//  FriendlyLoan
//
//  Created by Christian Rasmussen on 09.09.11.
//  Copyright (c) 2011 Rasmussen I/O. All rights reserved.
//

#import "AddLoanViewController.h"
#import <CoreLocation/CoreLocation.h>

#import "LoanManager.h"
#import "BackendManager.h"

#import "DetailsViewController.h"
#import "CategoriesViewController.h"


@implementation AddLoanViewController

@synthesize borrowBarButtonItem, lendBarButtonItem, attachLocationSwitch, shareLoanSwitch;

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}


#pragma mark - Override methods

- (void)setSaveButtonsEnabledState:(BOOL)enabled
{
    self.borrowBarButtonItem.enabled = enabled;
    self.lendBarButtonItem.enabled = enabled;
}

- (void)updateTransactionBasedOnViewInfo:(Transaction *)theTransaction
{
    [super updateTransactionBasedOnViewInfo:theTransaction];
    
    BOOL attachLocation = [[LoanManager sharedManager] attachLocationValue];
    theTransaction.attachLocation = [NSNumber numberWithBool:attachLocation];
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

- (IBAction)changeAttachLocationValue:(UISwitch *)sender
{
    [[LoanManager sharedManager] setAttachLocationValue:sender.on];
}

- (IBAction)changeShareLoanValue:(UISwitch *)sender
{
    // TODO: Check if user is logged in
    // TODO: Check if selected friend is applicable
}

- (IBAction)detailsViewControllerAdd:(id)sender
{
    [self popToBlankViewControllerAnimated:YES];
}


#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [[LoanManager sharedManager] setAttachLocationDelegate:self];
    self.attachLocationSwitch.on = [[LoanManager sharedManager] attachLocationValue];
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

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


#pragma mark - Storyboard methods

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    [super prepareForSegue:segue sender:sender];
    
    if ([[segue identifier] isEqualToString:@"SaveSegue"])
    {
        // Add transaction
        Transaction *transaction = [self addTransaction];
        
        // Set up details view controller
        DetailsViewController *detailsViewController = [segue destinationViewController];
        [self configureDetailsViewController:detailsViewController];
        detailsViewController.transaction = transaction;
        
//        // Hide keyboard in order to avoid it becoming first responder when the view appears
//        [self hideKeyboard];
    }
}


#pragma mark - LoanManagerAttachLocationDelegate methods

- (void)loanManager:(LoanManager *)loanManager didChangeAttachLocationValue:(BOOL)attachLocation
{
    [self.attachLocationSwitch setOn:attachLocation animated:YES];
}


#pragma mark - Private methods

- (Transaction *)addTransaction
{
    Transaction *result = [[LoanManager sharedManager] addTransactionWithUpdateHandler:^(Transaction *transaction) {
        [self updateTransactionBasedOnViewInfo:transaction];
    }];
    
    [[BackendManager sharedManager] shareTransaction:result];
    
    return result;
}

- (void)configureDetailsViewController:(DetailsViewController *)detailsViewController
{
    detailsViewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(detailsViewControllerAdd:)];
    detailsViewController.navigationItem.rightBarButtonItem = nil;
}

@end
