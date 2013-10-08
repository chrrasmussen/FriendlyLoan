//
//  PersonMock.h
//  FriendlyLoan
//
//  Created by Christian Rasmussen on 20.07.12.
//  Copyright (c) 2012 Rasmussen I/O. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FLPerson.h"


@interface PersonMock : NSObject <FLPerson>

@property (nonatomic, strong) NSString *personUUID;
@property (nonatomic, strong) NSString *firstName;
@property (nonatomic, strong) NSString *lastName;

@end
