//
//  UploadingDocsViewController.m
//  MedEasy
//
//  Created by Sagar Musale on 12/07/15.
//  Copyright (c) 2015 Sagar Musale. All rights reserved.
//

#import "UploadingDocsViewController.h"
#import "Helper.h"
#import "Common.h"
#import "SavePrescriptionService.h"
#import "SessionModel.h"

@interface UploadingDocsViewController ()
@property (strong, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) IBOutlet UIButton *btnTakePhoto;
@property (strong, nonatomic) IBOutlet UIButton *btnSelectPhoto;
@property (strong, nonatomic) IBOutlet UIButton *btnUploadSelectedPhoto;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

@end

@implementation UploadingDocsViewController{
    UIBarButtonItem *btnLogout;
}
@synthesize imageView;
@synthesize btnSelectPhoto;
@synthesize btnTakePhoto;
@synthesize btnUploadSelectedPhoto;
@synthesize activityIndicator;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationItem setTitle:@"Upload Docs"];
    
    activityIndicator.hidden = YES;
    btnTakePhoto.layer.cornerRadius = 5;
    btnSelectPhoto.layer.cornerRadius = 5;
    btnUploadSelectedPhoto.layer.cornerRadius = 5;
    activityIndicator.layer.cornerRadius = 5;
}


- (IBAction)takePhotoAction:(id)sender {
    
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        
        UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:@"Error"
                                                              message:@"Device has no camera"
                                                             delegate:nil
                                                    cancelButtonTitle:@"OK"
                                                    otherButtonTitles: nil];
        
        [myAlertView show];
        
    }
    else
    {
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        picker.allowsEditing = YES;
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        
        [self presentViewController:picker animated:YES completion:NULL];
    }
    
}

- (IBAction)selectPhotoAction:(id)sender {
    
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    [self presentViewController:picker animated:YES completion:NULL];
}

- (IBAction)uploadPhotoAction:(id)sender{

    if (imageView.image != NULL) {
        NSString *imageName = [[@"prescription" stringByAppendingString:TimeStamp] stringByAppendingString:@".jpg"];
        NSLog(@"Image name:%@", imageName);
        NSData* data = UIImageJPEGRepresentation(imageView.image, 0.5f);
        PFFile *imageFile = [PFFile fileWithName:@"prescription.jpg" data:data];
        
        SavePrescriptionService *savePrescriptionSrv = [[SavePrescriptionService alloc] init];
        savePrescriptionSrv.delegate = self;
        [self hideButtons];
        [savePrescriptionSrv savePrescriptionWithImage:imageFile forUser:[SessionModel sharedManager].mCurrentUser.objectId];
    }
    else
    {
        [Helper showAlertWithTitle:@"No image selected" withMessage:@"Please select or take image before uploading" withCancelButton:@"Try Again"];
    }
    
}

-(void)hideButtons{
    btnSelectPhoto.hidden = YES;
    btnTakePhoto.hidden = YES;
    btnUploadSelectedPhoto.hidden = YES;
    [activityIndicator startAnimating];
}

-(void)showButtons{
    btnSelectPhoto.hidden = NO;
    btnTakePhoto.hidden = NO;
    btnUploadSelectedPhoto.hidden = NO;
    [activityIndicator stopAnimating];
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - SavePrescriptionService delegate

-(void)prescriptionSavedSuccessfully{
    NSLog(@"Saved successfully");
    [Helper showAlertWithTitle:@"Uploaded successfully" withMessage:@"Prescription uploaded successfully." withCancelButton:@"Ok"];
    [self showButtons];
}

-(void)prescriptionSavedFailureWithError:(NSError *)error{
    [self showButtons];
    NSLog(@"Error in saving prescription: %@", error.userInfo);
}

#pragma mark - ImagePickerView Delegates

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
    self.imageView.image = chosenImage;
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}

@end
