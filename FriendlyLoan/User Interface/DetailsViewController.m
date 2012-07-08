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

#import "LocationViewController.h"
#import "EditLoanViewController.h"


const int kNoteTableViewCellIndex = 2;


@implementation DetailsViewController {
    BOOL _loanIsDeleted;
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
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    if (_loanIsDeleted == NO) {
        [self updateViewInfo];
    }
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
//    [self.loan addObserver:self forKeyPath:@"locationStatus" options:NSKeyValueObservingOptionNew context:NULL];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
//    [self.loan removeObserver:self forKeyPath:@"locationStatus"];
}


#pragma mark - Storyboard

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"EditSegue"])
    {
        UINavigationController *navigationController = [segue destinationViewController];
        EditLoanViewController *editLoanViewController = (EditLoanViewController *)navigationController.topViewController;
        editLoanViewController.delegate = self;
        editLoanViewController.loan = self.loan;
    }
    else if ([segue.identifier isEqualToString:@"LocationSegue"]) {
        LocationViewController *locationViewController = [segue destinationViewController];
        locationViewController.locationCoordinate = [self.loan coordinate];
    }
}


#pragma mark - EditLoanViewControllerDelegate methods

- (void)editLoanViewControllerDidCancel:(EditLoanViewController *)editLoanViewController
{
    [self dismissViewControllerAnimated:YES completion:NULL];
}

- (void)editLoanViewControllerDidSave:(EditLoanViewController *)editLoanViewController
{
    [self dismissViewControllerAnimated:YES completion:NULL];
}

- (void)editLoanViewControllerDidDeleteLoan:(EditLoanViewController *)editLoanViewController
{
    _loanIsDeleted = YES;
    [self dismissViewControllerAnimated:YES completion:^{
        [self.navigationController popViewControllerAnimated:YES];
    }];
}


#pragma mark - UITableViewDelegate methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger rows = [super tableView:tableView numberOfRowsInSection:section];
    rows -= ([self.loan.note length] == 0) ? 1 : 0;
    rows -= ([self.loan hasLocation] == NO) ? 1 : 0;
    
    return rows;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == kNoteTableViewCellIndex && [self.loan.note length] == 0) {
        indexPath = [NSIndexPath indexPathForRow:(indexPath.row + 1) inSection:indexPath.section];
    }
    
    return [super tableView:tableView cellForRowAtIndexPath:indexPath];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == kNoteTableViewCellIndex && [self.loan.note length] == 0) {
        indexPath = [NSIndexPath indexPathForRow:(indexPath.row + 1) inSection:indexPath.section];
    }
    
    return [super tableView:tableView heightForRowAtIndexPath:indexPath];
}

//- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
//{
//    NSInteger locationStatus = [[change objectForKey:@"new"] integerValue];
//    NSLog(@"New location status:%d", locationStatus);
////    [self mapStatusChanged];
//}


#pragma mark - Private methods

- (void)updateViewInfo
{
    NSString *amountText = [self.loan amountPresentation];
    NSString *friendText = [self.loan friendFullName];
    
    BOOL settled = [self.loan settledValue];
    BOOL lent = [self.loan lentValue];
    
    NSString *format = nil;
    if (settled == NO) {
        if (lent == YES) {
            format = NSLocalizedString(@"Lent %1$@ to %2$@", @"Outgoing loans in History-tab");
        }
        else {
            format = NSLocalizedString(@"Borrowed %1$@ from %2$@", @"Incoming loans in History-tab");
        }
    }
    else {
        if (lent == YES) {
            format = NSLocalizedString(@"Paid back %1$@ to %2$@", @"Settled incoming loans in History-tab");
        }
        else {
            format = NSLocalizedString(@"Got back %1$@ from %2$@", @"Settled outgoing loans in History-tab");
        }
    }
    
    self.titleLabel.text = [NSString stringWithFormat:format, amountText, friendText];
    
    self.categoryLabel.text = [self.loan categoryName];
    self.categoryImageView.image = [self.loan categoryImage];
    
    self.noteLabel.text = self.loan.note;
    
    // Display date
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    [dateFormatter setTimeStyle:NSDateFormatterShortStyle];
    
    NSString *formattedDateString = [dateFormatter stringFromDate:self.loan.createdAt];
    self.timeStampLabel.text = formattedDateString;
    
    [self.tableView reloadData];
}

@end
