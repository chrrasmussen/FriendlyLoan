//
//  CurrencyViewControllerDelegate.h
//  FriendlyLoan
//
//  Created by Christian Rasmussen on 12.05.12.
//  Copyright (c) 2012 Rasmussen I/O. All rights reserved.
//

#import <Foundation/Foundation.h>


@class CurrencyViewController;


@protocol CurrencyViewControllerDelegate <NSObject>

- (void)currencyViewController:(CurrencyViewController *)currencyViewController didSelectCurrencyCode:(NSString *)currencyCode;

@end
