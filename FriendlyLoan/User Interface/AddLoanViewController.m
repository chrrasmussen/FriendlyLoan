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

#import "LoanManager.h"


@interface AddLoanViewController ()

- (Transaction *)addTransaction;

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
    
    // TODO: Is it necessary to reset attachLocationSwitch?
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
    
//    [self startUpdatingLocation];
//    [self performSelector:@selector(startUpdatingLocation) withObject:nil afterDelay:3.0];
    
    // Set initial state for attach location
    self.attachLocationSwitch.on = self.attachLocationState;
//    if (self.attachLocationState == YES)
//        [self startUpdatingLocation];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
//    if (self.attachLocationState == YES)
//        [self stopUpdatingLocation];
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
        Transaction *transaction = [self addTransaction];
        
        DetailsViewController *detailsViewController = [segue destinationViewController];
        detailsViewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(detailsViewControllerAdd:)];
        detailsViewController.navigationItem.rightBarButtonItem = nil;
        detailsViewController.transaction = transaction;
    }
}

#pragma mark - Private methods

- (Transaction *)addTransaction
{
    Transaction *transaction = [[LoanManager sharedManager] newTransaction];
    [self updateTransactionBasedOnViewInfo:transaction];
    
    [[LoanManager sharedManager] saveContext];
    
    return transaction;
}

- (void)detailsViewControllerAdd:(id)sender
{
    [self popToBlankViewControllerAnimated:YES];
}

@end
