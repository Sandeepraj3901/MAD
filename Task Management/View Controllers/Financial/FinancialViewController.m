//
//  FinancialViewController.m
//  Task Management
//
//  Created by Kamireddi, Gaurav Venkata Satya Pratik on 11/19/17.
//  Copyright © 2017 Kamireddi, Gaurav Venkata Satya Pratik. All rights reserved.
//

#import "FinancialViewController.h"
#import "AppDelegate.h"

@interface FinancialViewController ()

@end

@implementation FinancialViewController
@synthesize titleTextField, imageHolder, financial;

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
    [self.scrollView setMaximumZoomScale:5.0f];
    [self.scrollView self];
    if(self.financial){
        [titleTextField setText:[self.financial valueForKey:@"title"]];
//        [imageHolder setValue:UIImagePNGRepresentation(self.imageHolder.image) forKey:@"imagedata"];
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        if([defaults objectForKey:@"imagedata"]){
            NSData *loadData = [defaults objectForKey:@"imagedata"];
            imageHolder.image = [UIImage imageWithData:loadData];
        }
    }
}

-(UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{
    return self.imageHolder;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)save:(id)sender {
    NSManagedObjectContext *context = [self managedObjectContext];
    if(self.financial){
        //Update Existing Wallet
        [self.financial setValue:self.titleTextField.text forKey:@"title"];
        //[self.financial setValue:self.urlTextField.text forKey:@"url"];
        [self.financial setValue:UIImagePNGRepresentation(self.imageHolder.image) forKey:@"imagedata"];
    }
    else{
        //Create a new Wallet
        NSManagedObject *newFinancial = [NSEntityDescription insertNewObjectForEntityForName:@"Financial" inManagedObjectContext:context];
        [newFinancial setValue:self.titleTextField.text forKey:@"title"];
        [newFinancial setValue:UIImagePNGRepresentation(self.imageHolder.image) forKey:@"imagedata"];
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
- (IBAction)addImageFromDevice:(id)sender {
    UIImagePickerController *pickerController = [[UIImagePickerController alloc] init];
    pickerController.delegate = self;
    [pickerController setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
    pickerController.allowsEditing = YES;
    [self presentViewController:pickerController animated:YES completion:nil];
}

- (IBAction)addImageFromCamera:(id)sender {
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
        UIImagePickerController *pickerController = [[UIImagePickerController alloc] init];
        pickerController.delegate = self;
        [pickerController setSourceType:UIImagePickerControllerSourceTypeCamera];
        pickerController.allowsEditing = YES;
        [self presentViewController:pickerController animated:YES completion:nil];
    }
    else{
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Oops!" message:@"Your device does not have a Camera!" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {}];
        [alert addAction:action];
        [self presentViewController:alert animated:YES completion:nil];
    }
}

-(void) imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [picker dismissViewControllerAnimated:YES completion:nil];
}

-(void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    [self dismissViewControllerAnimated:YES completion:nil];
    UIImage *image = info[UIImagePickerControllerEditedImage];
    self.imageHolder.image = image;

    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSData *data = UIImagePNGRepresentation(imageHolder.image);
    [defaults setObject:data forKey:@"imagedata"];
    [defaults synchronize];
}

@end
