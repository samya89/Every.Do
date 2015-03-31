//
//  MasterViewController.m
//  Every.Do
//
//  Created by Samia Al Rahmani on 3/25/15.
//  Copyright (c) 2015 Samia Al Rahmani. All rights reserved.
//

#import "MasterViewController.h"
#import "DetailViewController.h"
#import "Todo.h"
#import "TodoItemTableViewCell.h"
#import "AddObjectViewController.h"
#import "Archiver.h"

@interface MasterViewController ()

@property (nonatomic) NSMutableArray *todoItems;
@property (nonatomic) NSIndexPath *indexPath;

@end

@implementation MasterViewController

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.leftBarButtonItem = self.editButtonItem;
    NSMutableArray *savedItems = [[Archiver loadTasks] mutableCopy];
    if (savedItems != nil){
        self.todoItems = savedItems;
    }else {
        self.todoItems = [NSMutableArray new];
    }

    [self.tableView reloadData];
}

#pragma mark - AddObjectVCDelegate

- (void)addTask:(Todo *)task{
    [self.todoItems addObject:task];
    [self.tableView reloadData];
}

#pragma mark - Segues

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        Todo *object = self.todoItems[indexPath.row];
        
        [[segue destinationViewController] setDetailItem:object];
    }else if ([[segue identifier] isEqualToString:@"editDetail"]) {
        AddObjectViewController *addObjectVC = [segue destinationViewController];
        addObjectVC.delegate = self;
    }
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.todoItems.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TodoItemTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"todoItemCell" forIndexPath:indexPath];

    Todo *todoItem = self.todoItems[indexPath.row];
    if (todoItem.isCompleted)
    {
        NSMutableAttributedString *struckText = [[NSMutableAttributedString alloc] initWithString:[todoItem title]];
        
        [struckText addAttribute:NSStrikethroughStyleAttributeName
                                value:@(NSUnderlineStyleSingle)
                                range:NSMakeRange(0, [struckText length])];
        
        cell.todoTitleLabel.attributedText = struckText;
    }
    else
    {
        cell.todoTitleLabel.text = [todoItem title];
    }
    
    cell.descriptionLabel.text = [todoItem details];
    cell.priorityLabel.text = [NSString stringWithFormat:@"#%d",todoItem.priorityNumber];
    
    return cell;
}

//- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
//    // Return NO if you do not want the specified item to be editable.
//    return YES;
//}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.todoItems removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        [self saveTasks];
        
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }
}


#pragma mark - Row reordering


- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath
{
    NSString *stringToMove = self.todoItems[sourceIndexPath.row];
    [self.todoItems removeObjectAtIndex:sourceIndexPath.row];
    [self.todoItems insertObject:stringToMove atIndex:destinationIndexPath.row];
}


-(NSArray *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewRowAction *rowActionComplete = [UITableViewRowAction rowActionWithStyle:(UITableViewRowActionStyleDefault) title:@"Mark Completed" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
        // use indexPath to find our model object
        // change isCompleted property on the model
        // tell tableview to update teh cell at indexPath
        
        Todo *object = [self.todoItems objectAtIndex:indexPath.row];
        object.isCompleted = YES;
        [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    }];


    UITableViewRowAction *rowActionIncomplete = [UITableViewRowAction rowActionWithStyle:(UITableViewRowActionStyleDefault) title:@"Mark Incomplete" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
        Todo *object = [self.todoItems objectAtIndex:indexPath.row];
        object.isCompleted = NO;
        [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    }];
    
    
    UITableViewRowAction *deleteAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:@"Delete" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
        Todo *task = [self.todoItems objectAtIndex:indexPath.row];
        [self.todoItems removeObject:task];
        [self.tableView reloadData];
    }];
    
    Todo *task = [self.todoItems objectAtIndex:indexPath.row];
    
    if (task.isCompleted == YES) {
        return @[deleteAction, rowActionIncomplete];
    }
    else {
        return @[deleteAction, rowActionComplete];
    }
}

- (void)saveTasks {
    [Archiver saveTasks:self.todoItems.copy];
}
//
//- (IBAction)saveTasks:(id)sender {
//    [NSKeyedArchiver archiveRootObject:self.todoItems toFile:[self getFilePath]];
//    [self.tableView reloadData];
//}

@end















