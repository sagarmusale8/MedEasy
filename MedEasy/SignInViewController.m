//
//  SignInViewController.m
//  MedEasy
//
//  Created by Sagar Musale on 11/07/15.
//  Copyright (c) 2015 Sagar Musale. All rights reserved.
//

#import "SignInViewController.h"
#import "CheckIfUserExists.h"
#import "SignInService.h"
#import "Common.h"
#import "SessionModel.h"

@interface SignInViewController ()
@property (strong, nonatomic) IBOutlet UITextField *txtUid;
@property (strong, nonatomic) IBOutlet UITextField *txtPassword;
@property (strong, nonatomic) IBOutlet UITextField *txtRepassword;
@property (strong, nonatomic) IBOutlet UIButton *btnSignIn;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

@end

@implementation SignInViewController
@synthesize txtUid;
@synthesize txtPassword;
@synthesize txtRepassword;
@synthesize btnSignIn;
@synthesize activityIndicator;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"Sign in";
    
    activityIndicator.hidden = YES;
    
    btnSignIn.layer.cornerRadius = 5;
    activityIndicator.layer.cornerRadius = 5;
}

- (IBAction)btnSigninAction:(id)sender {
    
    if([Helper checkRequireFields:[[NSArray alloc] initWithObjects:txtUid, txtPassword, txtRepassword, nil] ])
    {
        if ([txtUid.text length] == 12 && [txtRepassword.text isEqualToString:txtPassword.text])
        {
            [self getUserSignInWithUID:txtUid.text withPassword:txtPassword.text];
        }
        else
        {
            [Helper showAlertWithTitle:@"Invalid information" withMessage:@"Please enter valid information" withCancelButton:@"OK"];
        }
    }
    else
    {
        [Helper showAlertWithTitle:@"Enter all required details" withMessage:@"Please enter all requiured details" withCancelButton:@"OK"];
    }
}

-(void) getUserSignInWithUID:(NSString *)uid withPassword:(NSString *)password{
    
    activityIndicator.hidden = NO;
    [activityIndicator startAnimating];
    CheckIfUserExists *userExistsService = [[CheckIfUserExists alloc] init];
    userExistsService.delegate = self;
    [userExistsService checkIfUserExistsWithUID:uid];
}

#pragma mark - CheckUserExists Delegate functions
-(void)userExistWithGivenUid{
    [activityIndicator stopAnimating];
    activityIndicator.hidden = YES;
    [Helper showAlertWithTitle:@"User already exists" withMessage:@"The given UHID is already registred" withCancelButton:@"Try Login"];
}

-(void)userDoesNotExistWithGivenUid{
    SignInService *signInService = [[SignInService alloc] init];
    signInService.delegate = self;
    [signInService getUserSignInWithUID:txtUid.text withPassword:txtPassword.text];
}

-(void)userExistError:(NSError *)error{
    [activityIndicator stopAnimating];
    activityIndicator.hidden = YES;
    [Helper showAlertWithTitle:@"Error" withMessage:@"Error in fetching data" withCancelButton:@"OK"];
    NSLog(@"User exists ERROR: %@", error);
}

#pragma mark - SignInService Delegate functions

-(void)userSignInSuccessfully{
    [activityIndicator stopAnimating];
    activityIndicator.hidden = YES;
    NSLog(@"User signed in Successfully");
    
    [SessionModel sharedManager].mCurrentUser.mUHID = txtUid.text;
    [[NSUserDefaults standardUserDefaults] setValue:txtUid.text forKey:key_CURRENT_USER];
    
    txtPassword.text = @"";
    txtRepassword.text = @"";
    txtUid.text = @"";
    [self performSegueWithIdentifier:@"SegueToBasicInfo" sender:self];
}

-(void)userSignInFailureWithError:(NSError *)error{
    [activityIndicator stopAnimating];
    activityIndicator.hidden = YES;
    [Helper showAlertWithTitle:@"Error" withMessage:@"Error in sign in of user" withCancelButton:@"Ok"];
    NSLog(@"Sign in error: %@", error.description);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
