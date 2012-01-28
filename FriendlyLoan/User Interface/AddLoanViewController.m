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

#import "AppDelegate.h"
#import "Models.h"
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
    
    [self saveAttachLocationStatus:sender.on];
}


#pragma mark - Properties

- (BOOL)storedAttachLocationStatus
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    if ([userDefaults objectForKey:@"attachLocation"] == nil)
        return YES;
    
    BOOL status = [userDefaults boolForKey:@"attachLocation"];
    
    return status;
}

- (void)saveAttachLocationStatus:(BOOL)status
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setValue:[NSNumber numberWithBool:status] forKey:@"attachLocation"];
    [userDefaults synchronize];
}

#pragma mark - AppDelegateLocationDelegate methods

- (void)appDelegate:(AppDelegate *)appDelegate didChangeAttachLocationStatus:(BOOL)status
{
    BOOL storedStatus = [self storedAttachLocationStatus];
    BOOL calculatedStatus = status && storedStatus;
    [self.attachLocationSwitch setOn:calculatedStatus animated:YES];
}


#pragma mark - View lifecycle

- (void)viewDidLoad
{
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    appDelegate.locationDelegate = self;
    
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
    self.attachLocationSwitch.on = [self storedAttachLocationStatus];
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
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    self.transaction = [Transaction insertNewTransactionInManagedObjectContext:appDelegate.managedObjectContext];
    [self updateTransactionBasedOnViewInfo:self.transaction];
    [appDelegate saveContext];
}

- (void)detailsViewControllerAdd:(id)sender
{
    [self popToBlankViewControllerAnimated:YES];
}

- (void)startUpdatingLocation
{
    if (self.attachLocationSwitch.on == YES)
    {
        AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        [appDelegate startUpdatingLocation];
    }
}

- (void)stopUpdatingLocation
{
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [appDelegate stopUpdatingLocation];
}

@end
