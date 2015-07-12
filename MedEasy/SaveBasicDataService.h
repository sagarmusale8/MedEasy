//
//  SaveBasicDataService.h
//  MedEasy
//
//  Created by Sagar Musale on 12/07/15.
//  Copyright (c) 2015 Sagar Musale. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Parse/Parse.h>
#import "PF_User.h"
#import "Common.h"

@protocol BasicDataProtocol <NSObject>

-(void)basicDataSaveSucessfully;
-(void)basicDataSaveFailuerWithError:(NSError *)error;

@end

@interface SaveBasicDataService : NSObject

@property (nonatomic, assign) id delegate;
-(void)saveBasicData:(PF_User *)user;

@end
