//
//  savedTask.m
//  Every.Do
//
//  Created by Samia Al Rahmani on 3/30/15.
//  Copyright (c) 2015 Samia Al Rahmani. All rights reserved.
//

#import "Archiver.h"
#import "Todo.h"

@implementation Archiver

+ (NSString *)taskFilePath{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectoryPath = [paths objectAtIndex:0];
    return [documentsDirectoryPath stringByAppendingPathComponent:@"tasks"];
}

+ (NSString *)draftFilePath{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectoryPath = [paths objectAtIndex:0];
    return [documentsDirectoryPath stringByAppendingPathComponent:@"drafts"];
}

+ (void)saveTasks:(NSArray *)taskArray{
    [NSKeyedArchiver archiveRootObject:taskArray toFile:[self taskFilePath]];
}

+ (NSArray *)loadTasks{
    return [NSKeyedUnarchiver unarchiveObjectWithFile:[self taskFilePath]];
}

+ (void)deleteTask:(Todo *)task{
    NSMutableArray *tasks = [[self loadtasks] mutableCopy];
    [tasks removeObject:task];
    [self savetasks:tasks];
}

+ (void)saveDraft:(Todo *)task{
    [NSKeyedArchiver archiveRootObject:task toFile:[self draftFilePath]];
}

+ (Todo *)loadDraft{
    return [NSKeyedUnarchiver unarchiveObjectWithFile:[self draftFilePath]];
}

+ (void)deleteDraft{
    [[NSFileManager defaultManager] removeItemAtPath:[self draftFilePath] error:NULL];
}



@end






