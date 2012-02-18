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

#import "DetailsViewController.h"
#import "CategoriesViewController.h"

#import "RIOTimedLocationManager.h"


@interface AddLoanViewController ()

- (void)addTransaction;

- (void)detailsViewControllerAdd:(id)sender;

@end


@implementation AddLoanViewController

@synthesize borrowBarButtonItem, lendBarButtonItem, attachLocationSwitch;

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)showPeoplePickerController
{
    [super showPeoplePickerController];
    
    [[LoanManager sharedManager] startUpdatingLocation];
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
    if (attachLocation == YES)
        [theTransaction addLocation:[[LoanManager sharedManager] location]];
    
    theTransaction.createdTimestamp = [NSDate date];
}

- (void)resetFields
{
    [super resetFields];
    
    self.attachLocationSwitch.on = [[LoanManager sharedManager] attachLocationValue];
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
    [[LoanManager sharedManager] startUpdatingLocation];
}

- (IBAction)borrow:(id)sender
{
    self.lentState = NO;
    
    [self performSegueWithIdentifier:@"SaveSegue" sender:sender];
}

- (IBAction)lend:(id)sender
{
    self.lentState = YES;
    
    [self performSegueWithIdentifier:@"SaveSegue" sender:sender];
}

- (IBAction)changeAttachLocationValue:(UISwitch *)sender
{
    [[LoanManager sharedManager] saveAttachLocationValue:sender.on];
    
    if (sender.on == YES)
        [[LoanManager sharedManager] startUpdatingLocation];
    else
        [[LoanManager sharedManager] stopUpdatingLocation];
}


#pragma mark - LoanManagerAttachLocationDelegate methods

- (void)loanManager:(LoanManager *)loanManager didChangeAttachLocationValue:(BOOL)attachLocation
{
    [self.attachLocationSwitch setOn:attachLocation animated:YES];
}


#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [[LoanManager sharedManager] setAttachLocationDelegate:self];
    
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
    
    // Set initial state for attach location switch
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
        [self addTransaction];
        
        // Set up details view controller
        DetailsViewController *detailsViewController = [segue destinationViewController];
        detailsViewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(detailsViewControllerAdd:)];
        detailsViewController.navigationItem.rightBarButtonItem = nil;
        detailsViewController.transaction = self.transaction;
        
//        // Hide keyboard in order to avoid it becoming first responder when the view appears
//        [self hideKeyboard];
    }
    else if ([[segue identifier] isEqualToString:@"CategoriesSegue"])
    {
        [[LoanManager sharedManager] startUpdatingLocation];
    }
}


#pragma mark - Private methods

- (void)addTransaction
{
    NSManagedObjectContext *managedObjectContext = [[LoanManager sharedManager] managedObjectContext];
    self.transaction = [Transaction insertInManagedObjectContext:managedObjectContext];
    [self updateTransactionBasedOnViewInfo:self.transaction];
    [[LoanManager sharedManager] saveContext];
}

- (void)detailsViewControllerAdd:(id)sender
{
    [self popToBlankViewControllerAnimated:YES];
}

@end
