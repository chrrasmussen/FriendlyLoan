//
//  SettingsViewController.m
//  FriendlyLoan
//
//  Created by Christian Rasmussen on 01.05.12.
//  Copyright (c) 2012 Rasmussen I/O. All rights reserved.
//

#import "SettingsViewController.h"

@interface SettingsViewController ()

@end

@implementation SettingsViewController

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

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
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

- (IBAction)logIn:(id)sender
{
    // The permissions requested from the user
    NSArray *permissionsArray = [NSArray arrayWithObjects:@"email", @"offline_access", nil];
    
    // Log in
    [PFFacebookUtils logInWithPermissions:permissionsArray block:^(PFUser *user, NSError *error) {
        if (!user) {
            if (!error) { // The user cancelled the login
                NSLog(@"Uh oh. The user cancelled the Facebook login.");
            } else { // An error occurred
                NSLog(@"Uh oh. An error occurred: %@", error);
            }
        } else if (user.isNew) { // Success - a new user was created
            NSLog(@"User with facebook signed up and logged in!");
            // [self.navigationController pushViewController:[[UserDetailsViewController alloc] initWithStyle:UITableViewStyleGrouped] animated:YES];
        } else { // Success - an existing user logged in
            NSLog(@"User with facebook logged in!");
            // [self.navigationController pushViewController:[[UserDetailsViewController alloc] initWithStyle:UITableViewStyleGrouped] animated:YES];
            NSString *requestPath = @"me/?fields=name,gender,picture,email";
            
            // Send request to facebook
            [[PFFacebookUtils facebook] requestWithGraphPath:requestPath andDelegate:self];
        }
    }];
}

- (void)request:(PF_FBRequest *)request didLoad:(id)result
{
    NSDictionary *userData = (NSDictionary *)result;
    
    NSString *identifier = [userData objectForKey:@"id"];
    NSString *name = [userData objectForKey:@"name"];
    NSString *gender = [userData objectForKey:@"gender"];
    NSString *email = [userData objectForKey:@"email"];
    
    NSLog(@"%@, %@, %@, %@", identifier, name, email, gender);
}

- (void)request:(PF_FBRequest *)request didFailWithError:(NSError *)error
{
    // OAuthException means our session is invalid
    if ([[[[error userInfo] objectForKey:@"error"] objectForKey:@"type"] isEqualToString: @"OAuthException"]) {
        NSLog(@"The facebook token was invalidated");
        [PFUser logOut];
    } else {
        NSLog(@"Some other error");
    }
}

//#pragma mark - Table view data source
//
//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
//{
//    // Return the number of sections.
//    return 0;
//}
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
//{
//    // Return the number of rows in the section.
//    return 0;
//}
//
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    static NSString *CellIdentifier = @"Cell";
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
//    
//    // Configure the cell...
//    
//    return cell;
//}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    [self logIn:cell];
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

@end
