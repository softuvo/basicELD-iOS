//
//  Constants.h
//  VermaTestFirebase
//
//  Created by Gaurav Verma on 21/10/16.
//  Copyright © 2016 Gaurav Verma. All rights reserved.
//

#ifndef Constants_h
#define Constants_h



//Local
//http://112.196.72.187/basic_eld/


//#define kServiceBaseURL @"http://112.196.72.187/basic_eld/web_services/app/"
#define kServiceBaseURL @"http://112.196.72.187/basic_eld/web_services/AppTest/"

#define KserviceBaseImageURL @"http://112.196.72.187/basic_eld/uploads/documents/"
#define kImageBaseURL @"http://112.196.72.187/simple_eld-production/profileusrimg/"
#define kDocumentImageBaseURL @"http://112.196.72.187/simple_eld-production/catfolder/"


#define IS_PHONE (UIUserInterfaceIdiomPhone == [[UIDevice currentDevice] userInterfaceIdiom])
#define IS_IOS7 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
#define IS_IOS8 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
#define IS_IPHONE5 ([[UIScreen mainScreen] bounds].size.width == 320 && [[UIScreen mainScreen] bounds].size.height > 480)
#define IS_IPHONE4 ([[UIScreen mainScreen] bounds].size.width == 320 && [[UIScreen mainScreen] bounds].size.height == 480)

#define USER_DEFAULTS [NSUserDefaults standardUserDefaults]
#define USERDEFAULTS(arg)[[NSUserDefaults standardUserDefaults] objectForKey:arg]


#define appDelegate ((AppDelegate *)[[UIApplication sharedApplication] delegate])

#define kMyRiadRegular(size) [UIFont fontWithName:@"MyriadPro-Regular" size:size];
#define kMyRiadBold(size) [UIFont fontWithName:@"MyriadPro-Bold" size:size];
#define kMyRiadSemiBold(size) [UIFont fontWithName:@"MyriadPro-Semibold" size:size];




#define DM [DataManager sharedDataManager]
#define kNOInternet @"Network unavailable, please check."
#define CheckForNull(sourceStr) [Helper checkNull:sourceStr];




#define kprofile @"profile"
#define ksocial_login @"social_login"

#define kInternetAlertMsg @"Your device is not connected to Internet. Please check your Internet Connection."

#define kDataVersion @"DataVersion"

#define USER_DEFAULTS [NSUserDefaults standardUserDefaults]
#define USERDEFAULTS(arg)[[NSUserDefaults standardUserDefaults] objectForKey:arg]

#define KGender @"no"
#define KFemale @"female"
#define KMale @"male"

#define kDeleteContact @"DeleteContact"
#define kDeleteCategory @"DeleteCategory"

#define kSessionExiredString @"Your Session is Expired"

#define kPOST @"POST"
#define kGET @"GET"

// BasicELD

#define kLogin @"loginDriver"
#define kregister @"registerDriver"
#define kCurrentUser @"CurrentUser"
#define kCurrentUserOne @"CurrentUserOne"
#define kCurrentUserTwo @"CurrentUserTwo"

#define kLoginTypeSingle @"single"
#define kLoginTypeTeam @"team"

// Status Type

#define KDutyStatusPopupNotification @"DutyStatusPopupNotification"


#define kGoogleMapAPIKey @"AIzaSyCR3wibuBJ3dpJuabNXvtwP05xcZbMOCiE"


#define kStatusTypeDriving @"driving"
#define kStatusTypeOnDuty @"onduty"
#define kStatusTypeOffDuty @"offduty"
#define kStatusTypeSleeper @"sleeper"
#define kStatusTypeEditLog @"EditLog"

//#define kStatusTypePersonalUse @"offDuty_PersonalUse"
//#define kStatusTypeYardMove @"onDuty_YardMove"


#define kStatusTypePersonalUse @"PersonalUse"
#define kStatusTypeYardMove @"YardMove"

#define kEditStatusTypePersonalUse @"Personal Use"
#define kEditStatusTypeYardMove @"Yard Move"


#define kUserLoggedInType @"UserLoggedInType"
#define kPlaceHolderChangeNotification @"PlaceHolderChangeNotification"

#define KDutyStatusPopupNotification @"DutyStatusPopupNotification"

#define kSelectedDriverOne @"driverone"
#define kSelectedDrivertwo @"drivertwo"

// user Details

#define kDriverId                   @"driver_id"
#define kFirstName                  @"first_name"
#define kMiddleName                 @"middle_name"
#define kLastName                   @"last_name"
#define kUserName                   @"user_name"
#define kEmail                      @"email"
#define kPhoneNumber                @"phone_number"
#define kAdminId                    @"admin_id"
#define kPinCode                    @"pin_code"
#define kPassword                   @"password"
#define kSubscribeFrom              @"subscribe_from"
#define kSignatureUrl               @"signature_url"
#define kEmailVerified              @"email_verified"
#define kVerificationCode           @"verification_code"
#define kSubscribeTo                @"subscribe_to"
#define kCreatedDate                @"created_date"
#define kAppVerified                @"app_verified"
#define kId                         @"id"
#define kExemptDriver               @"exempt_driver"
#define kExemptRemarks              @"exempt_remarks"
#define kDotCarrierId               @"dot_carrier_id"
#define kCompanyName                @"company_name"
#define kDriverHomeTimeZone         @"driver_home_time_zone"
#define kCycleType                  @"cycle_type"
#define kDLIssueState               @"dl_issue_state"
#define kDLNumber                   @"DL_number"
#define kYardMove                   @"yardMoveAuth"
#define kAuthorizedPersonalUseCMV   @"personalUseAuth"
#define kPowerUnitNumber            @"power_unit_number"
#define kTrailerNumber              @"trailer_number"
#define kTrailerNumber2             @"trailer_number2"
#define kTrailerNumber3             @"trailer_number3"
#define kShippingDocumentNumber     @"shipping_document_number"
#define kAccountStatus              @"account_status"
#define kPaymentStatus              @"payment_status"
#define kAutoRenewal                @"auto_renewal"
#define kDriverType                 @"driver_type"
#define kDLExpiryDate               @"DL_expiry_date"





