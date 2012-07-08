//
//  RIOPropertyListViewController.m
//  FriendlyLoan
//
//  Created by Christian Rasmussen on 12.05.12.
//  Copyright (c) 2012 Rasmussen I/O. All rights reserved.
//

#import "RIOPropertyListViewController.h"


@implementation RIOPropertyListViewController {
    NSIndexPath *_selectedIndexPath;
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
    NSArray *rows = [self tableViewRows];
    return [rows count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellIdentifier = [self tableViewPrototypeCellIdentifier];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    id rowData = [self rowDataForIndexPath:indexPath];
    
    // Configure cell
    [self tableView:tableView configureCell:cell withRowData:rowData];
    
    // Determine selection
    if ([self tableView:tableView isSelectedRowWithRowData:rowData]) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    else {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    return cell;
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    id rowData = [self rowDataForIndexPath:indexPath];
    [self tableView:tableView didSelectRowWithRowData:rowData];
}


#pragma mark - Private methods

- (id)rowDataForIndexPath:(NSIndexPath *)indexPath
{
    return [self tableViewRows][indexPath.row];
}


#pragma mark - Abstract methods

- (NSArray *)tableViewRows
{
    return nil;
}

- (NSString *)tableViewPrototypeCellIdentifier
{
    return nil;
}

- (BOOL)tableView:(UITableView *)tableView isSelectedRowWithRowData:(id)rowData
{
    return NO;
}

- (void)tableView:(UITableView *)tableView configureCell:(UITableViewCell *)cell withRowData:(id)rowData
{
    
}

- (void)tableView:(UITableView *)tableView didSelectRowWithRowData:(id)rowData
{
    
}

@end
