//
//  Todo.h
//  Every.Do
//
//  Created by Samia Al Rahmani on 3/25/15.
//  Copyright (c) 2015 Samia Al Rahmani. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Todo : NSObject

@property (nonatomic) NSString *title;
@property (nonatomic) NSString *details;
@property (nonatomic, assign) int priorityNumber;
@property (nonatomic, assign) BOOL isCompleted;


- (instancetype)initWithTitle:(NSString *)title withDetail:(NSString *)details andPriority:(int)priorityNumber andisCompleted:(BOOL)isCompleted;



@end
