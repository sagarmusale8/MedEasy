//
//  SessionModel.m
//  MedEasy
//
//  Created by Sagar Musale on 11/07/15.
//  Copyright (c) 2015 Sagar Musale. All rights reserved.
//

#import "SessionModel.h"
#import "Common.h"

@implementation SessionModel
@synthesize mCurrentUser;

static SessionModel *_sharedManager = NULL;

-(id)init{
    
    self = [super init];
    
    self.mCurrentUser = [[PF_User alloc] init];
    
    if (![[[NSUserDefaults standardUserDefaults] valueForKey:key_CURRENT_USER] isEqualToString:@""] && [[NSUserDefaults standardUserDefaults] valueForKey:key_CURRENT_USER]  != NULL) {
        self.mCurrentUser.mUHID = [[NSUserDefaults standardUserDefaults] valueForKey:key_CURRENT_USER];
    }
    
    return self;
}

+ (SessionModel *)sharedManager
{
    if (!_sharedManager)
    {
        _sharedManager = [[SessionModel alloc] init];
    }
    
    return _sharedManager;
}

-(void)setCurrentUser:(PF_User *)user
{
    [SessionModel sharedManager].mCurrentUser = user;
    [[NSUserDefaults standardUserDefaults] setValue:user.mUHID forKey:key_CURRENT_USER];
    NSLog(@"val in session:%@, in defaults:%@", [SessionModel sharedManager].mCurrentUser.mUHID, [[NSUserDefaults standardUserDefaults] valueForKey:key_CURRENT_USER]);
}

-(PF_User *)getCurrentUser
{
    return [SessionModel sharedManager].mCurrentUser;
}

@end
