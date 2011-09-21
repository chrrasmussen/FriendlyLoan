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
@synthesize amountLabel, personLabel, categoryLabel, noteLabel, timeStampLabel, mapView;

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
    [self dismissModalViewControllerAnimated:YES];
}

- (void)editLoanViewControllerDidSave:(EditLoanViewController *)editLoanViewController
{
    [self updateViewInfo];
    
    [self dismissModalViewControllerAnimated:YES];
}

#pragma mark - UITableViewDelegate methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger rows = [super tableView:tableView numberOfRowsInSection:section];
    return ([self.transaction hasLocation] == YES) ? rows : rows - 1;
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
    if ([self.transaction hasLocation] == YES)
    {
        MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(self.transaction.coordinate, kMapViewLocationDistance, kMapViewLocationDistance);
        MKCoordinateRegion adjustedRegion = [mapView regionThatFits:region];
        [self.mapView setRegion:adjustedRegion animated:NO];
        
        [self.mapView addAnnotation:self.transaction];
    }
}

- (void)updateViewInfo
{
    self.amountLabel.text = [transaction.amount stringValue];
    self.personLabel.text = transaction.personName;
    self.categoryLabel.text = [transaction.categoryID stringValue];
    self.noteLabel.text = transaction.note;
    self.timeStampLabel.text = [transaction.createdTimeStamp description];
    
    [self showLocationInfo];
}

@end
