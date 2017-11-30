//
//  WalletViewController.m
//  Task Management
//
//  Created by Kamireddi, Gaurav Venkata Satya Pratik on 11/19/17.
//  Copyright © 2017 Kamireddi, Gaurav Venkata Satya Pratik. All rights reserved.
//

#import "WalletViewController.h"
#import "AppDelegate.h"

@interface WalletViewController ()

@end

@implementation WalletViewController
@synthesize titleTextField, usernameTextField, passwordTextField, urlTextField, wallet;

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
    if(self.wallet){
        [titleTextField setText:[self.wallet valueForKey:@"title"]];
        [usernameTextField setText:[self.wallet valueForKey:@"username"]];
        [passwordTextField setText:[self.wallet valueForKey:@"password"]];
        [urlTextField setText:[self.wallet valueForKey:@"url"]];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)save:(id)sender {
    NSManagedObjectContext *context = [self managedObjectContext];
    if(self.wallet){
        //Update Existing Wallet
        [self.wallet setValue:self.titleTextField.text forKey:@"title"];
        [self.wallet setValue:self.usernameTextField.text forKey:@"username"];
        [self.wallet setValue:self.passwordTextField.text forKey:@"password"];
        [self.wallet setValue:self.urlTextField.text forKey:@"url"];
    }
    else{
        //Create a new Wallet
        NSManagedObject *newWallet = [NSEntityDescription insertNewObjectForEntityForName:@"Wallet" inManagedObjectContext:context];
        [newWallet setValue:self.titleTextField.text forKey:@"title"];
        [newWallet setValue:self.usernameTextField.text forKey:@"username"];
        [newWallet setValue:self.passwordTextField.text forKey:@"password"];
        [newWallet setValue:self.urlTextField.text forKey:@"url"];
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
@end
