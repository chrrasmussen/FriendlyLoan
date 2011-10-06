//
//  DetailsViewController.m
//  FriendlyLoan
//
//  Created by Christian Rasmussen on 09.09.11.
//  Copyright (c) 2011 Rasmussen I/O. All rights reserved.
//

#import "DetailsViewController.h"
#import <QuartzCore/QuartzCore.h>

#import "Models.h"
#import "EditLoanViewController.h"


const CLLocationDistance kMapViewLocationDistance = 500;


@interface DetailsViewController ()

- (void)clipMapView;
- (void)updateViewInfo;

@end


@implementation DetailsViewController


@synthesize transaction;
@synthesize lentDescriptionLabel, lentPrepositionLabel;
@synthesize amountLabel, friendLabel, categoryLabel, noteLabel, timeStampLabel, mapView;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self clipMapView];
    
    [self updateViewInfo];
}

- (void)viewDidUnload
{
    [self setMapView:nil];
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

#pragma mark - Storyboard

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"EditSegue"])
    {
        UINavigationController *navigationController = [segue destinationViewController];
        EditLoanViewController *editLoanViewController = (EditLoanViewController *)navigationController.topViewController;
        editLoanViewController.delegate = self;
        editLoanViewController.transaction = self.transaction;
    }
}

#pragma mark - Core Data stack

- (NSManagedObjectContext *)managedObjectContext
{
    id appDelegate = [[UIApplication sharedApplication] delegate];
    return [appDelegate managedObjectContext];
}

#pragma mark - EditLoanViewControllerDelegate methods

- (void)editLoanViewControllerDidCancel:(EditLoanViewController *)editLoanViewController
{
    [self dismissViewControllerAnimated:YES completion:NULL];
}

- (void)editLoanViewControllerDidSave:(EditLoanViewController *)editLoanViewController
{
    [self updateViewInfo];
    
    [self dismissViewControllerAnimated:YES completion:NULL];
}

#pragma mark - UITableViewDelegate methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Hide map view
    NSInteger rows = [super tableView:tableView numberOfRowsInSection:section];
    return (self.transaction.location != nil) ? rows : rows - 1;
}

#pragma mark - Private methods

- (void)clipMapView
{
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    
    CGRect rect = self.mapView.bounds;
    CGFloat radius = 9;
    
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, CGRectGetMinX(rect), CGRectGetMinY(rect));
    CGPathAddArcToPoint(path, NULL, CGRectGetMinX(rect), CGRectGetMaxY(rect), CGRectGetMidX(rect), CGRectGetMaxY(rect), radius);
    CGPathAddArcToPoint(path, NULL, CGRectGetMaxX(rect), CGRectGetMaxY(rect), CGRectGetMaxX(rect), CGRectGetMidY(rect), radius);
    CGPathAddLineToPoint(path, NULL, CGRectGetMaxX(rect), CGRectGetMinY(rect));
    CGPathCloseSubpath(path);
    maskLayer.path = path;
    CGPathRelease(path);
    
    self.mapView.layer.mask = maskLayer;
}

- (void)showLocationInfo
{
    Location *location = self.transaction.location;
    
    if (location != nil)
    {
        MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance([location coordinate], kMapViewLocationDistance, kMapViewLocationDistance);
        [self.mapView setRegion:region animated:NO];
        
        [self.mapView addAnnotation:location];
    }
}

- (void)updateViewInfo
{
    self.lentDescriptionLabel.text = transaction.lentDescriptionString;
    self.lentPrepositionLabel.text = transaction.lentPrepositionString;
    
    self.amountLabel.text = [transaction.absoluteAmount stringValue];
    self.friendLabel.text = [transaction.friend fullName];
    self.categoryLabel.text = [transaction.categoryID stringValue];
    self.noteLabel.text = transaction.note;
    self.timeStampLabel.text = [transaction.createdTimestamp description];
    
    [self showLocationInfo];
}

@end