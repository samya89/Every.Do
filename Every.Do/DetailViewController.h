//
//  DetailViewController.h
//  Every.Do
//
//  Created by Samia Al Rahmani on 3/25/15.
//  Copyright (c) 2015 Samia Al Rahmani. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Todo;

@interface DetailViewController : UIViewController

@property (strong, nonatomic) Todo *detailItem;
@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;


@end

