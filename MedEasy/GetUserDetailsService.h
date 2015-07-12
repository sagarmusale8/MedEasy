//
//  GetUserDetailsService.h
//  MedEasy
//
//  Created by Sagar Musale on 12/07/15.
//  Copyright (c) 2015 Sagar Musale. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Parse/Parse.h>

@protocol GetUserDetailsProtocol <NSObject>

-(void) gotUserDetailsSuccessfully:(PFObject *)user;
-(void) userDetailsFails:(NSError *)error;
@end

@interface GetUserDetailsService : NSObject

@property (nonatomic, assign) id delegate;
-(void) getUserDetailsForUID:(NSString *)uid;
@end
