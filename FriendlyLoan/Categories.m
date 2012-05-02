//
//  Categories.m
//  FriendlyLoan
//
//  Created by Christian Rasmussen on 26.09.11.
//  Copyright (c) 2011 Rasmussen I/O. All rights reserved.
//

#import "Categories.h"

@interface Categories ()

+ (NSArray *)categories;
+ (NSDictionary *)categoriesByID;
+ (NSDictionary *)objectForCategoryID:(NSNumber *)categoryID;

@end

@implementation Categories

static NSArray *_categories;
static NSDictionary *_categoriesByID;
static NSArray *_categoryIDs;

+ (NSArray *)categoryIDs
{
    if (_categoryIDs == nil)
    {
        NSMutableArray *categoryIDs = [[NSMutableArray alloc] init];
        
        for (NSDictionary *currentCategory in [self categories])
        {
            NSNumber *categoryID = [currentCategory objectForKey:@"categoryID"];
            [categoryIDs addObject:categoryID];
        }
        
        _categoryIDs = [categoryIDs copy];
    }
    
    return _categoryIDs;
}

+ (NSNumber *)categoryIDForIndex:(NSUInteger)index
{
    return [[self categoryIDs] objectAtIndex:index];
}


+ (NSString *)categoryNameForID:(NSNumber *)categoryID
{
    return [[self objectForCategoryID:categoryID] objectForKey:@"categoryName"];
}

+ (NSString *)imageNameForID:(NSNumber *)categoryID
{
    return [[self objectForCategoryID:categoryID] objectForKey:@"imageName"];
}

+ (NSString *)highlightedImageNameForID:(NSNumber *)categoryID
{
    return [[self objectForCategoryID:categoryID] objectForKey:@"highlightedImageName"];
}

#pragma mark - Private methods

+ (NSArray *)categories
{
    if (_categories == nil)
    {
        NSURL *categoriesURL = [[NSBundle mainBundle] URLForResource:@"Categories" withExtension:@"plist"];
        NSDictionary *categoriesDict = [[NSDictionary alloc] initWithContentsOfURL:categoriesURL];
        
        _categories = [categoriesDict objectForKey:@"categories"];
    }
    
    return _categories;
}

+ (NSDictionary *)categoriesByID
{
    if (_categoriesByID == nil)
    {
        NSMutableDictionary *categoriesByID = [[NSMutableDictionary alloc] init];
        
        for (NSDictionary *currentCategory in [self categories])
        {
            NSNumber *categoryID = [currentCategory objectForKey:@"categoryID"];
            [categoriesByID setValue:currentCategory forKey:[categoryID stringValue]];
        }
        
        _categoriesByID = [categoriesByID copy];
    }
    
    return _categoriesByID;
}

+ (NSDictionary *)objectForCategoryID:(NSNumber *)categoryID
{
    return [[self categoriesByID] objectForKey:[categoryID stringValue]];
}

@end
