//
//  ToDoViewController.h
//  Task Management
//
//  Created by Kamireddi, Gaurav Venkata Satya Pratik on 11/19/17.
//  Copyright © 2017 Kamireddi, Gaurav Venkata Satya Pratik. All rights reserved.
//

#import <CoreData/CoreData.h>
#import <UIKit/UIKit.h>

@interface ToDoViewController : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource>
@property (weak, nonatomic) IBOutlet UILabel *lblSelectedDate;
@property (weak, nonatomic) IBOutlet UIDatePicker *datePickerControl;
@property (weak, nonatomic) IBOutlet UITextField *titleTextField;
@property (weak, nonatomic) IBOutlet UIPickerView *pickerView;
@property (weak, nonatomic) IBOutlet UILabel *lblCategory;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segment;

@property (strong) NSManagedObject *todo;
- (IBAction)save:(id)sender;
- (IBAction)cancel:(id)sender;
- (IBAction)datePicker:(id)sender;
- (IBAction)segmentChanged:(id)sender;

@end
