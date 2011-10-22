//
//  Categories.m
//  FriendlyLoan
//
//  Created by Christian Rasmussen on 26.09.11.
//  Copyright (c) 2011 Rasmussen I/O. All rights reserved.
//

#import "Category.h"

@interface Category ()

- (id)initWithCategoryData:(NSDictionary *)categoryData;
+ (NSDictionary *)categories;
+ (NSArray *)categoriesByIndex;
+ (NSDictionary *)categoriesByID;
+ (NSDictionary *)objectForCategoryID:(NSNumber *)categoryID;

@end

@implementation Category {
    NSDictionary *_categoryData;
}

static NSDictionary *_categories;
static NSArray *_categoriesByIndex;
static NSDictionary *_categoriesByID;
static Category *_unknownCategory;

static NSCache *_storedCategories;

+ (NSUInteger)numberOfCategories
{
    return [[self categoriesByIndex] count];
}

+ (Category *)unknownCategory
{
    if (_unknownCategory == nil)
    {
        NSDictionary *unknownCategoryData = [[self categories] objectForKey:@"unknownCategory"];
        _unknownCategory = [[self alloc] initWithCategoryData:unknownCategoryData];
    }
    
    return _unknownCategory;
}

+ (Category *)categoryForCategoryID:(NSNumber *)categoryID
{
    if (_storedCategories == nil)
        _storedCategories = [[NSCache alloc] init];
    
    Category *category = [_storedCategories objectForKey:categoryID];
    if (category == nil)
    {
        NSDictionary *categoryData = [[self categoriesByID] objectForKey:[categoryID stringValue]];
        category = [[self alloc] initWithCategoryData:categoryData];
        
        [_storedCategories setObject:category forKey:categoryID];
    }
    
    return category;
}

+ (Category *)categoryForIndex:(NSUInteger)index
{
    if (index >= [self numberOfCategories])
        return nil;
    
    NSDictionary *categoryData = [[self categoriesByIndex] objectAtIndex:index];
    NSNumber *categoryID = [categoryData objectForKey:@"categoryID"];
    
    return [[self class] categoryForCategoryID:categoryID];
}

- (BOOL)hidden
{
    return [[_categoryData objectForKey:@"hidden"] boolValue];
}

- (NSNumber *)categoryID
{
    return [_categoryData objectForKey:@"categoryID"];
}

- (NSString *)categoryName
{
    return [_categoryData objectForKey:@"categoryName"];
}

- (NSString *)imageName
{
    return [_categoryData objectForKey:@"imageName"];
}

- (NSString *)highlightedImageName
{
    return [_categoryData objectForKey:@"highlightedImageName"];
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"<%@: 0x%x; categoryID = %@; categoryName = %@>", self.class, self, self.categoryID, self.categoryName];
}

#pragma mark - Private methods

- (id)initWithCategoryData:(NSDictionary *)categoryData
{
    self = [super init];
    if (self) {
        if (categoryData == nil)
        {
            self = nil;
            return nil;
        }
        
        _categoryData = categoryData;
    }
    return self;
}

+ (NSDictionary *)categories
{
    if (_categories == nil)
    {
        NSURL *categoriesURL = [[NSBundle mainBundle] URLForResource:@"Categories" withExtension:@"plist"];
        _categories = [[NSDictionary alloc] initWithContentsOfURL:categoriesURL];
    }
    
    return _categories;
}

+ (NSArray *)categoriesByIndex
{
    if (_categoriesByIndex == nil)
    {
        NSArray *allCategories = [[self categories] objectForKey:@"categories"];
        
        // Filter the categories
        NSPredicate *hiddenPredicate = [NSPredicate predicateWithFormat:@"hidden == NO"];
        _categoriesByIndex = [allCategories filteredArrayUsingPredicate:hiddenPredicate];
    }
    
    return _categoriesByIndex;
}

+ (NSDictionary *)categoriesByID
{
    if (_categoriesByID == nil)
    {
        NSMutableDictionary *categoriesByID = [[NSMutableDictionary alloc] init];
        
        NSArray *allCategories = [[self categories] objectForKey:@"categories"];
        for (NSDictionary *currentCategory in allCategories)
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
