//
//  SavePrescriptionService.m
//  MedEasy
//
//  Created by Sagar Musale on 12/07/15.
//  Copyright (c) 2015 Sagar Musale. All rights reserved.
//

#import "SavePrescriptionService.h"
#import "Common.h"

@implementation SavePrescriptionService
@synthesize delegate;

-(void) savePrescriptionWithImage:(PFFile *)file forUser:(NSString *)objectId{
    
    [file saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (!error) {
            // The image has now been uploaded to Parse. Associate it with a new object
            PFObject* newPhotoObject = [PFObject objectWithClassName:PF_USER_DATA];
            [newPhotoObject setObject:file forKey:col_Prescription];
            [newPhotoObject setObject:[PFObject objectWithoutDataWithClassName:PF_USER objectId:objectId] forKey:col_User];
            
            [newPhotoObject saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                if (!error) {
                    [delegate prescriptionSavedSuccessfully];
                }
                else{
                    [delegate prescriptionSavedFailureWithError:error];
                }
            }];
        }
    }];
}

@end
