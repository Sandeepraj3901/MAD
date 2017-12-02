//
//  ToDoViewController.m
//  Task Management
//
//  Created by Kamireddi, Gaurav Venkata Satya Pratik on 11/19/17.
//  Copyright © 2017 Kamireddi, Gaurav Venkata Satya Pratik. All rights reserved.
//

#import "ToDoViewController.h"
#import "AppDelegate.h"

@interface ToDoViewController ()
{
    NSDate *fixDate;
    NSArray *categories;
}
@end

@implementation ToDoViewController
@synthesize titleTextField, datePickerControl, lblSelectedDate, todo, segment, priorityLabel, lblCategory;

-(NSManagedObjectContext *) managedObjectContext{
    NSManagedObjectContext *context = nil;
    id delegate = [[UIApplication sharedApplication] delegate];
    if ([delegate respondsToSelector:@selector(persistentContainer)]) {
        context = [[delegate persistentContainer] viewContext];
    }
    return context;
}

-(id) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if(self){
        //Custom init
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    categories = @[@"Gas", @"Groceries", @"Clothing", @"Food", @"Home", @"Fun", @"Transport", @"Utilities", @"General"];
    self.pickerView.dataSource = self;
    self.pickerView.delegate = self;
    
    if(self.todo){
        //Title
        [titleTextField setText:[self.todo valueForKey:@"title"]];

        //Priority
        NSString *take = [segment titleForSegmentAtIndex:[segment selectedSegmentIndex]];
        priorityLabel.text = [NSString stringWithFormat:@"%@", take ];
        [priorityLabel setText:[self.todo valueForKey:@"priority"]];
        
        [lblCategory setText:[self.todo valueForKey:@"category"]];
        
        //Date
        NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
        [dateFormat setDateFormat:@"dd MMMM yyyy HH:mm:ss"];
        NSDate *dater;
        dater = [self.todo valueForKey:@"date"];
        NSString *getDater = [dateFormat stringFromDate:dater];
        [lblSelectedDate setText:[NSString stringWithFormat:@"%@", getDater]];
        //[lblSelectedDate setText:[self.book valueForKey:@"duedate"]];
        NSLog(@"Title %@", titleTextField);
    }
    //NSLog(@"Title %@", titleTextField);
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return categories.count;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return categories[row];
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    self.lblCategory.text = categories[row];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)save:(id)sender {
    NSManagedObjectContext *context = [self managedObjectContext];
    if(self.todo){
        //Update Existing Todo
        [self.todo setValue:self.titleTextField.text forKey:@"title"];
        [self.todo setValue:fixDate forKey:@"date"];
        [self.todo setValue:self.priorityLabel.text forKey:@"priority"];
        [self.todo setValue:self.lblCategory.text forKey:@"category"];
    }
    else{
        //Create a new Todo
        NSManagedObject *newTodo = [NSEntityDescription insertNewObjectForEntityForName:@"Todo" inManagedObjectContext:context];
        [newTodo setValue:self.titleTextField.text forKey:@"title"];
        [newTodo setValue:fixDate forKey:@"date"];
        [newTodo setValue:self.priorityLabel.text forKey:@"priority"];
        [newTodo setValue:self.lblCategory.text forKey:@"category"];
    }
    NSError *error = nil;
    //Save the object to persistent store
    if(![context save:&error]){
        NSLog(@"Can't save! %@ %@", error, [error localizedDescription]);
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)cancel:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)datePicker:(id)sender {
    NSDate *myDate = [datePickerControl date];
    fixDate = myDate;
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"dd MMMM yyyy HH:mm:ss"];
    NSString *getDate = [dateFormat stringFromDate:myDate];
    [lblSelectedDate setText:[NSString stringWithFormat:@"%@", getDate]];
}

- (IBAction)segmentChanged:(id)sender {
    if([segment selectedSegmentIndex] == 0){
        [priorityLabel setText:@"First"];
    }
    else if([segment selectedSegmentIndex] == 1){
        [priorityLabel setText:@"Second"];
    }
    else if([segment selectedSegmentIndex] == 2){
        [priorityLabel setText:@"Third"];
    }
    //str = [segment titleForSegmentAtIndex:[segment selectedSegmentIndex]];
}
@end
