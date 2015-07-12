//
//  SignInService.h
//  MedEasy
//
//  Created by Sagar Musale on 11/07/15.
//  Copyright (c) 2015 Sagar Musale. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Parse/Parse.h>

@protocol SignInProtocol <NSObject>

-(void)userSignInSuccessfully;
-(void)userSignInFailureWithError:(NSError *)error;
@end

@interface SignInService : NSObject

@property (nonatomic,assign) id delegate;
-(void) getUserSignInWithUID:(NSString *)uid withPassword:(NSString *)password;

@end
