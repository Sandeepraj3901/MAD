//
//  FinancialViewController.h
//  Task Management
//
//  Created by Kamireddi, Gaurav Venkata Satya Pratik on 11/19/17.
//  Copyright © 2017 Kamireddi, Gaurav Venkata Satya Pratik. All rights reserved.
//

#import <CoreData/CoreData.h>
#import <UIKit/UIKit.h>

@interface FinancialViewController : UIViewController <UIScrollViewDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate>
@property (weak, nonatomic) IBOutlet UITextField *titleTextField;
- (IBAction)save:(id)sender;
- (IBAction)cancel:(id)sender;
@property (weak, nonatomic) IBOutlet UIImageView *imageHolder;
@property (nonatomic, retain) NSData *imag;
- (IBAction)addImageFromDevice:(id)sender;
- (IBAction)addImageFromCamera:(id)sender;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (strong) NSManagedObject *financial;
@end
