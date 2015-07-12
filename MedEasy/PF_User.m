//
//  PF_User.m
//  MedEasy
//
//  Created by Sagar Musale on 11/07/15.
//  Copyright (c) 2015 Sagar Musale. All rights reserved.
//

#import "PF_User.h"
#import "Common.h"
#import <Parse/PFObject+Subclass.h>

@implementation PF_User
@dynamic objectId;
@dynamic mEmail;
@dynamic mFirstName;
@dynamic mLastName;
@dynamic mGender;
@dynamic mUHID;
@dynamic mContactNumber;
@dynamic mBloodGroup;

+ (NSString *)parseClassName {
    return PF_USER;
}

@end
