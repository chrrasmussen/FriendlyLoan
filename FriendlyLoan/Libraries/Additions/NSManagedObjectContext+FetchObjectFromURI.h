//
//  NSManagedObjectContext+FetchObjectFromURI.h
//  FriendlyLoan
//
//  Created by Christian Rasmussen on 28.01.12.
//  Copyright (c) 2012 Rasmussen I/O. All rights reserved.
//

// Source: http://cocoawithlove.com/2008/08/safely-fetching-nsmanagedobject-by-uri.html

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@class NSManagedObject;

@interface NSManagedObjectContext (FetchObjectFromURI)

- (NSManagedObject *)objectWithURI:(NSURL *)uri;

@end
