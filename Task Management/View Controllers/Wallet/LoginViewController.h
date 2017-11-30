//
//  LoginViewController.h
//  Task Management
//
//  Created by Kamireddi, Gaurav Venkata Satya Pratik on 11/29/17.
//  Copyright © 2017 Kamireddi, Gaurav Venkata Satya Pratik. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;
- (IBAction)LoginUser:(id)sender;


@end
