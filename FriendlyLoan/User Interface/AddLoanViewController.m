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


const CLLocationDistance kDistanceFilter = 100;


@interface AddLoanViewController ()

- (void)startUpdatingLocation;
- (void)stopUpdatingLocation;

- (Transaction *)addTransaction;

- (void)detailsViewControllerAdd:(id)sender;

@end


@implementation AddLoanViewController

@synthesize locationManager, lastKnownLocation;
@synthesize borrowBarButtonItem, lendBarButtonItem, attachLocationSwitch;

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - Override methods

// FIXME: Update
- (BOOL)hasChanges
{
    return [super hasChanges];
}

- (void)setSaveButtonsEnabledState:(BOOL)enabled
{
    self.borrowBarButtonItem.enabled = enabled;
    self.lendBarButtonItem.enabled = enabled;
}

- (void)updateTransactionBasedOnViewInfo:(Transaction *)theTansaction
{
    [super updateTransactionBasedOnViewInfo:theTansaction];
    
    theTansaction.createdTimestamp = [NSDate date];
    
    if (self.lastKnownLocation != nil)
    {
        CLLocationCoordinate2D location = self.lastKnownLocation.coordinate;
        theTansaction.location.latitude = [NSNumber numberWithDouble:location.latitude];
        theTansaction.location.longitude = [NSNumber numberWithDouble:location.longitude];
    }
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
    if (theAttachLocationState == YES)
        [self startUpdatingLocation];
    else
        [self stopUpdatingLocation];
    
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
    if (self.attachLocationState == YES)
        [self startUpdatingLocation];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    if (self.attachLocationState == YES)
        [self stopUpdatingLocation];
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

#pragma mark - CLLocationManagerDelegate methods

// FIXME: Fix this
- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status
{
    NSLog(@"%s %d %d", (char *)_cmd, status, [CLLocationManager locationServicesEnabled]);
//    [self.attachLocationSwitch setOn:self.attachLocationState animated:YES];
}

// FIXME: Update method
- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    // If it's a relatively recent event, turn off updates to save power
    NSDate* eventDate = newLocation.timestamp;
    NSTimeInterval howRecent = [eventDate timeIntervalSinceNow];
    if (abs(howRecent) < 15.0)
    {
        self.lastKnownLocation = newLocation;
        NSLog(@"Delegated:%@", newLocation);
    }
    // else skip the event and process the next one.
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"%s %d %d %@", (char *)_cmd, [CLLocationManager authorizationStatus], [CLLocationManager locationServicesEnabled], error);
}

#pragma mark - Private methods

- (void)startUpdatingLocation
{
    NSLog(@"%s %d %d", (char *)_cmd, [CLLocationManager authorizationStatus], [CLLocationManager locationServicesEnabled]);
    
    if (self.locationManager == nil)
        self.locationManager = [[CLLocationManager alloc] init];
    
    self.locationManager.delegate = self;
//    self.locationManager.purpose = NSLocalizedString(@"This app uses the location services to determine your location when adding a loan.", nil); // TODO: Add proper description
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    self.locationManager.distanceFilter = kDistanceFilter;
    
    NSLog(@"Starting update");
    [self.locationManager startUpdatingLocation];
    
    NSLog(@"Initial:%@", self.locationManager.location);
}

- (void)stopUpdatingLocation
{
    [self.locationManager stopUpdatingLocation];
}

- (Transaction *)addTransaction
{
    Transaction *transaction = [NSEntityDescription insertNewObjectForEntityForName:@"Transaction" inManagedObjectContext:self.managedObjectContext];
    
    [self updateTransactionBasedOnViewInfo:transaction];
    
    [self saveContext];
    NSLog(@"Transaction added!");
    
    return transaction;
}

- (void)detailsViewControllerAdd:(id)sender
{
    [self.navigationController popToRootViewControllerAnimated:YES];
    [self resetFields];
//    [self popToBlankViewControllerAnimated:YES];
}

@end
