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


const CLLocationDistance kDistanceFilter = 500;


@interface AddLoanViewController ()

- (void)startUpdatingLocation;

- (Transaction *)addTransaction;

- (void)detailsViewControllerAdd:(id)sender;
- (void)popToBlankViewControllerAnimated:(BOOL)animated;

@end


@implementation AddLoanViewController

@synthesize locationManager, lastKnownLocation;
@synthesize borrowBarButtonItem, lendBarButtonItem, locationLabel, locationProgressView;

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)setSaveButtonsEnabledState:(BOOL)enabled
{
    self.borrowBarButtonItem.enabled = enabled;
    self.lendBarButtonItem.enabled = enabled;
}

- (void)updateTransactionBasedOnViewInfo:(Transaction *)theTansaction
{
    [super updateTransactionBasedOnViewInfo:theTansaction];
    
    theTansaction.createdTimeStamp = [NSDate date];
    
    if (self.lastKnownLocation != nil)
    {
        CLLocationCoordinate2D location = self.lastKnownLocation.coordinate;
        theTansaction.createdLatitude = [NSNumber numberWithDouble:location.latitude];
        theTansaction.createdLongitude = [NSNumber numberWithDouble:location.longitude];
    }
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
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self startUpdatingLocation];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    [self.locationManager stopUpdatingLocation];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Actions

- (IBAction)borrow:(id)sender
{
    self.lent = NO;
    
    [self performSegueWithIdentifier:@"SaveSegue" sender:sender];
}

- (IBAction)lend:(id)sender
{
    self.lent = YES;
    
    [self performSegueWithIdentifier:@"SaveSegue" sender:sender];
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
        detailsViewController.transaction = transaction;
    }
}

#pragma mark - CLLocationManagerDelegate methods

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

#pragma mark - Private methods

- (void)startUpdatingLocation
{
    if ([CLLocationManager locationServicesEnabled] == YES)
    {
        if (self.locationManager == nil)
            self.locationManager = [[CLLocationManager alloc] init];
        
        self.locationManager.delegate = self;
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        self.locationManager.distanceFilter = kDistanceFilter;
        
        [self.locationManager startUpdatingLocation];
        
        NSLog(@"Initial:%@", self.locationManager.location);
    }
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
    [self popToBlankViewControllerAnimated:YES];
}

- (void)popToBlankViewControllerAnimated:(BOOL)animated
{
    if ([self.navigationController.viewControllers count] >= 2)
    {
        AddLoanViewController *blankAddLoanViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"AddLoanViewController"];
        NSArray *viewControllers = [NSArray arrayWithObjects:blankAddLoanViewController, self, self.navigationController.visibleViewController, nil];
        [self.navigationController setViewControllers:viewControllers];
        [self.navigationController popToRootViewControllerAnimated:animated];
    }
}

@end
