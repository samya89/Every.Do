//
//  AddObjectViewController.m
//  Every.Do
//
//  Created by Samia Al Rahmani on 3/25/15.
//  Copyright (c) 2015 Samia Al Rahmani. All rights reserved.
//

#import "AddObjectViewController.h"
#import "MasterViewController.h"


@interface AddObjectViewController ()

@property (nonatomic, strong) Todo *draftTask;

@end

@implementation AddObjectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSDictionary *defaultTask = [[NSUserDefaults standardUserDefaults] dictionaryForKey:@"defaultTask"];
    NSString *defaultTitle = defaultTask[@"title"];
    NSString *defaultDetails = defaultTask[@"details"];
    NSString *defaultPriority = defaultTask[@"priorityNumber"];
    
    self.addTitleTextField.text = defaultTitle;
    self.addDetailsTextField.text = defaultDetails;
    self.addPriorityTextField.text = defaultPriority;
    
    NSArray *draftInput = [NSKeyedUnarchiver unarchiveObjectWithFile:[self getFilePath]];
    if (draftInput) {
        self.todoItem = [draftInput mutableCopy];
    }
    
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
  
    
//    self.addTitleTextField.text = [[NSUserDefaults standardUserDefaults] objectForKey:@"TitleToSave"];


}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSString*)getFilePath{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectoryPath = [paths objectAtIndex:0];
    return [documentsDirectoryPath stringByAppendingPathComponent:@"appData"];
}


- (IBAction)done{
    self.todoItem.title = self.addTitleTextField.text;
    self.todoItem.details = self.addDetailsTextField.text;
    self.todoItem.priorityNumber = [self.addPriorityTextField.text intValue];
    
    [self.delegate save];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)titleChangedText:(UITextField *)sender {
//    self.draftTask.title = self.addTitleTextField.text;
//    [NSKeyedArchiver archiveRootObject:self.todoItem toFile:[self getFilePath]];
}

- (IBAction)detailsChangedText:(UITextField *)sender {

}

- (IBAction)priorityChangedText:(UITextField *)sender {
    
    
    
//    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
//    [prefs setObject:@"PriorityToSave" forKey:@"priorityInput"];
//    [prefs synchronize];
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
