//
//  Common.h
//  MedEasy
//
//  Created by Sagar Musale on 11/07/15.
//  Copyright (c) 2015 Sagar Musale. All rights reserved.
//

// Keys
#define     PARSE_APPID             @"vAkl8slpTXV1QO2gNajhOZDKaFirwOsdqI21iWeR"
#define     PARSE_CLIENT_KEY    @"wnUPNYQQKKVcoonCdIQdNwWUv4uL4GwlIJikwMSQ"

// Parse Class names
#define     PF_USER                                         @"pf_user"
#define     PF_ALLERGIES                                @"pf_allergies"
#define     PF_HEREDETERY_DISEASES              @"pf_hereditory_deseases"
#define     PF_USER_ALLERGIES                       @"pf_user_allergies"
#define     PF_USER_HEREDETERY_DIESEASE     @"pf_user_heridatories_issues"
#define     PF_MEDICAL_INFO                             @"pf_medical_info"
#define     PF_USER_DATA                                @"pf_user_data"

// Parse columns

#define     col_UID             @"uid"
#define     col_Password    @"password"
#define     col_Email                   @"email"
#define     col_FirstName           @"first_name"
#define     col_LastName            @"last_name"
#define     col_Gender                 @"gender"
#define     col_Prescription            @"prescription"
#define     col_User                    @"user"
#define     col_Blood_Group         @"blood_group"
#define     col_Contact_Number      @"contact_info"

// NSUserDefault Keys

#define     key_CURRENT_USER        @"current_user_uid"

// Macro

#define     TimeStamp   [NSString stringWithFormat:@"%d",[[NSDate date] timeIntervalSince1970] * 1000]