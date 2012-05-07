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

#import "EditLoanViewController.h"


const CLLocationDistance kMapViewLocationDistance = 500;


@implementation DetailsViewController

@synthesize transaction;
@synthesize lentDescriptionLabel, lentPrepositionLabel;
@synthesize amountLabel, friendLabel, categoryLabel, noteLabel, timeStampLabel, mapView;


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
    
//    [self.transaction addObserver:self forKeyPath:@"locationStatus" options:NSKeyValueObservingOptionNew context:NULL];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
//    [self.transaction removeObserver:self forKeyPath:@"locationStatus"];
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

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Hide map view
    NSInteger rows = [super tableView:tableView numberOfRowsInSection:section];
    return (self.transaction.location != nil) ? rows : rows - 1;
}

//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
//{
////    NSInteger rows = [super tableView:tableView numberOfRowsInSection:indexPath.section];
////    if (indexPath.row == rows - 1)
////    {
////        if (self.transaction.locationStatus == kTransactionLocationStatusLocating)
////        {
////            NSIndexPath *locatingIndexPath = [NSIndexPath indexPathForRow:0 inSection:1];
////            return [super tableView:tableView cellForRowAtIndexPath:locatingIndexPath];
////        }
////        else if (self.transaction.locationStatus == kTransactionLocationStatusNotFound)
////        {
////            NSIndexPath *locatingIndexPath = [NSIndexPath indexPathForRow:1 inSection:1];
////            return [super tableView:tableView cellForRowAtIndexPath:locatingIndexPath];
////        }
////    }
//    
//    return [super tableView:tableView cellForRowAtIndexPath:indexPath];
//}
//
//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
////    NSInteger rows = [super tableView:tableView numberOfRowsInSection:indexPath.section];
////    if (indexPath.row == rows - 1)
////    {
////        if (self.transaction.locationStatus == kTransactionLocationStatusLocating)
////        {
////            NSIndexPath *locatingIndexPath = [NSIndexPath indexPathForRow:0 inSection:1];
////            return [super tableView:tableView heightForRowAtIndexPath:locatingIndexPath];
////        }
////        else if (self.transaction.locationStatus == kTransactionLocationStatusNotFound)
////        {
////            NSIndexPath *locatingIndexPath = [NSIndexPath indexPathForRow:1 inSection:1];
////            return [super tableView:tableView heightForRowAtIndexPath:locatingIndexPath];
////        }
////    }
//    
//    return [super tableView:tableView heightForRowAtIndexPath:indexPath];
//}

//- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
//{
//    NSInteger locationStatus = [[change objectForKey:@"new"] integerValue];
//    NSLog(@"New location status:%d", locationStatus);
////    [self mapStatusChanged];
//}


#pragma mark - Private methods

- (void)updateViewInfo
{
    self.lentDescriptionLabel.text = ([transaction lentValue] == YES) ? NSLocalizedString(@"Lent", nil) : NSLocalizedString(@"Borrowed", nil);
    self.lentPrepositionLabel.text =  ([transaction lentValue] == YES) ? NSLocalizedString(@"To", nil) : NSLocalizedString(@"From", nil);
    
    self.amountLabel.text = [transaction.absoluteAmount stringValue];
    self.friendLabel.text = [transaction friendFullName];
    self.categoryLabel.text = [transaction categoryName];
    self.noteLabel.text = transaction.note;
    
    // Display date
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    [dateFormatter setTimeStyle:NSDateFormatterShortStyle];
    
    NSString *formattedDateString = [dateFormatter stringFromDate:transaction.createdAt];
    self.timeStampLabel.text = formattedDateString;
    
    [self showLocationInfo];
}

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
    if (self.transaction.location != nil)
    {
        MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance([transaction coordinate], kMapViewLocationDistance, kMapViewLocationDistance);
        [self.mapView setRegion:region animated:NO];
        
        [self.mapView addAnnotation:transaction];
    }
}

//- (void)mapStatusChanged
//{
//    NSLog(@"%s", (char *)_cmd);
//    NSInteger rows = [super tableView:self.tableView numberOfRowsInSection:0];
//    NSIndexPath *targetIndexPath = [NSIndexPath indexPathForRow:(rows - 1) inSection:0];
//    
//    NSArray *indexPaths = [NSArray arrayWithObject:targetIndexPath];
//    [self.tableView reloadRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationAutomatic];
//}

@end
