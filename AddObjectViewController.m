//
//  AddObjectViewController.m
//  Every.Do
//
//  Created by Samia Al Rahmani on 3/25/15.
//  Copyright (c) 2015 Samia Al Rahmani. All rights reserved.
//

#import "AddObjectViewController.h"
#import "MasterViewController.h"
#import "Archiver.h"


@interface AddObjectViewController ()

@property (nonatomic, strong) Todo *draftTask;

@end

@implementation AddObjectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    Todo *draft = [Archiver loadDraft];
    if (draft != nil){
        self.draftTask = draft;
    } else {
        NSDictionary *defaultTask = [[NSUserDefaults standardUserDefaults] dictionaryForKey:@"defaultTask"];
        self.draftTask = [Todo new];
        self.draftTask.title = defaultTask[@"title"];
        self.draftTask.details = defaultTask[@"details"];
        self.draftTask.priorityNumber = [defaultTask[@"priorityNumber"] intValue];
    }
    
    self.addTitleTextField.text = self.draftTask.title;
    self.addDetailsTextField.text = self.draftTask.details;
    self.addPriorityTextField.text = [NSString stringWithFormat:@"%@", @(self.draftTask.priorityNumber)];
}

- (IBAction)done{
    [Archiver saveTask:self.draftTask];
    [Archiver deleteDraft];
    [self.delegate addTask:self.draftTask];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)cancel:(id)sender {
    [Archiver deleteDraft];
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (IBAction)titleChangedText:(UITextField *)sender {
    self.draftTask.title = self.addTitleTextField.text;
    [Archiver saveDraft:self.draftTask];
}

- (IBAction)detailsChangedText:(UITextField *)sender {
    self.draftTask.details = self.addDetailsTextField.text;
    [Archiver saveDraft:self.draftTask];
}

- (IBAction)priorityChangedText:(UITextField *)sender {
    self.draftTask.priorityNumber = [self.addPriorityTextField.text intValue];
    [Archiver saveDraft:self.draftTask];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
