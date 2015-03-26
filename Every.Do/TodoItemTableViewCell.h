//
//  TodoItemTableViewCell.h
//  Every.Do
//
//  Created by Samia Al Rahmani on 3/25/15.
//  Copyright (c) 2015 Samia Al Rahmani. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TodoItemTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *todoTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (weak, nonatomic) IBOutlet UILabel *priorityLabel;

@end
