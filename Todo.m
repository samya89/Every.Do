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

- (id)initWithCoder:(NSCoder *)decoder {
    self = [super init];
    if (!self) {
        return nil;
    }
    
    self.title = [decoder decodeObjectForKey:@"title"];
    self.details = [decoder decodeObjectForKey:@"details"];
    self.priorityNumber = [decoder decodeIntForKey:@"priorityNumber"];
    self.isCompleted = [decoder decodeBoolForKey:@"isCompleted"];
    
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeObject:self.title forKey:@"title"];
    [encoder encodeObject:self.details forKey:@"details"];
    [encoder encodeInt:self.priorityNumber forKey:@"priorityNumber"];
    [encoder encodeBool:self.isCompleted forKey:@"isCompleted"];
}


@end
