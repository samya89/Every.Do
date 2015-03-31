//
//  AddObjectVCDelegate.h
//  Every.Do
//
//  Created by Samia Al Rahmani on 3/30/15.
//  Copyright (c) 2015 Samia Al Rahmani. All rights reserved.
//

@class Todo;

@protocol AddObjectVCDelegate <NSObject>

- (void)addTask:(Todo *)task;

@end