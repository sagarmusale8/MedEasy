//
//  UploadDocsViewController.m
//  MedEasy
//
//  Created by Sagar Musale on 11/07/15.
//  Copyright (c) 2015 Sagar Musale. All rights reserved.
//

#import "UploadDocsViewController.h"
#import "Common.h"
#import "Helper.h"

@interface UploadDocsViewController()
@property (strong, nonatomic) IBOutlet UIButton *btnUploadMedicalHistory;
@property (strong, nonatomic) IBOutlet UIButton *btnViewMedicalHistory;
@end

@implementation UploadDocsViewController{
    UIBarButtonItem *btnLogout;
}

@synthesize btnUploadMedicalHistory;
@synthesize btnViewMedicalHistory;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    btnLogout = [[UIBarButtonItem alloc] initWithTitle:@"Logout" style:UIBarButtonItemStylePlain target:self action:@selector(getLogout)];
    
    [self.navigationItem setTitle:@"Welcome to MedEasy"];
    self.navigationItem.hidesBackButton = YES;
    btnViewMedicalHistory.layer.cornerRadius = 5;
    btnUploadMedicalHistory.layer.cornerRadius = 5;
}

-(void)viewWillAppear:(BOOL)animated{
    self.navigationItem.rightBarButtonItem = btnLogout;
}

-(void)getLogout{
    [[NSUserDefaults standardUserDefaults] setValue:NULL forKey:key_CURRENT_USER];
    [Helper showAlertWithTitle:@"Logout Successfull" withMessage:@"You got logout successfull" withCancelButton:@"Log in"];
    [[self navigationController] popToRootViewControllerAnimated:YES];
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

