//
//  SettingsViewController.m
//  FriendlyLoan
//
//  Created by Christian Rasmussen on 01.05.12.
//  Copyright (c) 2012 Rasmussen I/O. All rights reserved.
//

#import "SettingsViewController.h"
#import "BackendManager.h"


const NSInteger kShareLoansSection = 0;


@implementation SettingsViewController {
    BOOL _loggingIn;
}

@synthesize logInTableViewCell;
@synthesize inviteFriendsTableViewCell;
@synthesize manageFriendsTableViewCell;
@synthesize logOutTableViewCell;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setUpNotificationObservers];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        NSInteger loginRows = 1;
        return ([self shouldDisplayLogInSection] == YES) ? loginRows : [super tableView:tableView numberOfRowsInSection:section] - loginRows;
    }
    
    return [super tableView:tableView numberOfRowsInSection:section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == kShareLoansSection) {
        NSInteger row = ([self shouldDisplayLogInSection] == YES) ? 0 : indexPath.row + 1;
        indexPath = [NSIndexPath indexPathForRow:row inSection:indexPath.section];
    }
    
    UITableViewCell *cell = [super tableView:tableView cellForRowAtIndexPath:indexPath];
    return cell;
}

// TODO: Update user
- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
{
    if (section == kShareLoansSection) {
        if ([self shouldDisplayLogInSection] == NO) {
            NSString *format = NSLocalizedString(@"Logged in as: %@", @"Text in footer of Share Loans-section in Settings-tab");
            NSString *fullName = [[BackendManager sharedManager] userFullName];
            return [NSString stringWithFormat:format, fullName];
        }
        else {
            return nil;
        }
    }
    
    return [super tableView:tableView titleForFooterInSection:section];
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (cell == self.logInTableViewCell) {
        [[BackendManager sharedManager] logIn];
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
    }
    else if (cell == self.logOutTableViewCell) {
        [[BackendManager sharedManager] logOut];
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
    }
}

- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_loggingIn == YES) {
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        if (cell == self.logInTableViewCell) {
            return nil;
        }
    }
    
    return indexPath;
}


#pragma mark - Private methods

- (void)setUpNotificationObservers
{
    typeof(self) bself = self;
    
    [[NSNotificationCenter defaultCenter] addObserverForName:FLUserWillLogInNotification object:nil queue:nil usingBlock:^(NSNotification *note) {
        [bself startLogIn];
    }];
    
    [[NSNotificationCenter defaultCenter] addObserverForName:FLUserDidLogInNotification object:nil queue:nil usingBlock:^(NSNotification *note) {
        [bself endLogIn];
        [bself updateShareLoansSectionWithLogInAnimation:YES];
    }];
    
    [[NSNotificationCenter defaultCenter] addObserverForName:FLUserFailedToLogInNotification object:nil queue:nil usingBlock:^(NSNotification *note) {
        [bself endLogIn];
        
        NSError *error = [note.userInfo objectForKey:@"error"];
        if (error) {
            NSString *title = NSLocalizedString(@"Failed to Log In", @"Title of alert when failed to log in");
            NSString *message = NSLocalizedString(@"Please enter the correct username and password.", @"Message of alert when failed to log in");
            NSString *cancel = NSLocalizedString(@"Close", @"Title of cancel button in alert when failed to log in");
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:message delegate:nil cancelButtonTitle:cancel otherButtonTitles:nil];
            [alert show];
        }
    }];
    
    [[NSNotificationCenter defaultCenter] addObserverForName:FLUserWillLogOutNotification object:nil queue:nil usingBlock:^(NSNotification *note) {
        
    }];
    
    [[NSNotificationCenter defaultCenter] addObserverForName:FLUserDidLogOutNotification object:nil queue:nil usingBlock:^(NSNotification *note) {
        [bself updateShareLoansSectionWithLogInAnimation:NO];
    }];
}

- (BOOL)shouldDisplayLogInSection
{
    return ([[BackendManager sharedManager] isLoggedIn] == NO);
}

- (void)startLogIn
{
    UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    [indicator startAnimating];
    self.logInTableViewCell.accessoryView = indicator;
    self.logInTableViewCell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    _loggingIn = YES;
}

- (void)endLogIn
{
    _loggingIn = NO;
    
    self.logInTableViewCell.accessoryView = nil;
    self.logInTableViewCell.selectionStyle = UITableViewCellSelectionStyleBlue;
}

- (void)updateShareLoansSectionWithLogInAnimation:(BOOL)logIn
{
    NSArray *logInIndexPaths = [NSArray arrayWithObject:[NSIndexPath indexPathForRow:0 inSection:kShareLoansSection]];
    NSArray *logOutIndexPaths = [NSArray arrayWithObjects:[NSIndexPath indexPathForRow:0 inSection:kShareLoansSection],
                                 [NSIndexPath indexPathForRow:1 inSection:kShareLoansSection],
                                 [NSIndexPath indexPathForRow:2 inSection:kShareLoansSection], nil];
    
    NSArray *deletions;
    NSArray *insertions;
    if (logIn) {
        deletions = logInIndexPaths;
        insertions = logOutIndexPaths;
    }
    else {
        deletions = logOutIndexPaths;
        insertions = logInIndexPaths;
    }
    
    [self.tableView beginUpdates];
    [self.tableView deleteRowsAtIndexPaths:deletions withRowAnimation:UITableViewRowAnimationAutomatic];
    [self.tableView insertRowsAtIndexPaths:insertions withRowAnimation:UITableViewRowAnimationAutomatic];
    [self.tableView endUpdates];
    
    [self.tableView reloadData];
}

@end
