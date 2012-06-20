//
//  FriendViewController.m
//  FriendlyLoan
//
//  Created by Christian Rasmussen on 13.06.12.
//  Copyright (c) 2012 Rasmussen I/O. All rights reserved.
//

#import "FriendViewController.h"
#import "FriendViewControllerDelegate.h"
#import "ABContactsHelper.h"


@implementation FriendViewController {
    NSArray *_contacts;
}

@synthesize delegate;
@synthesize selectedFriendID;


#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    _contacts = [ABContactsHelper contacts];
    
    NSLog(@"%@", _contacts);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"FriendCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    [self configureCell:cell atIndexPath:indexPath];
    
    return cell;
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    NSNumber *categoryID = nil;
//    if (indexPath.section == kUnknownCategoryCellSection) {
//        categoryID = self.selectedCategoryID;
//    }
//    else {
//        categoryID = [[CategoryList categoryIDs] objectAtIndex:indexPath.row];
//    }
//    
//    self.selectedCategoryID = categoryID;
//    
//    // Move checkmark to new row
//    UITableViewCell *oldSelectedCell = [tableView cellForRowAtIndexPath:_selectedIndexPath];
//    oldSelectedCell.accessoryType = UITableViewCellAccessoryNone;
//    UITableViewCell *newSelectedCell = [tableView cellForRowAtIndexPath:indexPath];
//    newSelectedCell.accessoryType = UITableViewCellAccessoryCheckmark;
//    _selectedIndexPath = indexPath;
    
    // TODO: Fix this
    if ([self.delegate respondsToSelector:@selector(friendViewController:didSelectFriendID:)]) {
        [self.delegate friendViewController:self didSelectFriendID:nil];
    }
}


#pragma mark - Private methods

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
//    NSNumber *categoryID = nil;
//    BOOL isSelected;
//    if (indexPath.section == kUnknownCategoryCellSection) {
//        categoryID = self.selectedCategoryID;
//        isSelected = YES;
//    }
//    else {
//        categoryID =[[CategoryList categoryIDs] objectAtIndex:indexPath.row];
//        isSelected = [categoryID isEqualToNumber:self.selectedCategoryID];
//    }
//    
//    UIImage *image = [CategoryList imageForCategoryID:categoryID];
//    UIImage *highlightedImage = [CategoryList highlightedImageForCategoryID:categoryID];
//    
//    cell.textLabel.text = [CategoryList nameForCategoryID:categoryID];
//    cell.imageView.image = image;
//    cell.imageView.highlightedImage = highlightedImage;
//    cell.accessoryType = (isSelected == YES) ? UITableViewCellAccessoryCheckmark : UITableViewCellAccessoryNone;
//    
//    if (isSelected == YES) {
//        _selectedIndexPath = indexPath;
//    }
    cell.textLabel.text = @"Test";
}

@end
