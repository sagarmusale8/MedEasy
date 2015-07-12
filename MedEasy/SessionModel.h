//
//  SessionModel.h
//  MedEasy
//
//  Created by Sagar Musale on 11/07/15.
//  Copyright (c) 2015 Sagar Musale. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PF_User.h"

@interface SessionModel : NSObject

+ (SessionModel *)sharedManager;
-(void)setCurrentUser:(PF_User *)user;

@property (nonatomic, readwrite) PF_User *mCurrentUser;

@end
