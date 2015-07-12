//
//  LoginService.m
//  MedEasy
//
//  Created by Sagar Musale on 11/07/15.
//  Copyright (c) 2015 Sagar Musale. All rights reserved.
//

#import "LoginService.h"
#import "Common.h"

@implementation LoginService
@synthesize delegate;

-(void) getUserLoginWithUID:(NSString *)uid withPassword:(NSString *)password{
    
    PFQuery *loginQuery = [PFQuery queryWithClassName:PF_USER];
    [loginQuery whereKey:col_UID equalTo:uid];
    [loginQuery whereKey:col_Password equalTo:password];
    [loginQuery findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (error) {
            [delegate userLoginFailureWithError:error];
        } else {
            if ([objects count] == 1) {
                [delegate userLoginSuccessfully];
            }
            else{
                [delegate userDoesNotExists];
            }
        }
    }];
}
@end
