//
//  Helper.m
//  MedEasy
//
//  Created by Sagar Musale on 11/07/15.
//  Copyright (c) 2015 Sagar Musale. All rights reserved.
//

#import "Helper.h"

@implementation Helper

+ (Boolean) checkRequireFields:(NSArray *)allFields{
    
    for (UITextField *field in allFields) {
        if ([field.text isEqualToString:@""]) {
            return NO;
        }
    }
    
    return YES;
}

+(void) showPlzFillRequiredDetailsAlert{
    
    UIAlertView *plzFillRequiredDetailsAlert = [[UIAlertView alloc] initWithTitle:@"Enter all required details" message:@"Please enter all requiured details" delegate:nil cancelButtonTitle:@"Cancel" otherButtonTitles: nil];
    
    [plzFillRequiredDetailsAlert show];
}

+(void) showPlzEnterValidInfoAlert{
    
    UIAlertView *plzEnterValidInfoAlert = [[UIAlertView alloc] initWithTitle:@"Invalid information" message:@"Please enter valid information" delegate:nil cancelButtonTitle:@"Cancel" otherButtonTitles: nil];
    
    [plzEnterValidInfoAlert show];
}

+(void) showAlertWithTitle:(NSString *)title withMessage:(NSString *)msg withCancelButton:(NSString *)cancelText
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:msg delegate:nil cancelButtonTitle:cancelText otherButtonTitles: nil];
    
    [alert show];
}
@end
