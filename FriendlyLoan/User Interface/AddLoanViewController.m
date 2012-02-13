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

- (void)startUpdatingLocation;
- (void)stopUpdatingLocation;

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
    
    [self startUpdatingLocation];
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
    
    BOOL attachLocation = [[self class] attachLocationStatus];
    theTransaction.attachLocation = [NSNumber numberWithBool:attachLocation];
    if (attachLocation == YES)
        [theTransaction addLocation:[[LoanManager sharedManager] location]];
    
    theTransaction.createdTimestamp = [NSDate date];
}

- (void)resetFields
{
    [super resetFields];
    
    self.attachLocationSwitch.on = [[self class] attachLocationStatus];
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
    [self startUpdatingLocation];
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

- (IBAction)changeAttachLocationStatus:(UISwitch *)sender
{
    if (sender.on == YES)
        [self startUpdatingLocation];
    else
        [self stopUpdatingLocation];
    
    [[self class] saveAttachLocationStatus:sender.on];
}


#pragma mark - Attach location status

+ (BOOL)attachLocationStatus
{
    if ([CLLocationManager authorizationStatus] != kCLAuthorizationStatusAuthorized)
        return NO;
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    if ([userDefaults objectForKey:@"attachLocation"] == nil)
        return YES;
    
    BOOL status = [userDefaults boolForKey:@"attachLocation"];
    
    return status;
}

+ (void)saveAttachLocationStatus:(BOOL)status
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setValue:[NSNumber numberWithBool:status] forKey:@"attachLocation"];
    [userDefaults synchronize];
}

#pragma mark - LoanManagerAttachLocationDelegate methods

- (void)setAttachLocationStatus:(BOOL)attachLocation
{
    BOOL storedStatus = [[self class] attachLocationStatus];
    BOOL calculatedStatus = attachLocation && storedStatus;
    [self.attachLocationSwitch setOn:calculatedStatus animated:YES];
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
    self.attachLocationSwitch.on = [[self class] attachLocationStatus];
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
        [self startUpdatingLocation];
    }
}


#pragma mark - Private methods

- (void)addTransaction
{
    NSManagedObjectContext *managedObjectContext = [[LoanManager sharedManager] managedObjectContext];
    self.transaction = [Transaction insertNewTransactionInManagedObjectContext:managedObjectContext];
    [self updateTransactionBasedOnViewInfo:self.transaction];
    [[LoanManager sharedManager] saveContext];
}

- (void)detailsViewControllerAdd:(id)sender
{
    [self popToBlankViewControllerAnimated:YES];
}

- (void)startUpdatingLocation
{
    if (self.attachLocationSwitch.on == YES)
    {
        [[LoanManager sharedManager] startUpdatingLocation];
    }
}

- (void)stopUpdatingLocation
{
    [[LoanManager sharedManager] stopUpdatingLocation];
}

@end
