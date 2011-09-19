//
//  AddLoanViewController.m
//  FriendlyLoan
//
//  Created by Christian Rasmussen on 09.09.11.
//  Copyright (c) 2011 Rasmussen I/O. All rights reserved.
//

#import "AddLoanViewController.h"

#import "DetailsViewController.h"
#import "CategoriesViewController.h"
#import "Models.h"


@interface AddLoanViewController ()

- (Transaction *)addTransaction;

- (void)detailsViewControllerAdd:(id)sender;
- (void)popToBlankViewControllerAnimated:(BOOL)animated;

@end


@implementation AddLoanViewController

@synthesize borrowBarButtonItem, lendBarButtonItem;

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

#pragma mark - Storyboard

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

#pragma mark - DetailsViewControllerDelegate methods

- (void)detailsViewControllerDidDisappear:(DetailsViewController *)detailsViewController
{
    [self popToBlankViewControllerAnimated:NO];
}

#pragma mark - Private methods

- (Transaction *)addTransaction
{
    Transaction *transaction = [NSEntityDescription insertNewObjectForEntityForName:@"Transaction" inManagedObjectContext:self.managedObjectContext];
    
    [self updateTransaction:transaction];
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
