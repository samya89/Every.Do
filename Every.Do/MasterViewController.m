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
    
    Todo *object1 = [[Todo alloc] initWithTitle:@"Do dishes" withDetail:@"Unload  and load dishwasher" andPriority:1 andisCompleted:NO];
    Todo *object2 = [[Todo alloc] initWithTitle:@"Do laundry" withDetail:@"Wash towels" andPriority:2 andisCompleted:NO];
    Todo *object3 = [[Todo alloc] initWithTitle:@"Grocery shopping" withDetail:@"Buy fruits and vegetables" andPriority:3 andisCompleted:YES];
    Todo *object4 = [[Todo alloc] initWithTitle:@"Clean up bedroom" withDetail:@"Make bed and put away clothes" andPriority:4 andisCompleted:YES];
    
    self.todoItems = [NSMutableArray arrayWithObjects:object1, object2, object3, object4, nil];
    
    // Do any additional setup after loading the view, typically from a nib.
    self.navigationItem.leftBarButtonItem = self.editButtonItem;

//    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(insertNewObject:)];
//    self.navigationItem.rightBarButtonItem = addButton;
}

- (void)viewWillAppear:(BOOL)animated
{
//    NSLog(@"%s",__func__);
    [self.tableView reloadData];
}

- (void)viewDidAppear:(BOOL)animated
{
//    NSLog(@"%s",__func__);
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (Todo *)insertNewObject:(id)sender {
    if (!self.todoItems) {
        self.todoItems = [[NSMutableArray alloc] init];
    }
    

    Todo *todoItem = [Todo new];
    todoItem.title = @"New Todo Item";
    todoItem.details = @"Details";
    
    [self.todoItems insertObject:todoItem atIndex:0];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    return todoItem;
}

#pragma mark - Segues

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        Todo *object = self.todoItems[indexPath.row];
        
        [[segue destinationViewController] setDetailItem:object];
    }else if ([[segue identifier] isEqualToString:@"editDetail"]) {
        Todo *object = [self insertNewObject:self];
        AddObjectViewController *addObjectVC = [segue destinationViewController];
        addObjectVC.todoItem = object;
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
//    if (editingStyle == UITableViewCellEditingStyleDelete) {
//        [self.todoItems removeObjectAtIndex:indexPath.row];
//        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
//    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
//        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
//    }
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

    
    
    






@end
