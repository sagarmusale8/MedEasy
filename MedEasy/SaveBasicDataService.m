//
//  SaveBasicDataService.m
//  MedEasy
//
//  Created by Sagar Musale on 12/07/15.
//  Copyright (c) 2015 Sagar Musale. All rights reserved.
//

#import "SaveBasicDataService.h"
#import "SessionModel.h"

@implementation SaveBasicDataService
@synthesize delegate;

-(void)saveBasicData:(PF_User *)user{
    
    PFQuery *query = [PFQuery queryWithClassName:PF_USER];
    [query whereKey:col_UID equalTo:[SessionModel sharedManager].mCurrentUser.mUHID];
    [query getFirstObjectInBackgroundWithBlock:^(PFObject * userStats, NSError *error) {
        if (!error) {
            [userStats setValue:user.mFirstName forKey:col_FirstName];
            [userStats setValue:user.mLastName forKey:col_LastName];
            [userStats setValue:user.mEmail forKey:col_Email];
            [userStats setValue:user.mContactNumber forKey:col_Contact_Number];
            [userStats setValue:user.mBloodGroup forKey:col_Blood_Group];
            
            // Save
            [userStats saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                if (!error) {
                    [delegate basicDataSaveSucessfully];
                }
                else{
                    [delegate basicDataSaveFailuerWithError:error];
                }
            }];
        } else {
            // Did not find any UserStats for the current user
            NSLog(@"Error: %@", error);
        }
    }];
}
@end
