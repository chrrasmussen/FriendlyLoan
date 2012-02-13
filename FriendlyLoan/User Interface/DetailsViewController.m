//
//  DetailsViewController.m
//  FriendlyLoan
//
//  Created by Christian Rasmussen on 09.09.11.
//  Copyright (c) 2011 Rasmussen I/O. All rights reserved.
//

#import "DetailsViewController.h"
#import <QuartzCore/QuartzCore.h>

#import "LoanManager.h"

#import "Category.h"
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
    return ([self.transaction hasLocation]) ? rows : rows - 1;
}

//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    NSInteger rows = [super tableView:tableView numberOfRowsInSection:indexPath.section];
//    if (indexPath.row == rows - 1)
//    {
//        NSLog(@"Is locating:%d", [self.transaction isLocating]);
//    }
////    else
////    {
//    return [super tableView:tableView cellForRowAtIndexPath:indexPath];
////    }
//}

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
    if ([self.transaction hasLocation])
    {
        Location *location = self.transaction.location;
        MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance([location coordinate], kMapViewLocationDistance, kMapViewLocationDistance);
        [self.mapView setRegion:region animated:NO];
        
        [self.mapView addAnnotation:location];
    }
}

- (void)updateViewInfo
{
    self.lentDescriptionLabel.text = (transaction.lent == YES) ? NSLocalizedString(@"Lent", nil) : NSLocalizedString(@"Borrowed", nil);
    self.lentPrepositionLabel.text =  (transaction.lent == YES) ? NSLocalizedString(@"To", nil) : NSLocalizedString(@"From", nil);
    
    self.amountLabel.text = [transaction.absoluteAmount stringValue];
    self.friendLabel.text = [transaction.friend fullName];
    self.categoryLabel.text = [[Category categoryForCategoryID:transaction.categoryID] categoryName];
    self.noteLabel.text = transaction.note;
    
    // Display date
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    [dateFormatter setTimeStyle:NSDateFormatterShortStyle];
    
    NSString *formattedDateString = [dateFormatter stringFromDate:transaction.createdTimestamp];
    self.timeStampLabel.text = formattedDateString;
    
    [self showLocationInfo];
}

@end
