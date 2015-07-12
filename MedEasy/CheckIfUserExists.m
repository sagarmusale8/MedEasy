//
//  CheckIfUserExists.m
//  MedEasy
//
//  Created by Sagar Musale on 11/07/15.
//  Copyright (c) 2015 Sagar Musale. All rights reserved.
//

#import "CheckIfUserExists.h"
#import "Common.h"

@implementation CheckIfUserExists
@synthesize delegate;

-(void) checkIfUserExistsWithUID:(NSString *)uid {
    
    PFQuery *checkUserExistsQuery = [PFQuery queryWithClassName:PF_USER];
    [checkUserExistsQuery whereKey:col_UID equalTo:uid];
    
    [checkUserExistsQuery findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (error) {
            [delegate userExistError:error];
        } else {
            if ([objects count] == 1) {
                [delegate userExistWithGivenUid];
            }
            else{
                [delegate userDoesNotExistWithGivenUid];
            }
        }
    }];
}
@end
