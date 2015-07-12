//
//  GetUserDetailsService.m
//  MedEasy
//
//  Created by Sagar Musale on 12/07/15.
//  Copyright (c) 2015 Sagar Musale. All rights reserved.
//

#import "GetUserDetailsService.h"
#import "Common.h"

@implementation GetUserDetailsService
@synthesize delegate;

-(void)getUserDetailsForUID:(NSString *)uid{
    
    PFQuery *getUserDetailsQuery = [PFQuery queryWithClassName:PF_USER];
    [getUserDetailsQuery whereKey:col_UID equalTo:uid];
    [getUserDetailsQuery findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error){
        if (error) {
            [delegate userDetailsFails:error];
        } else {
            if ([objects count] >= 1) {
                [delegate gotUserDetailsSuccessfully:[objects objectAtIndex:0]];
            }
            else
            {
                [delegate userDetailsFails:nil];
            }
        }
    }];
}

@end
