//
//  FinancialTableViewController.m
//  Task Management
//
//  Created by Kamireddi, Gaurav Venkata Satya Pratik on 11/19/17.
//  Copyright © 2017 Kamireddi, Gaurav Venkata Satya Pratik. All rights reserved.
//

#import <CoreData/CoreData.h>
#import "FinancialTableViewController.h"
#import "AppDelegate.h"
#import "FinancialViewController.h"

@interface FinancialTableViewController ()
@property (strong, nonatomic) NSMutableArray *financials;
@end

@implementation FinancialTableViewController
@synthesize financials;

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
    
    //Fetch the Wallets from persistent data store
    NSManagedObjectContext *managedObjectContext = [self managedObjectContext];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Financial"];
    self.financials = [[managedObjectContext executeFetchRequest:fetchRequest error:nil] mutableCopy];
    
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
    return financials.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    NSManagedObjectContext *financial = [financials objectAtIndex:indexPath.row];
    // Configure the cell...
    [cell.textLabel setText:[NSString stringWithFormat:@"%@", [financial valueForKey:@"title"]]];
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
        [context deleteObject:[financials objectAtIndex:indexPath.row]];
    }
    NSError *error = nil;
    
    if(![context save:&error]){
        NSLog(@"Can't delete! %@ %@", error, [error localizedDescription]);
        return;
    }
    //Remove financial from tableView
    [financials removeObjectAtIndex:indexPath.row];
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
    if([segue.identifier isEqualToString:@"UpdateFinancial"]){
        NSManagedObject *selectedFinancial = [self.financials objectAtIndex:[[self.tableView indexPathForSelectedRow]row]];
        FinancialViewController *destinationVC = segue.destinationViewController;
        destinationVC.financial = selectedFinancial;
        NSLog(@"%@",selectedFinancial);
    }
}

@end
