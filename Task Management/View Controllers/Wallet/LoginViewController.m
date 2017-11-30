//
//  LoginViewController.m
//  Task Management
//
//  Created by Kamireddi, Gaurav Venkata Satya Pratik on 11/29/17.
//  Copyright © 2017 Kamireddi, Gaurav Venkata Satya Pratik. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

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

- (IBAction)LoginUser:(id)sender {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if([_passwordField.text isEqualToString:@""]){
        UIAlertView *nilerror = [[UIAlertView alloc] initWithTitle:@"Ooops!" message:@"Please Enter Password" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [nilerror show];
    }
    else if([_passwordField.text isEqualToString:[defaults objectForKey:@"password"]]){
        NSLog(@"login credentials accepted");
        _passwordField.text = nil;
        [self performSegueWithIdentifier:@"enter" sender:self];
    }
    else{
        NSLog(@"Login credentials incorrect");
        UIAlertView *error = [[UIAlertView alloc] initWithTitle:@"Ooops!" message:@"Your Password does not match" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [error show];
    }
}
@end
