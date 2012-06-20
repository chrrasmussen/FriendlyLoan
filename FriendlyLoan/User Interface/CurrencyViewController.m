//
//  CurrencyViewController.m
//  FriendlyLoan
//
//  Created by Christian Rasmussen on 12.05.12.
//  Copyright (c) 2012 Rasmussen I/O. All rights reserved.
//

#import "CurrencyViewController.h"


@implementation CurrencyViewController

- (NSArray *)tableViewRows
{
//    NSURL *currencyURL = [[NSBundle mainBundle] URLForResource:@"CurrencyList" withExtension:@"plist"];
//    NSDictionary *currencyDict = [[NSDictionary alloc] initWithContentsOfURL:currencyURL];
//    
//    return [currencyDict objectForKey:@"categories"];
    return @[ @"Test" ];
}

- (NSString *)tableViewPrototypeCellIdentifier
{
    return @"CurrencyCell";
}

- (BOOL)tableView:(UITableView *)tableView isSelectedRowWithRowData:(id)rowData
{
    return NO;
}

- (void)tableView:(UITableView *)tableView configureCell:(UITableViewCell *)cell withRowData:(id)rowData
{
    cell.textLabel.text = @"Yay";
}

- (void)tableView:(UITableView *)tableView didSelectRowWithRowData:(id)rowData
{
    NSLog(@"%@ %@", NSStringFromSelector(_cmd), rowData);
}

@end
