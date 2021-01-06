//
//  SKUser.h
//  SHKUN
//
//  Created by Gaurav Verma on 21/12/16.
//  Copyright © 2016 Gaurav Verma. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BLCountry.h"
#import "Constants.h"

@interface SKUser : NSObject


@property (nonatomic,copy) NSString       *mDriverId;
@property (nonatomic,copy) NSString       *mFirstName;
@property (nonatomic,copy) NSString       *mMiddleName;
@property (nonatomic,copy) NSString       *mLastName;
@property (nonatomic,copy) NSString       *mUserName;
@property (nonatomic,copy) NSString       *mEmail;
@property (nonatomic,copy) NSString       *mPhoneNumber;
@property (nonatomic,copy) NSString       *mAdminId;
@property (nonatomic,copy) NSString       *mPinCode;
@property (nonatomic,copy) NSString       *mPassword;
@property (nonatomic,copy) NSString       *mSubscribeFrom;
@property (nonatomic,copy) NSString       *mSignatureUrl;
@property (nonatomic,copy) NSString       *mEmailVerified;
@property (nonatomic,copy) NSString       *mVerificationCode;
@property (nonatomic,copy) NSString       *mSubscribeTo;
@property (nonatomic,copy) NSString       *mCreatedDate;
@property (nonatomic,copy) NSString       *mAppVerified;
@property (nonatomic,copy) NSString       *mId;
@property (nonatomic,copy) NSString       *mExemptDriver;
@property (nonatomic,copy) NSString       *mExemptRemarks;
@property (nonatomic,copy) NSString       *mDotCarrierId;
@property (nonatomic,copy) NSString       *mCompanyName;
@property (nonatomic,copy) NSString       *mDriverHomeTimeZone;
@property (nonatomic,copy) NSString       *mCycleType;
@property (nonatomic,copy) NSString       *mDLIssueState;
@property (nonatomic,copy) NSString       *mDLNumber;
@property (nonatomic,copy) NSString       *mYardMove;
@property (nonatomic,copy) NSString       *mAuthorizedPersonalUseCMV;
@property (nonatomic,copy) NSString       *mPowerUnitNumber;
@property (nonatomic,copy) NSString       *mTrailerNumber;
@property (nonatomic,copy) NSString       *mTrailerNumber2;
@property (nonatomic,copy) NSString       *mTrailerNumber3;
@property (nonatomic,copy) NSString       *mShippingDocumentNumber;
@property (nonatomic,copy) NSString       *mAccountStatus;
@property (nonatomic,copy) NSString       *mPaymentStatus;
@property (nonatomic,copy) NSString       *mAutoRenewal;
@property (nonatomic,copy) NSString       *mDriverType;
@property (nonatomic,copy) NSString       *mDLExpiryDate;





-(void)setupUser:(NSDictionary *)userDict;
-(void)setupCurrentUser:(NSDictionary *)userDict driverName:(NSString *)driverRef ;
-(void)UpdateCurrentUser:(NSString *)PinCode userDictt:(NSMutableDictionary *)userDict driverName:(NSString *)driverRef;






-(void)UpdateCurrentUser:(NSString *)UserName country:(NSString *)Country mobileno:(NSString *)MobileNo userimage:(NSString *)UserImage userDictt:(NSMutableDictionary *)userDict;





/*
 {
 "driver_id": "1",
 "first_name": "sukhwinder",
 "middle_name": "m name",
 "last_name": "L name",
 "user_name": "user",
 "email": "sukhwinder.kaur@softuvo.com",
 "phone_number": "(443) 646-4465",
 "admin_id": "1",
 "pin_code": "1234",
 "password": "0dff271b880081d20674fed4d45b00fc",
 "subscribe_from": "0000-00-00 00:00:00",
 "signature_url": "",
 "email_verified": "1",
 "verification_code": "597c06fa6f462",
 "subscribe_to": "0000-00-00 00:00:00",
 "created_date": "2017-07-29 09:24:34",
 "app_verified": "1",
 "id": "1",
 "exempt_driver": "Yes",
 "exempt_remarks": "Remarks",
 "dot_carrier_id": "43",
 "company_name": "softuvo",
 "driver_home_time_zone": "Alaska",
 "cycle_type": "Alaska 70 hours /7 days",
 "dl_issue_state": "Alaska-USA",
 "DL_number": "43545",
 "yard_move": "No",
 "authorized_personal_use_cmv": "No",
 "power_unit_number": "1213213",
 "trailer_number": "tr12",
 "trailer_number2": "",
 "trailer_number3": "",
 "shipping_document_number": "sh12",
 "account_status": "No",
 "payment_status": "Past Due",
 "auto_renewal": "on"
 }
*/



@end





