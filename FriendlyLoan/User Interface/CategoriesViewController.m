//
//  CategoriesViewController.m
//  FriendlyLoan
//
//  Created by Christian Rasmussen on 11.09.11.
//  Copyright (c) 2011 Rasmussen I/O. All rights reserved.
//

#import "CategoriesViewController.h"
#import "CategoriesViewControllerDelegate.h"

#import "Category.h"


const NSInteger kUnknownCategoryCellSection = 1;


@implementation CategoriesViewController {
    NSIndexPath *_selectedIndexPath;
}

@synthesize delegate;
@synthesize selectedCategoryID;

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

- (void)viewDidUnload
{
    [super viewDidUnload];
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


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if ([self isUnknownSelectedCategoryID] == YES)
        return 2;
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == kUnknownCategoryCellSection)
        return 1;
    
    return [Category numberOfCategories];
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
    NSNumber *categoryID;
    if (indexPath.section == kUnknownCategoryCellSection)
        categoryID = self.selectedCategoryID;
    else
        categoryID = [[Category categoryForIndex:indexPath.row] categoryID];
    
    self.selectedCategoryID = categoryID;
    
    // Move checkmark to new row
    UITableViewCell *oldSelectedCell = [tableView cellForRowAtIndexPath:_selectedIndexPath];
    oldSelectedCell.accessoryType = UITableViewCellAccessoryNone;
    UITableViewCell *newSelectedCell = [tableView cellForRowAtIndexPath:indexPath];
    newSelectedCell.accessoryType = UITableViewCellAccessoryCheckmark;
    _selectedIndexPath = indexPath;
    
    if ([self.delegate respondsToSelector:@selector(categoriesViewController:didSelectCategoryID:)])
        [self.delegate categoriesViewController:self didSelectCategoryID:categoryID];
}


#pragma mark - Private methods

// TODO: Caching problem with UIImageView?
- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
    Category *category;
    BOOL isSelected;
    if (indexPath.section == kUnknownCategoryCellSection)
    {
        category = [Category unknownCategory];
        isSelected = YES;
    }
    else
    {
        category = [Category categoryForIndex:indexPath.row];
        isSelected = [[category categoryID] isEqualToNumber:self.selectedCategoryID];
    }
    
    UIImage *image = [UIImage imageNamed:category.imageName];
    UIImage *highlightedImage = [UIImage imageNamed:category.highlightedImageName];
    
    cell.textLabel.text = category.categoryName;
    cell.imageView.image = image;
    cell.imageView.highlightedImage = highlightedImage;
    cell.accessoryType = (isSelected == YES) ? UITableViewCellAccessoryCheckmark : UITableViewCellAccessoryNone;
    
    if (isSelected == YES)
        _selectedIndexPath = indexPath;
}

- (BOOL)isUnknownSelectedCategoryID
{
    return ([Category categoryForCategoryID:self.selectedCategoryID] == nil);
}

@end
