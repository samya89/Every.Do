//
//  Todo.m
//  Every.Do
//
//  Created by Samia Al Rahmani on 3/25/15.
//  Copyright (c) 2015 Samia Al Rahmani. All rights reserved.
//

#import "Todo.h"

@implementation Todo

- (instancetype)initWithTitle:(NSString *)title withDetail:(NSString *)details andPriority:(int)priorityNumber andisCompleted:(BOOL)isCompleted
{
    self = [super init];
    if (self) {
        self.title = title;
        self.details = details;
        self.priorityNumber = priorityNumber;
        self.isCompleted = isCompleted;
    }
    return self;
}


@end
