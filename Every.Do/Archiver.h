//
//  savedTask.h
//  Every.Do
//
//  Created by Samia Al Rahmani on 3/30/15.
//  Copyright (c) 2015 Samia Al Rahmani. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Todo;

@interface Archiver : NSObject

+ (void)saveTasks:(NSArray *)taskArray;
+ (NSArray *)loadTasks;
+ (void)deleteTask:(Todo *)task;

+ (void)saveDraft:(Todo *)task;
+ (Todo *)loadDraft;
+ (void)deleteDraft;

@end
