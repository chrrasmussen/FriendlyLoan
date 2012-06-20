//
//  CategoryViewController.m
//  FriendlyLoan
//
//  Created by Christian Rasmussen on 11.09.11.
//  Copyright (c) 2011 Rasmussen I/O. All rights reserved.
//

#import "CategoryViewController.h"
#import "CategoryViewControllerDelegate.h"

#import "CategoryList.h"


const NSInteger kUnknownCategoryCellSection = 1;


@implementation CategoryViewController {
    NSIndexPath *_selectedIndexPath;
}

@synthesize delegate;
@synthesize selectedCategoryID;


#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
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
    if ([self isUnknownSelectedCategoryID] == YES) {
        return 2;
    }
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == kUnknownCategoryCellSection) {
        return 1;
    }
    
    return [[CategoryList categoryIDs] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"CategoryCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    [self configureCell:cell atIndexPath:indexPath];
    
    return cell;
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSNumber *categoryID = nil;
    if (indexPath.section == kUnknownCategoryCellSection) {
        categoryID = self.selectedCategoryID;
    }
    else {
        categoryID = [[CategoryList categoryIDs] objectAtIndex:indexPath.row];
    }
    
    self.selectedCategoryID = categoryID;
    
    // Move checkmark to new row
    UITableViewCell *oldSelectedCell = [tableView cellForRowAtIndexPath:_selectedIndexPath];
    oldSelectedCell.accessoryType = UITableViewCellAccessoryNone;
    UITableViewCell *newSelectedCell = [tableView cellForRowAtIndexPath:indexPath];
    newSelectedCell.accessoryType = UITableViewCellAccessoryCheckmark;
    _selectedIndexPath = indexPath;
    
    if ([self.delegate respondsToSelector:@selector(categoryViewController:didSelectCategoryID:)]) {
        [self.delegate categoryViewController:self didSelectCategoryID:categoryID];
    }
}


#pragma mark - Private methods

// TODO: Caching problem with UIImageView?
- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
    NSNumber *categoryID = nil;
    BOOL isSelected;
    if (indexPath.section == kUnknownCategoryCellSection) {
        categoryID = self.selectedCategoryID;
        isSelected = YES;
    }
    else {
        categoryID =[[CategoryList categoryIDs] objectAtIndex:indexPath.row];
        isSelected = [categoryID isEqualToNumber:self.selectedCategoryID];
    }
    
    UIImage *image = [CategoryList imageForCategoryID:categoryID];
    UIImage *highlightedImage = [CategoryList highlightedImageForCategoryID:categoryID];
    
    cell.textLabel.text = [CategoryList nameForCategoryID:categoryID];
    cell.imageView.image = image;
    cell.imageView.highlightedImage = highlightedImage;
    cell.accessoryType = (isSelected == YES) ? UITableViewCellAccessoryCheckmark : UITableViewCellAccessoryNone;
    
    if (isSelected == YES) {
        _selectedIndexPath = indexPath;
    }
}

- (BOOL)isUnknownSelectedCategoryID
{
    return ([[CategoryList categoryIDs] containsObject:self.selectedCategoryID] == NO);
}

@end
