//
//  CurrencyList.h
//  FriendlyLoan
//
//  Created by Christian Rasmussen on 11.05.12.
//  Copyright (c) 2012 Rasmussen I/O. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface CurrencyList : NSObject


+ (NSString *)currentCurrencyCode;
+ (NSNumberFormatter *)currencyFormatterForCurrencyCode:(NSString *)currencyCode;
+ (NSNumberFormatter *)currentCurrencyFormatter;

@end
