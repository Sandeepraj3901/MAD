//
//  ToDoTableViewController.m
//  Task Management
//
//  Created by Kamireddi, Gaurav Venkata Satya Pratik on 11/19/17.
//  Copyright © 2017 Kamireddi, Gaurav Venkata Satya Pratik. All rights reserved.
//

#import <CoreData/CoreData.h>
#import "ToDoTableViewController.h"
#import "AppDelegate.h"
#import "ToDoViewController.h"

@interface ToDoTableViewController ()
@property (strong, nonatomic) NSMutableArray *todos;
@end

@implementation ToDoTableViewController
@synthesize todos;

-(NSManagedObjectContext *) managedObjectContext{
    NSManagedObjectContext *context = nil;
    id delegate = [[UIApplication sharedApplication] delegate];
    if ([delegate respondsToSelector:@selector(persistentContainer)]) {
        context = [[delegate persistentContainer] viewContext];
    }
    return context;
}

-(id)initWithStyle:(UITableViewStyle)style{
    self = [super initWithStyle:style];
    if(self){
        //Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    //Fetch the Books from persistent data store
    NSManagedObjectContext *managedObjectContext = [self managedObjectContext];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Todo"];
    self.todos = [[managedObjectContext executeFetchRequest:fetchRequest error:nil] mutableCopy];
    
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return todos.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    
    NSSortDescriptor *itemXml = [[NSSortDescriptor alloc] initWithKey:@"date" ascending:YES];
    NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:itemXml,nil];
    [todos sortUsingDescriptors:sortDescriptors];
    NSManagedObjectContext *todo = [todos objectAtIndex:indexPath.row];
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"dd MMMM yyyy HH:mm:ss"];
    NSDate *dater;
    dater = [todo valueForKey:@"date"];
    NSString *getDater = [dateFormat stringFromDate:dater];
    
    [cell.textLabel setText:[NSString stringWithFormat:@"%@", [todo valueForKey:@"title"]]];
    [cell.detailTextLabel setText:[NSString stringWithFormat:@"%@", getDater]];
    
    return cell;
}

// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    NSManagedObjectContext *context = [self managedObjectContext];
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [context deleteObject:[todos objectAtIndex:indexPath.row]];
    }
    NSError *error = nil;
    if(![context save:&error]){
        NSLog(@"Can't delete! %@ %@", error, [error localizedDescription]);
        return;
    }
    //Remove todo from tableView
    [todos removeObjectAtIndex:indexPath.row];
    [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
}

#pragma mark - Table view delegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if([segue.identifier isEqualToString:@"UpdateTodo"]){
        NSManagedObject *selectedTodo = [self.todos objectAtIndex:[[self.tableView indexPathForSelectedRow]row]];
        ToDoViewController *destinationVC = segue.destinationViewController;
        destinationVC.todo = selectedTodo;
        NSLog(@"%@",selectedTodo);
    }
}

@end
