//
//  SavePrescriptionService.h
//  MedEasy
//
//  Created by Sagar Musale on 12/07/15.
//  Copyright (c) 2015 Sagar Musale. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Parse/Parse.h>

@protocol SavePrescriptionProtocol <NSObject>

-(void)prescriptionSavedSuccessfully;
-(void)prescriptionSavedFailureWithError:(NSError *)error;

@end

@interface SavePrescriptionService : NSObject

@property (nonatomic, assign) id delegate;
-(void) savePrescriptionWithImage:(PFFile *)file forUser:(NSString *)objectId;

@end
