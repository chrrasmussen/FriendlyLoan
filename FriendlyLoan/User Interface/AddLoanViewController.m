//
//  AddLoanViewController.m
//  FriendlyLoan
//
//  Created by Christian Rasmussen on 09.09.11.
//  Copyright (c) 2011 Rasmussen I/O. All rights reserved.
//

#import "AddLoanViewController.h"
#import <CoreLocation/CoreLocation.h>

#import "LoanManager.h"
#import "BackendManager.h"

#import "DetailsViewController.h"
#import "CategoriesViewController.h"


@implementation AddLoanViewController

@synthesize borrowBarButtonItem, lendBarButtonItem, attachLocationSwitch, shareLoanSwitch;


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
    
    [[LoanManager sharedManager] addObserver:self forKeyPath:@"calculatedAttachLocationValue" options:(NSKeyValueObservingOptionInitial | NSKeyValueObservingOptionNew) context:NULL];
    [[LoanManager sharedManager] addObserver:self forKeyPath:@"calculatedShareLoanValue" options:(NSKeyValueObservingOptionInitial | NSKeyValueObservingOptionNew) context:NULL];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    
    [[LoanManager sharedManager] removeObserver:self];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    // Avoid the keyboard to be active when application is started
    // Hide keyboard in order to avoid it becoming first responder when the view appears
    [self hideKeyboard];
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


#pragma mark - Override methods

- (void)setSaveButtonsEnabledState:(BOOL)enabled
{
    self.borrowBarButtonItem.enabled = enabled;
    self.lendBarButtonItem.enabled = enabled;
}

- (void)updateLoanBasedOnViewInfo:(Loan *)theLoan
{
    [super updateLoanBasedOnViewInfo:theLoan];
    
    theLoan.attachLocationValue = [[LoanManager sharedManager] calculatedAttachLocationValue];
}

- (void)resetFields
{
    [super resetFields];
}


#pragma mark - Managing the hierarchy

- (void)popToBlankViewControllerAnimated:(BOOL)animated
{
    [self.navigationController popToRootViewControllerAnimated:animated];
    [self resetFields];
}


#pragma mark - Actions

- (IBAction)textFieldDidBeginEditing:(id)sender
{
}

- (IBAction)borrow:(id)sender
{
    self.lentStatus = NO;
    
    [self performSegueWithIdentifier:@"SaveSegue" sender:sender];
}

- (IBAction)lend:(id)sender
{
    self.lentStatus = YES;
    
    [self performSegueWithIdentifier:@"SaveSegue" sender:sender];
}

- (IBAction)changeAttachLocationValue:(UISwitch *)sender
{
    [[LoanManager sharedManager] setAttachLocationValue:sender.on];
}

- (IBAction)changeShareLoanValue:(UISwitch *)sender
{
    [[LoanManager sharedManager] setShareLoanValue:sender.on];
}

- (IBAction)detailsViewControllerAdd:(id)sender
{
    [self popToBlankViewControllerAnimated:YES];
}

#pragma mark - Storyboard methods

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    [super prepareForSegue:segue sender:sender];
    
    if ([[segue identifier] isEqualToString:@"SaveSegue"])
    {
        // Add loan
        Loan *loan = [self addLoan];
        
        // Set up details view controller
        DetailsViewController *detailsViewController = [segue destinationViewController];
        [self configureDetailsViewController:detailsViewController];
        detailsViewController.loan = loan;
        
//        // Hide keyboard in order to avoid it becoming first responder when the view appears
//        [self hideKeyboard];
    }
}


#pragma mark - LoanManagerAttachLocationDelegate methods

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"calculatedAttachLocationValue"]) {
        BOOL attachLocation = [[change objectForKey:@"new"] boolValue];
        [self.attachLocationSwitch setOn:attachLocation animated:YES];
    }
    else if ([keyPath isEqualToString:@"calculatedShareLoanValue"]) {
        BOOL shareLoan = [[change objectForKey:@"new"] boolValue];
        [self.shareLoanSwitch setOn:shareLoan animated:YES];
    }
}


#pragma mark - Private methods

- (Loan *)addLoan
{
    Loan *result = [[LoanManager sharedManager] addLoanWithUpdateHandler:^(Loan *loan) {
        [self updateLoanBasedOnViewInfo:loan];
    }];
    
    if (self.shareLoanSwitch.on) {
        [[BackendManager sharedManager] shareLoanInBackground:result];
    }
    
    return result;
}

- (void)configureDetailsViewController:(DetailsViewController *)detailsViewController
{
    detailsViewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(detailsViewControllerAdd:)];
    detailsViewController.navigationItem.rightBarButtonItem = nil;
}

@end
