//
//  CategoryList.m
//  FriendlyLoan
//
//  Created by Christian Rasmussen on 07.05.12.
//  Copyright (c) 2012 Rasmussen I/O. All rights reserved.
//

#import "CategoryList.h"

@implementation CategoryList

static NSDictionary *_categories;
static NSDictionary *_categoriesByID;
static NSArray *_categoryIDs;


#pragma mark - Get all categories

+ (NSDictionary *)categories
{
    if (_categories == nil)
    {
        NSURL *categoriesURL = [[NSBundle mainBundle] URLForResource:@"CategoryList" withExtension:@"plist"];
        NSDictionary *categorList = [[NSDictionary alloc] initWithContentsOfURL:categoriesURL];
        _categories = [categorList objectForKey:@"categories"];
    }
    
    return _categories;
}

+ (NSDictionary *)categoriesByID
{
    if (_categoriesByID == nil)
    {
        NSMutableDictionary *categoriesByID = [[NSMutableDictionary alloc] init];
        
        for (NSDictionary *category in [self categories])
        {
            NSNumber *categoryID = [category objectForKey:@"categoryID"];
            [categoriesByID setValue:category forKey:[categoryID stringValue]];
        }
        
        _categoriesByID = [categoriesByID copy];
    }
    
    return _categoriesByID;
}

+ (NSArray *)categoryIDs
{
    if (_categoryIDs == nil)
    {
        NSMutableArray *categoryIDs = [[NSMutableArray alloc] init];
        
        for (NSDictionary *category in [self categories])
        {
            BOOL hidden = [[category objectForKey:@"hidden"] boolValue];
            if (!hidden) {
                NSNumber *categoryID = [category objectForKey:@"categoryID"];
                [categoryIDs addObject:categoryID];
            }
        }
        
        _categoryIDs = [categoryIDs copy];
    }
    
    return _categoryIDs;
}


#pragma mark - Get attributes from category

+ (NSString *)nameForCategoryID:(NSNumber *)categoryID
{
    NSString *categoryKey = [self categoryKeyForCategoryID:categoryID];
    if (categoryKey == nil) {
        categoryKey = @"Unknown";
    }
    NSString *translatedName = [[NSBundle mainBundle] localizedStringForKey:categoryKey value:@"" table:@"Categories"];
    
    return translatedName;
}

+ (UIImage *)imageForCategoryID:(NSNumber *)categoryID
{
    NSString *imageName = [self imageNameForCategoryID:categoryID];
    if (imageName == nil) {
        imageName = @"Unknown-Normal";
    }
    UIImage *image = [UIImage imageNamed:imageName];
    
    return image;
}

+ (UIImage *)highlightedImageForCategoryID:(NSNumber *)categoryID
{
    NSString *highlightedImageName = [self highlightedImageNameForCategoryID:categoryID];
    if (highlightedImageName == nil) {
        highlightedImageName = @"Unknown-Highlighted";
    }
    UIImage *highlightedImage = [UIImage imageNamed:highlightedImageName];
    
    return highlightedImage;
}


#pragma mark - Private methods

+ (NSString *)categoryKeyForCategoryID:(NSNumber *)categoryID
{
    return [[[self categoriesByID] objectForKey:[categoryID stringValue]] objectForKey:@"categoryKey"];
}

+ (NSString *)imageNameForCategoryID:(NSNumber *)categoryID
{
    return [[[self categoriesByID] objectForKey:[categoryID stringValue]] objectForKey:@"imageName"];
}

+ (NSString *)highlightedImageNameForCategoryID:(NSNumber *)categoryID
{
    return [[[self categoriesByID] objectForKey:[categoryID stringValue]] objectForKey:@"highlightedImageName"];
}

@end
