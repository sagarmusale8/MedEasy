//
//  Helper.h
//  MedEasy
//
//  Created by Sagar Musale on 11/07/15.
//  Copyright (c) 2015 Sagar Musale. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Helper : NSObject

+ (Boolean) checkRequireFields:(NSArray *)allFields;
+(void) showAlertWithTitle:(NSString *)title withMessage:(NSString *)msg withCancelButton:(NSString *)cancelText;

@end
