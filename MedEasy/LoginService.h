//
//  LoginService.h
//  MedEasy
//
//  Created by Sagar Musale on 11/07/15.
//  Copyright (c) 2015 Sagar Musale. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Parse/Parse.h>

@protocol LoginProtocol <NSObject>

-(void)userDoesNotExists;
-(void)userLoginSuccessfully;
-(void)userLoginFailureWithError:(NSError *)error;
@end

@interface LoginService : NSObject

@property (nonatomic, assign) id delegate;
-(void) getUserLoginWithUID:(NSString *)uid withPassword:(NSString *)password;

@end
