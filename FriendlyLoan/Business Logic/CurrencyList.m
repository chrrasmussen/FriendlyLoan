//
//  CurrencyList.m
//  FriendlyLoan
//
//  Created by Christian Rasmussen on 11.05.12.
//  Copyright (c) 2012 Rasmussen I/O. All rights reserved.
//

#import "CurrencyList.h"


@implementation CurrencyList

static NSDictionary *_currencies;
static NSDictionary *_currenciesByCurrencyCode;
static NSArray *_currencyCodes;


#pragma mark - Get all currencies

+ (NSDictionary *)currencies
{
    if (_currencies == nil) {
        NSURL *currenciesURL = [[NSBundle mainBundle] URLForResource:@"CurrencyList" withExtension:@"plist"];
        NSDictionary *currencyList = [[NSDictionary alloc] initWithContentsOfURL:currenciesURL];
        _currencies = currencyList[@"currencies"];
    }
    
    return _currencies;
}

+ (NSDictionary *)currenciesByCurrencyCode
{
    if (_currenciesByCurrencyCode == nil) {
        NSMutableDictionary *currenciesByCurrencyCode = [[NSMutableDictionary alloc] init];
        
        for (NSDictionary *currency in [self currencies]) {
            NSString *currencyCode = currency[@"currencyCode"];
            [currenciesByCurrencyCode setValue:currency forKey:currencyCode];
        }
        
        _currenciesByCurrencyCode = [currenciesByCurrencyCode copy];
    }
    
    return _currenciesByCurrencyCode;
}

+ (NSArray *)currencyCodes
{
    if (_currencyCodes == nil) {
        NSMutableArray *currencyCodes = [[NSMutableArray alloc] init];
        
        for (NSDictionary *currency in [self currencies]) {
            NSString *currencyCode = currency[@"currencyCode"];
            [currencyCodes addObject:currencyCode];
        }
        
        _currencyCodes = [currencyCodes copy];
    }
    
    return _currencyCodes;
}

#pragma mark - Get currency

+ (NSString *)currentCurrencyCode
{
    // TODO: Read from NSUserDefaults
    return @"USD";
}

+ (NSNumberFormatter *)currencyFormatterForCurrencyCode:(NSString *)currencyCode
{
//    static NSNumberFormatter *numberFormatter = nil;
//    if (numberFormatter == nil) {
        NSString *currencySymbol = [[self class] currencySymbolForCurrencyCode:currencyCode];
        NSLocale *locale = [[self class] localeForCurrencyCode:currencyCode];
        
        NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
        [numberFormatter setNumberStyle:NSNumberFormatterCurrencyStyle];
        [numberFormatter setCurrencyCode:currencyCode];
        [numberFormatter setCurrencySymbol:currencySymbol];
        [numberFormatter setLocale:locale];
        [numberFormatter setMaximumFractionDigits:0];
//    }
    
    return numberFormatter;
}

+ (NSNumberFormatter *)currentCurrencyFormatter
{
    NSString *currencyCode = [[self class] currentCurrencyCode];
    return [[self class] currencyFormatterForCurrencyCode:currencyCode];
}


#pragma mark - Private methods

+ (NSString *)currencySymbolForCurrencyCode:(NSString *)currencyCode
{
    return [self currenciesByCurrencyCode][currencyCode][@"currencySymbol"];
}

+ (NSString *)localeIdentifierForCurrencyCode:(NSString *)currencyCode
{
    return [self currenciesByCurrencyCode][currencyCode][@"localeIdentifier"];;
}

+ (NSLocale *)localeForCurrencyCode:(NSString *)currencyCode
{
    NSString * localeIdentifier = [[self class] localeIdentifierForCurrencyCode:currencyCode];
    return [[NSLocale alloc] initWithLocaleIdentifier:localeIdentifier];
}

@end
