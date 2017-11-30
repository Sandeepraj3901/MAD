//
//  WalletViewController.h
//  Task Management
//
//  Created by Kamireddi, Gaurav Venkata Satya Pratik on 11/19/17.
//  Copyright © 2017 Kamireddi, Gaurav Venkata Satya Pratik. All rights reserved.
//

#import <CoreData/CoreData.h>
#import <UIKit/UIKit.h>

@interface WalletViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *titleTextField;
@property (weak, nonatomic) IBOutlet UITextField *usernameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UITextField *urlTextField;
- (IBAction)save:(id)sender;
- (IBAction)cancel:(id)sender;

@property (strong) NSManagedObject *wallet;

@end
