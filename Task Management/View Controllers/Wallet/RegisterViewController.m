//
//  RegisterViewController.m
//  Task Management
//
//  Created by Kamireddi, Gaurav Venkata Satya Pratik on 11/29/17.
//  Copyright © 2017 Kamireddi, Gaurav Venkata Satya Pratik. All rights reserved.
//

#import "RegisterViewController.h"

@interface RegisterViewController ()

@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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

- (IBAction)registerBtn:(id)sender {
    if([_passwordField.text isEqualToString:@""] || [_reEnterPasswordField.text isEqualToString:@""]){
        UIAlertView *error = [[UIAlertView alloc] initWithTitle:@"Ooops!" message:@"You must complete all Fields" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [error show];
    }
    else{
        [self checkPasswordsMatch];
        [self performSegueWithIdentifier:@"login" sender:self];
    }
}

-(void)checkPasswordsMatch{
    if([_passwordField.text isEqualToString:_reEnterPasswordField.text]){
        NSLog(@"Passwords Match");
        [self registerNewUser];
    }
    else{
        NSLog(@"Passwords dont match");
        UIAlertView *error = [[UIAlertView alloc] initWithTitle:@"Ooops!" message:@"Your Entered Passwords do not match" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [error show];
    }
}

-(void)registerNewUser{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:_passwordField.text forKey:@"password"];
    [defaults setBool:YES forKey:@"registered"];
    [defaults synchronize];
    
    UIAlertView *success = [[UIAlertView alloc] initWithTitle:@"Success" message:@"You have Registerd a New User" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
    [success show];
    [self performSegueWithIdentifier:@"login" sender:self];
}
- (IBAction)backBtn:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