#define degreesToRadians(degrees) (M_PI * degrees / 180.0)

#define kEditLogs @"EditLogs"
#define kInsertLogs @"InsertLogs"
#define kCurrentDutyLogs @"CurrentDutyLogs"

#define kExempt_Driver @"Exempt-Driver"
#define kDriver @"Driver"
#define kNon_Driver @"Non-Driver"

#define kYes @"Yes"
#define kNo @"No"
#define kZero @"0"
#define kOne @"1"

#define kCycleRuleOne @"USA 70 hours /8 days"
#define kCycleRuleTwo @"USA 60 hours /7 days"
#define kCycleRuleThree @"California 80 hours /8 days"
#define kCycleRuleFour @"Texas 70 hours / 7 days"
#define kCycleRuleFive @"Alaska 70 hours /7 days"
#define kCycleRuleSix @"Alaska 80 hours /8 days"
#define kCycleRuleSeven @"Canada South 70 hours / 7 days"
#define kCycleRuleEight @"Canada South 120 hours / 14 days"
#define kCycleRuleNine @"Canada South Oil and Gas"
#define kCycleRuleTen @"Canada North 80 hours / 7 days"
#define kCycleRuleElaven @"Canada North 120 hours /  14 days"
#define kCycleRuleTwelav @"Others"



#define kCycleRuleOneID @"1"
#define kCycleRuleTwoID @"2"
#define kCycleRuleThreeID @"3"
#define kCycleRuleFourID @"4"
#define kCycleRuleFiveID @"5"
#define kCycleRuleSixID @"6"
#define kCycleRuleSevenID @"7"
#define kCycleRuleEightID @"8"
#define kCycleRuleNineID @"9"
#define kCycleRuleTenID @"10"
#define kCycleRuleElavenID @"11"
#define kCycleRuleTwelavID @"12"

#define kCargoTypeProperty @"Property"
#define kCargoTypePassenger @"Passenger"
#define kCargoTypeOilAndGas @"Oil And Gas"

#define kRestartType34HourRestart @"34 Hour Restart"
#define kRestartType24HourRestart @"24 Hour Restart"

#define kRestBreakThirtyMinuteRestBreakRequired @"30 Minute Rest Break Required"
#define kRestBreakNoRestBreakRequired @"No Rest Break Required"


#define kWellSiteWaitingTimeOnFifthLine @"Waiting Time on 5th Line"
#define kWellSiteNoWaitingTimeException @"No Waiting Time Exception"

#define kShortHaulNoException @"No Exception"
#define kShortHaulSixteenHourShortException @"16 Hour Short Exception"

#define kFarmSchoolBusExceptionNoException @"No Exception"
//#define kFarmSchoolBusExceptionSixteenHourShortException @"16 Hour Short Exception"
#define kFarmSchoolBusExceptionSixteenHourShortException @"Farm School Bus Exception"




#define kRestBreakThirtyMinuteRestBreakRequired @"30 Minute Rest Break Required"
#define kRestBreakNoRestBreakRequired @"No Rest Break Required"


#define kViewFrame1 CGRectMake(0, 30, 320, 79)
#define kViewFrame2 CGRectMake(0, 109, 320, 79)
#define kViewFrame3 CGRectMake(0, 188, 320, 79)
#define kViewFrame4 CGRectMake(0, 267, 320, 79)
#define kViewFrame5 CGRectMake(0, 346, 320, 79)

#define kOptionViewframe1  CGRectMake(0, 188, 320, 425)
#define kOptionViewframe2  CGRectMake(0, 109, 320, 425)

#define kContentViewframe1  CGRectMake(0, 0, 320, 613)
#define kContentViewframe2  CGRectMake(0, 0, 320, 534)
#define kContentViewframe3  CGRectMake(0, 0, 320, 455)

#define kNOTIFICATION_UpdateCycleRules @"No Rest Break Required"

#define kisCertified @"isCertified"
#define kisrecertified @"isrecertified"
#define ktrue @"true"
#define kfalse @"false"
#define kCheckForAlerts @"checkForAlerts"



/*
 
  
NSString * path = [NSString stringWithFormat:@"%@",kServiceBaseURL];

NSMutableDictionary * parameter = [[NSMutableDictionary alloc]init];
[parameter setValue:@"" forKey:@""];

[DM PostRequest:path parameter:parameter onCompletion:^(id  _Nullable dict) {
    
    NSError *errorJson=nil;
    NSDictionary* responseDict = [NSJSONSerialization JSONObjectWithData:dict options:kNilOptions error:&errorJson];
    NSLog(@"%@",responseDict);
    if ([[responseDict valueForKey:@"responsestatus"] integerValue] == 0) {
        NSString *ErrorString = [NSString stringWithFormat:@"%@",[responseDict valueForKey:@"message"]];
        [Helper ISAlertTypeError:@"Error!!" andMessage:ErrorString];
    }
    else{
        NSLog(@"%@",responseDict);
        dispatch_async(dispatch_get_main_queue(), ^{
            //reload tableview here
        });
    }
    
} onError:^(NSError * _Nullable Error) {
    NSLog(@"%@",Error);
    NSString *ErrorString = [NSString stringWithFormat:@"%@",Error];
    [Helper ISAlertTypeError:@"Error!!" andMessage:ErrorString];
}];

*/



#endif /* Constants_h */

