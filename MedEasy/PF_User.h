//
//  PF_User.h
//  MedEasy
//
//  Created by Sagar Musale on 11/07/15.
//  Copyright (c) 2015 Sagar Musale. All rights reserved.
//

#import <Parse/Parse.h>

@interface PF_User : PFObject<PFSubclassing>

+ (NSString *)parseClassName;

@property (nonatomic, readwrite) NSString *objectId;
@property (nonatomic, readwrite) NSString *mUHID;
@property (nonatomic, readwrite) NSString *mGender;
@property (nonatomic, readwrite) NSString *mEmail;
@property (nonatomic, readwrite) NSString *mFirstName;
@property (nonatomic, readwrite) NSString *mLastName;
@property (nonatomic, readwrite) NSString *mBloodGroup;
@property (nonatomic, readwrite) NSString *mContactNumber;

@end
