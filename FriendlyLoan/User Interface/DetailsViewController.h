//
//  DetailsViewController.h
//  FriendlyLoan
//
//  Created by Christian Rasmussen on 09.09.11.
//  Copyright (c) 2011 Rasmussen I/O. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

#import "EditLoanViewControllerDelegate.h"


@class Loan;

@interface DetailsViewController : UITableViewController <MKMapViewDelegate, EditLoanViewControllerDelegate>

@property (nonatomic, strong) Loan *transaction;

@property (nonatomic, strong) IBOutlet UILabel *lentDescriptionLabel;
@property (nonatomic, strong) IBOutlet UILabel *lentPrepositionLabel;
@property (nonatomic, strong) IBOutlet UILabel *amountLabel;
@property (nonatomic, strong) IBOutlet UILabel *friendLabel;
@property (nonatomic, strong) IBOutlet UILabel *categoryLabel;
@property (nonatomic, strong) IBOutlet UILabel *noteLabel;
@property (nonatomic, strong) IBOutlet UILabel *timeStampLabel;
@property (strong, nonatomic) IBOutlet MKMapView *mapView;

@end
