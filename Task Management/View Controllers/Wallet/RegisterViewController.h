//
//  RegisterViewController.h
//  Task Management
//
//  Created by Kamireddi, Gaurav Venkata Satya Pratik on 11/29/17.
//  Copyright © 2017 Kamireddi, Gaurav Venkata Satya Pratik. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RegisterViewController : UIViewController <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
- (IBAction)registerBtn:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *reEnterPasswordField;
- (IBAction)backBtn:(id)sender;

@end
