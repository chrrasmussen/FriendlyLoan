//
//  AddLoanViewController.m
//  FriendlyLoan
//
//  Created by Christian Rasmussen on 09.09.11.
//  Copyright (c) 2011 Rasmussen I/O. All rights reserved.
//

#import "AddLoanViewController.h"
#import <CoreLocation/CoreLocation.h>

#import "DetailsViewController.h"
#import "CategoriesViewController.h"

#import "Models.h"
#import "LocationManager.h"


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

// TODO: Temp method
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

- (void)updateTransactionBasedOnViewInfo:(Transaction *)theTansaction
{
    [super updateTransactionBasedOnViewInfo:theTansaction];
    
    theTansaction.createdTimestamp = [NSDate date];
    
    [theTansaction addCurrentLocation];
}

- (void)resetFields
{
    [super resetFields];
    
    // TODO: Is it necessary to reset attachLocationSwitch? Probably (State may have changed will another view is visible)
}


#pragma mark - Managing the hierarchy

- (void)popToBlankViewControllerAnimated:(BOOL)animated
{
    [self.navigationController popToRootViewControllerAnimated:animated];
    [self resetFields];
}


#pragma mark - Properties

- (BOOL)attachLocationState
{
    if ([CLLocationManager authorizationStatus] != kCLAuthorizationStatusAuthorized)
        return NO;
    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"attachLocation"] == nil)
        return YES;
    
    BOOL theAttachLocationState = [[NSUserDefaults standardUserDefaults] boolForKey:@"attachLocation"];
    
    return theAttachLocationState;
}

- (void)setAttachLocationState:(BOOL)theAttachLocationState
{
//    if (theAttachLocationState == YES)
//        [self startUpdatingLocation];
//    else
//        [self stopUpdatingLocation];
    
    if ([CLLocationManager authorizationStatus] != kCLAuthorizationStatusAuthorized)
        return;
    
    [[NSUserDefaults standardUserDefaults] setBool:theAttachLocationState forKey:@"attachLocation"];
    [[NSUserDefaults standardUserDefaults] synchronize];
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

- (IBAction)changeAttachLocationState:(id)sender
{
    [self setAttachLocationState:self.attachLocationSwitch.on];
    [self.attachLocationSwitch setOn:self.attachLocationState animated:YES];
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
    
    // Set initial state for attach location
    self.attachLocationSwitch.on = self.attachLocationState;
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
    self.transaction = [Transaction newTransaction];
    [self updateTransactionBasedOnViewInfo:self.transaction];
    [self.transaction save];
}

- (void)detailsViewControllerAdd:(id)sender
{
    [self popToBlankViewControllerAnimated:YES];
}

- (void)startUpdatingLocation
{
    if (self.attachLocationState == YES)
        [[LocationManager sharedManager] startUpdatingLocation];
}

- (void)stopUpdatingLocation
{
    [[LocationManager sharedManager] stopUpdatingLocation];
}

@end
