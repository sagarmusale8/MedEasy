//
//  CheckIfUserExists.h
//  MedEasy
//
//  Created by Sagar Musale on 11/07/15.
//  Copyright (c) 2015 Sagar Musale. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Parse/Parse.h>

@protocol CheckIfUserExists <NSObject>

-(void)userExistWithGivenUid;
-(void)userDoesNotExistWithGivenUid;
-(void)userExistError:(NSError *)error;
@end

@interface CheckIfUserExists : NSObject

@property (nonatomic,assign) id delegate;
-(void) checkIfUserExistsWithUID:(NSString *)uid;
@end
