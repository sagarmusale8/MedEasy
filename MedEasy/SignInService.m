//
//  SignInService.m
//  MedEasy
//
//  Created by Sagar Musale on 11/07/15.
//  Copyright (c) 2015 Sagar Musale. All rights reserved.
//

#import "SignInService.h"
#import "Common.h"

@implementation SignInService
@synthesize delegate;

-(void) getUserSignInWithUID:(NSString *)uid withPassword:(NSString *)password{
    
    PFObject *userObj = [PFObject objectWithClassName:PF_USER];
    userObj[col_UID] = uid;
    userObj[col_Password] = password;
    [userObj saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            [delegate userSignInSuccessfully];
        } else {
            [delegate userSignInFailureWithError:error];
        }
    }];
}

@end
