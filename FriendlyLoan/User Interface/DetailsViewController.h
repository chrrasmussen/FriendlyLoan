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


@protocol FLLoan;

@interface DetailsViewController : UITableViewController <MKMapViewDelegate, EditLoanViewControllerDelegate>

@property (nonatomic, strong) id<FLLoan> loan;

@property (nonatomic, strong) IBOutlet UIImageView *friendImageView;
@property (nonatomic, strong) IBOutlet UILabel *titleLabel;
@property (nonatomic, strong) IBOutlet UILabel *categoryLabel;
@property (nonatomic, strong) IBOutlet UILabel *noteLabel;
@property (nonatomic, strong) IBOutlet UILabel *timeStampLabel;

@property (nonatomic, strong) IBOutlet UIImageView *categoryImageView;

@end
