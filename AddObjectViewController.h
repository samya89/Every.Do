//
//  AddObjectViewController.h
//  Every.Do
//
//  Created by Samia Al Rahmani on 3/25/15.
//  Copyright (c) 2015 Samia Al Rahmani. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Todo.h"

@interface AddObjectViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *addTitleTextField;
@property (weak, nonatomic) IBOutlet UITextField *addDetailsTextField;
@property (weak, nonatomic) IBOutlet UITextField *addPriorityTextField;

@property (nonatomic) NSString *titleInput;
@property (nonatomic) NSString *detailsInput;
@property (nonatomic) NSString *priorityInput;

@property (nonatomic,strong) Todo *todoItem;

- (IBAction)done;


@end
