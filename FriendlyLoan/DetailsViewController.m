//
//  DetailsViewController.m
//  FriendlyLoan
//
//  Created by Christian Rasmussen on 09.09.11.
//  Copyright (c) 2011 Rasmussen I/O. All rights reserved.
//

#import "DetailsViewController.h"

#import "Models.h"
#import "EditLoanViewController.h"


@interface DetailsViewController ()

- (void)updateViewInfo;

@end


@implementation DetailsViewController

@synthesize transaction;
@synthesize amountLabel, personLabel, categoryLabel, noteLabel, timeStampLabel, locationlabel;

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

#pragma mark - Core Data stack

- (NSManagedObjectContext *)managedObjectContext
{
    id appDelegate = [[UIApplication sharedApplication] delegate];
    return [appDelegate managedObjectContext];
}

#pragma mark - EditLoanViewControllerDelegate methods

- (void)editLoanViewControllerDidSave:(EditLoanViewController *)editLoanViewController
{
    [self updateViewInfo];
}

#pragma mark - Private methods

- (void)updateViewInfo
{
    self.amountLabel.text = [transaction.amount stringValue];
    self.personLabel.text = transaction.personName;
    self.categoryLabel.text = [transaction.categoryID stringValue];
    self.noteLabel.text = transaction.note;
    self.timeStampLabel.text = [transaction.createdTimeStamp description];
    self.locationlabel.text = transaction.location;
}

@end
