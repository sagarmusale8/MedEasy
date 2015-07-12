//
//  BasicUserInfoViewController.m
//  MedEasy
//
//  Created by Sagar Musale on 11/07/15.
//  Copyright (c) 2015 Sagar Musale. All rights reserved.
//

#import "BasicUserInfoViewController.h"
#import "Common.h"
#import "PF_User.h"
#import "Helper.h"
#import "SaveBasicDataService.h"
#import "SessionModel.h"

@interface BasicUserInfoViewController ()
@property (strong, nonatomic) IBOutlet UITextField *txtFirstName;
@property (strong, nonatomic) IBOutlet UITextField *txtLastName;
@property (strong, nonatomic) IBOutlet UITextField *txtBloodGroup;
@property (strong, nonatomic) IBOutlet UITextField *txtContactNumber;
@property (strong, nonatomic) IBOutlet UITextField *txtEmailAddress;
@property (strong, nonatomic) IBOutlet UIButton *btnSave;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

@end

@implementation BasicUserInfoViewController{
    UIBarButtonItem *btnLogout;
}
@synthesize btnSave;
@synthesize txtFirstName;
@synthesize txtLastName;
@synthesize txtBloodGroup;
@synthesize txtContactNumber;
@synthesize txtEmailAddress;
@synthesize activityIndicator;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    btnLogout = [[UIBarButtonItem alloc] initWithTitle:@"Logout" style:UIBarButtonItemStylePlain target:self action:@selector(getLogout)];
    
    [self.navigationItem setTitle:@"Profile"];
    self.navigationItem.hidesBackButton = YES;
    btnSave.layer.cornerRadius = 5;
    activityIndicator.layer.cornerRadius = 5;
    activityIndicator.hidden = YES;
}

-(void)viewWillAppear:(BOOL)animated{
    self.navigationItem.rightBarButtonItem = btnLogout;
}

-(void)getLogout{
    [[NSUserDefaults standardUserDefaults] setValue:NULL forKey:key_CURRENT_USER];
    [Helper showAlertWithTitle:@"Logout Successfull" withMessage:@"You got logout successfull" withCancelButton:@"Log in"];
    [[self navigationController] popToRootViewControllerAnimated:YES];
}

- (IBAction)btnSaveAction:(id)sender {

    if ([Helper checkRequireFields:[[NSArray alloc] initWithObjects:txtFirstName, txtLastName, txtEmailAddress, txtContactNumber, txtBloodGroup, nil]] ) {
        
        activityIndicator.hidden = NO;
        [activityIndicator startAnimating];
        
        PF_User *user = [[PF_User alloc] init];
        user.mFirstName = txtFirstName.text;
        user.mLastName = txtLastName.text;
        user.mEmail = txtEmailAddress.text;
        user.mContactNumber = txtContactNumber.text;
        user.mBloodGroup = txtBloodGroup.text;
        user.objectId = [SessionModel sharedManager].mCurrentUser.objectId;
        user.mUHID = [SessionModel sharedManager].mCurrentUser.mUHID;
        
        SaveBasicDataService *basicDataServ = [[SaveBasicDataService alloc] init];
        basicDataServ.delegate = self;
        [basicDataServ saveBasicData:user];
        
    }
}

#pragma mark - Saving basic info delegates
-(void)basicDataSaveSucessfully{
    
    [activityIndicator stopAnimating];
    activityIndicator.hidden = YES;
    
    [Helper showAlertWithTitle:@"Update Successfully" withMessage:@"Your data saved successfully" withCancelButton:@"Ok"];
    
    [self performSegueWithIdentifier:@"SegueFromBasicToUploadDocs" sender:self];
}

-(void)basicDataSaveFailuerWithError:(NSError *)error{
    
    [activityIndicator stopAnimating];
    activityIndicator.hidden = YES;
    
    [Helper showAlertWithTitle:@"Error" withMessage:@"Error while saving basic info" withCancelButton:@"Try again"];
    
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

@end
