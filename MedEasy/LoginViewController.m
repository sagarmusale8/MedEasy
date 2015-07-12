//
//  LoginViewController.m
//  MedEasy
//
//  Created by Sagar Musale on 11/07/15.
//  Copyright (c) 2015 Sagar Musale. All rights reserved.
//

#import "LoginViewController.h"
#import "SignInViewController.h"
#import "LoginService.h"
#import "SessionModel.h"
#import "GetUserDetailsService.h"
#import "Common.h"

@interface LoginViewController ()
@property (strong, nonatomic) IBOutlet UITextField *txtUid;
@property (strong, nonatomic) IBOutlet UITextField *txtPassword;
@property (strong, nonatomic) IBOutlet UIButton *btnLogin;
@property (strong, nonatomic) IBOutlet UIButton *btnSignin;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

@end

@implementation LoginViewController
@synthesize txtUid;
@synthesize txtPassword;
@synthesize btnLogin;
@synthesize btnSignin;
@synthesize activityIndicator;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    btnLogin.layer.cornerRadius = 5;
    activityIndicator.layer.cornerRadius = 5;
    activityIndicator.hidden = YES;
    [self checkForExistingUser];
}

-(void) checkForExistingUser{
    
    if(![[SessionModel sharedManager].mCurrentUser.mUHID isEqualToString:@""] && [SessionModel sharedManager].mCurrentUser.mUHID != NULL){
        activityIndicator.hidden = NO;
        [activityIndicator startAnimating];
        GetUserDetailsService *getUserDetials = [[GetUserDetailsService alloc] init];
        getUserDetials.delegate = self;
        [getUserDetials getUserDetailsForUID:[SessionModel sharedManager].mCurrentUser.mUHID ];
        NSLog(@"Got existing user");
    }
    else
        NSLog(@"No existing user");
}

#pragma mark - GetUserDetailsService delegates
-(void) gotUserDetailsSuccessfully:(PFObject *)user{
    PF_User *userData = [[PF_User alloc] init];
    
    userData.mUHID = [user objectForKey:col_UID];
    userData.objectId = user.objectId;
    
    [[SessionModel sharedManager] setCurrentUser:userData];
    [activityIndicator stopAnimating];
    activityIndicator.hidden = YES;
    
    txtUid.text = @"";
    txtPassword.text = @"";
    [self performSegueWithIdentifier:@"SegueFromLoginToUploadDocs" sender:self];
}

-(void) userDetailsFails:(NSError *)error{
    [activityIndicator stopAnimating];
    activityIndicator.hidden = YES;
}

- (IBAction)btnLoginAction:(id)sender {

    if([Helper checkRequireFields:[[NSArray alloc] initWithObjects:txtUid, txtPassword, nil] ])
    {
        if ([txtUid.text length] == 12) {
            [self getUserLoginWithUid:txtUid.text withPassword:txtPassword.text];
        }
        else
        {
                [Helper showAlertWithTitle:@"Invalid information" withMessage:@"Please enter valid information" withCancelButton:@"Cancel"];
        }
    }
    else
    {
        [Helper showAlertWithTitle:@"Enter all required details" withMessage:@"Please enter all requiured details" withCancelButton:@"Cancel"];
    }
}

-(void)getUserLoginWithUid:(NSString *)uid withPassword:(NSString *)password{
    [activityIndicator startAnimating];
    activityIndicator.hidden = NO;
    LoginService *loginService = [[LoginService alloc] init];
    loginService.delegate = self;
    [loginService getUserLoginWithUID:uid withPassword:password];
}

#pragma mark - LoginService Delegates

-(void)userDoesNotExists{
    [activityIndicator stopAnimating];
    activityIndicator.hidden = YES;
    [Helper showAlertWithTitle:@"Invalid Data" withMessage:@"Please enter valid UHID and password." withCancelButton:@"Try again"];
}

-(void)userLoginSuccessfully{
    NSLog(@"Login Successfull.");
    GetUserDetailsService *getUserDetials = [[GetUserDetailsService alloc] init];
    getUserDetials.delegate = self;
    [getUserDetials getUserDetailsForUID:txtUid.text];
}

-(void)userLoginFailureWithError:(NSError *)error{
    NSLog(@"Login Error: %@", error.description);
    [activityIndicator stopAnimating];
    activityIndicator.hidden = YES;
    [Helper showAlertWithTitle:@"Error" withMessage:@"Error while fetching data" withCancelButton:@"Try Again"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
