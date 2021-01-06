//
//  SKUser.m
//  SHKUN
//
//  Created by Gaurav Verma on 21/12/16.
//  Copyright © 2016 Gaurav Verma. All rights reserved.

#import "SKUser.h"
#import "Helper.h"

@implementation SKUser
@synthesize mDriverId,mFirstName,mMiddleName,mLastName,mUserName,mEmail,mPhoneNumber,mAdminId,mPinCode,mPassword,mSubscribeFrom,mSignatureUrl,mEmailVerified,mVerificationCode,mSubscribeTo,mCreatedDate,mAppVerified,mId,mExemptDriver,mExemptRemarks,mDotCarrierId,mCompanyName,mDriverHomeTimeZone,mCycleType,mDLIssueState,mDLNumber,mYardMove,mAuthorizedPersonalUseCMV,mPowerUnitNumber,mTrailerNumber,mTrailerNumber2,mTrailerNumber3,mShippingDocumentNumber,mAccountStatus,mPaymentStatus,mAutoRenewal,mDriverType,mDLExpiryDate ;

-(void)setupUser:(NSDictionary *)userDict {

    
    if ([userDict objectForKey:kDriverId]) {
        mDriverId = [userDict objectForKey:kDriverId];
    }else{
        mDriverId = @"";
    }
    if ([userDict objectForKey:kFirstName]) {
       mFirstName= [userDict objectForKey:kFirstName];
    }else{
       mFirstName = @"";
    }
    if ([userDict objectForKey:kMiddleName]) {
        mMiddleName= [userDict objectForKey:kMiddleName];
    }else{
        mMiddleName = @"";
    }
    if ([userDict objectForKey:kLastName]) {
        mLastName= [userDict objectForKey:kLastName];
    }else{
        mLastName = @"";
    }
    if ([userDict objectForKey:kUserName]) {
        mUserName= [userDict objectForKey:kUserName];
    }else{
        mUserName = @"";
    }
    if ([userDict objectForKey:kEmail]) {
        mEmail= [userDict objectForKey:kEmail];
    }else{
        mEmail = @"";
    }
    if ([userDict objectForKey:kPhoneNumber]) {
        mPhoneNumber= [userDict objectForKey:kPhoneNumber];
    }else{
        mPhoneNumber = @"";
    }
    if ([userDict objectForKey:kAdminId]) {
        mAdminId= [userDict objectForKey:kAdminId];
    }else{
        mAdminId = @"";
    }
    if ([userDict objectForKey:kPinCode]) {
        mPinCode= [userDict objectForKey:kPinCode];
    }else{
        mPinCode = @"";
    }
    if ([userDict objectForKey:kPassword]) {
        mPassword= [userDict objectForKey:kPassword];
    }else{
        mPassword = @"";
    }
    if ([userDict objectForKey:kSubscribeFrom]) {
        mSubscribeFrom= [userDict objectForKey:kSubscribeFrom];
    }else{
        mSubscribeFrom = @"";
    }
    if ([userDict objectForKey:kSignatureUrl]) {
        mSignatureUrl= [userDict objectForKey:kSignatureUrl];
    }else{
        mSignatureUrl = @"";
    }
    if ([userDict objectForKey:kEmailVerified]) {
        mEmailVerified = [userDict objectForKey:kEmailVerified];
    }else{
        mEmailVerified = @"";
    }
    if ([userDict objectForKey:kVerificationCode]) {
        mVerificationCode= [userDict objectForKey:kVerificationCode];
    }else{
        mVerificationCode = @"";
    }
    if ([userDict objectForKey:kSubscribeTo]) {
        mSubscribeTo= [userDict objectForKey:kSubscribeTo];
    }else{
        mSubscribeTo = @"";
    }
    if ([userDict objectForKey:kCreatedDate]) {
        mCreatedDate= [userDict objectForKey:kCreatedDate];
    }else{
        mCreatedDate = @"";
    }
    if ([userDict objectForKey:kAppVerified]) {
        mAppVerified= [userDict objectForKey:kAppVerified];
    }else{
        mAppVerified = @"";
    }
    if ([userDict objectForKey:kId]) {
        mId= [userDict objectForKey:kId];
    }else{
        mId = @"";
    }
    if ([userDict objectForKey:kExemptDriver]) {
        mExemptDriver= [userDict objectForKey:kExemptDriver];
    }else{
        mExemptDriver = @"";
    }
    if ([userDict objectForKey:kExemptRemarks]) {
        mExemptRemarks= [userDict objectForKey:kExemptRemarks];
    }else{
        mExemptRemarks = @"";
    }
    if ([userDict objectForKey:kDotCarrierId]) {
        mDotCarrierId= [userDict objectForKey:kDotCarrierId];
    }else{
        mDotCarrierId = @"";
    }
    if ([userDict objectForKey:kCompanyName]) {
        mCompanyName= [userDict objectForKey:kCompanyName];
    }else{
        mCompanyName = @"";
    }
    if ([userDict objectForKey:kDriverHomeTimeZone]) {
        mDriverHomeTimeZone= [userDict objectForKey:kDriverHomeTimeZone];
    }else{
        mDriverHomeTimeZone = @"";
    }
    if ([userDict objectForKey:kCycleType]) {
        mCycleType= [userDict objectForKey:kCycleType];
    }else{
        mCycleType = @"";
    }
    if ([userDict objectForKey:kDLIssueState]) {
        mDLIssueState= [userDict objectForKey:kDLIssueState];
    }else{
        mDLIssueState = @"";
    }
    if ([userDict objectForKey:kDLNumber]) {
        mDLNumber= [userDict objectForKey:kDLNumber];
    }else{
        mDLNumber = @"";
    }
    if ([userDict objectForKey:kYardMove]) {
        mYardMove= [userDict objectForKey:kYardMove];
    }else{
        mYardMove = @"";
    }
    if ([userDict objectForKey:kAuthorizedPersonalUseCMV]) {
        mAuthorizedPersonalUseCMV= [userDict objectForKey:kAuthorizedPersonalUseCMV];
    }else{
        mAuthorizedPersonalUseCMV = @"";
    }
    if ([userDict objectForKey:kPowerUnitNumber]) {
        mPowerUnitNumber= [userDict objectForKey:kPowerUnitNumber];
    }else{
        mPowerUnitNumber = @"";
    }
    if ([userDict objectForKey:kTrailerNumber]) {
        mTrailerNumber= [userDict objectForKey:kTrailerNumber];
    }else{
        mTrailerNumber = @"";
    }
    if ([userDict objectForKey:kTrailerNumber2]) {
        mTrailerNumber2= [userDict objectForKey:kTrailerNumber2];
    }else{
        mTrailerNumber2 = @"";
    }
    if ([userDict objectForKey:kTrailerNumber3]) {
        mTrailerNumber3= [userDict objectForKey:kTrailerNumber3];
    }else{
        mTrailerNumber3 = @"";
    }
    if ([userDict objectForKey:kShippingDocumentNumber]) {
        mShippingDocumentNumber= [userDict objectForKey:kShippingDocumentNumber];
    }else{
        mShippingDocumentNumber = @"";
    }
    if ([userDict objectForKey:kAccountStatus]) {
        mAccountStatus= [userDict objectForKey:kAccountStatus];
    }else{
        mAccountStatus = @"";
    }
    if ([userDict objectForKey:kPaymentStatus]) {
        mPaymentStatus= [userDict objectForKey:kPaymentStatus];
    }else{
        mPaymentStatus = @"";
    }
    if ([userDict objectForKey:kAutoRenewal]) {
        mAutoRenewal= [userDict objectForKey:kAutoRenewal];
    }else{
        mAutoRenewal = @"";
    }
    if ([userDict objectForKey:kDriverType]) {
        mDriverType= [userDict objectForKey:kDriverType];
    }else{
        mDriverType = @"";
    }
    if ([userDict objectForKey:kDLExpiryDate]) {
        mDLExpiryDate= [userDict objectForKey:kDLExpiryDate];
    }else{
        mDLExpiryDate = @"";
    }


}




-(void)setupCurrentUser:(NSDictionary *)userDict driverName:(NSString *)driverRef
{
    SKUser *CurrentUser = [[SKUser alloc] init];
    [CurrentUser setupUser:userDict];
    
    NSMutableDictionary *mCurrentUserDict = [[NSMutableDictionary alloc] init];
    [mCurrentUserDict setObject:CurrentUser.mDriverId forKey:kDriverId];
    [mCurrentUserDict setObject:CurrentUser.mFirstName forKey:kFirstName];
    [mCurrentUserDict setObject:CurrentUser.mMiddleName forKey:kMiddleName];
    [mCurrentUserDict setObject:CurrentUser.mLastName forKey:kLastName];
    [mCurrentUserDict setObject:CurrentUser.mUserName forKey:kUserName];
    [mCurrentUserDict setObject:CurrentUser.mEmail forKey:kEmail];
    [mCurrentUserDict setObject:CurrentUser.mPhoneNumber forKey:kPhoneNumber];
    [mCurrentUserDict setObject:CurrentUser.mAdminId forKey:kAdminId];
    [mCurrentUserDict setObject:CurrentUser.mPinCode forKey:kPinCode];
    [mCurrentUserDict setObject:CurrentUser.mPassword forKey:kPassword];
    [mCurrentUserDict setObject:CurrentUser.mSubscribeFrom forKey:kSubscribeFrom];
    [mCurrentUserDict setObject:CurrentUser.mSignatureUrl forKey:kSignatureUrl];
    [mCurrentUserDict setObject:CurrentUser.mEmailVerified forKey:kEmailVerified];
    [mCurrentUserDict setObject:CurrentUser.mVerificationCode forKey:kVerificationCode];
    [mCurrentUserDict setObject:CurrentUser.mSubscribeTo forKey:kSubscribeTo];
    [mCurrentUserDict setObject:CurrentUser.mCreatedDate forKey:kCreatedDate];
    [mCurrentUserDict setObject:CurrentUser.mAppVerified forKey:kAppVerified];
    [mCurrentUserDict setObject:CurrentUser.mId forKey:kId];
    [mCurrentUserDict setObject:CurrentUser.mExemptDriver forKey:kExemptDriver];
    [mCurrentUserDict setObject:CurrentUser.mExemptRemarks forKey:kExemptRemarks];
    [mCurrentUserDict setObject:CurrentUser.mDotCarrierId forKey:kDotCarrierId];
    [mCurrentUserDict setObject:CurrentUser.mCompanyName forKey:kCompanyName];
    [mCurrentUserDict setObject:CurrentUser.mDriverHomeTimeZone forKey:kDriverHomeTimeZone];
    [mCurrentUserDict setObject:CurrentUser.mCycleType forKey:kCycleType];
    [mCurrentUserDict setObject:CurrentUser.mDLIssueState forKey:kDLIssueState];
    [mCurrentUserDict setObject:CurrentUser.mDLNumber forKey:kDLNumber];
    [mCurrentUserDict setObject:CurrentUser.mYardMove forKey:kYardMove];
    [mCurrentUserDict setObject:CurrentUser.mAuthorizedPersonalUseCMV forKey:kAuthorizedPersonalUseCMV];
    [mCurrentUserDict setObject:CurrentUser.mPowerUnitNumber forKey:kPowerUnitNumber];
    [mCurrentUserDict setObject:CurrentUser.mTrailerNumber forKey:kTrailerNumber];
    [mCurrentUserDict setObject:CurrentUser.mTrailerNumber2 forKey:kTrailerNumber2];
    [mCurrentUserDict setObject:CurrentUser.mTrailerNumber3 forKey:kTrailerNumber3];
    [mCurrentUserDict setObject:CurrentUser.mShippingDocumentNumber forKey:kShippingDocumentNumber];
    [mCurrentUserDict setObject:CurrentUser.mAccountStatus forKey:kAccountStatus];
    [mCurrentUserDict setObject:CurrentUser.mPaymentStatus forKey:kPaymentStatus];
    [mCurrentUserDict setObject:CurrentUser.mAutoRenewal forKey:kAutoRenewal];
    [mCurrentUserDict setObject:CurrentUser.mDriverType forKey:kDriverType];
    [mCurrentUserDict setObject:CurrentUser.mDLExpiryDate forKey:kDLExpiryDate];


    NSUserDefaults *Settings = [NSUserDefaults standardUserDefaults];
    NSData *dataSave = [NSKeyedArchiver archivedDataWithRootObject:mCurrentUserDict];
    [Settings setObject:dataSave forKey:driverRef];
    [Settings synchronize];
    NSLog(@"Save Current User = %@",mCurrentUserDict);
    
}


-(void)UpdateCurrentUser:(NSString *)PinCode userDictt:(NSMutableDictionary *)userDict driverName:(NSString *)driverRef
{
    
    SKUser *CurrentUser = [[SKUser alloc] init];
    [CurrentUser setupUser:userDict];
    
    NSMutableDictionary *mCurrentUserDict = [[NSMutableDictionary alloc] init];
    
    [mCurrentUserDict setObject:PinCode forKey:kPinCode];
    
    
    NSUserDefaults *Settings = [NSUserDefaults standardUserDefaults];
   // [Settings setObject:mCurrentUserDict forKey:driverRef];
    
    NSData *dataSave = [NSKeyedArchiver archivedDataWithRootObject:mCurrentUserDict];
    [Settings setObject:dataSave forKey:driverRef];
    
    [Settings synchronize];
    NSLog(@"Update Current User = %@",[[Helper mCurrentUser:kCurrentUserOne]mutableCopy]);
    
}



/*
 
 -(void)UpdateCurrentUser:(NSString *)UserName country:(NSString *)Country mobileno:(NSString *)MobileNo userimage:(NSString *)UserImage userDictt:(NSMutableDictionary *)userDict{
 SKUser *CurrentUser = [[SKUser alloc] init];
 [CurrentUser setupUser:userDict];
 
 NSMutableDictionary *mCurrentUserDict = [[NSMutableDictionary alloc] init];
 [mCurrentUserDict setObject:CurrentUser.mEmail forKey:kEmail];
 [mCurrentUserDict setObject:CurrentUser.mFirstName forKey:kFirst_name];
 [mCurrentUserDict setObject:CurrentUser.mUsers_Id forKey:kUserId];
 
 if (UserName) {
 [mCurrentUserDict setObject:UserName forKey:kFirst_name];
 
 }
 else{
 [mCurrentUserDict setObject:CurrentUser.mFirstName forKey:kFirst_name];
 }
 
 NSUserDefaults *Settings = [NSUserDefaults standardUserDefaults];
 //[Settings setObject:mCurrentUserDict forKey:@"CurrentUser"];
 NSData *dataSave = [NSKeyedArchiver archivedDataWithRootObject:mCurrentUserDict];
 [Settings setObject:dataSave forKey:@"CurrentUser"];
 
 [Settings synchronize];
 NSLog(@"Update Current User = %@",mCurrentUserDict);
 }

 
 NSMutableArray * vriableArray = [[NSMutableArray alloc]initWithObjects:mDriverId,mFirstName,mMiddleName,mLastName,mUserName,mEmail,mPhoneNumber,mAdminId,mPinCode,mPassword,mSubscribeFrom,mSignatureUrl,mEmailVerified,mVerificationCode,mSubscribeTo,mCreatedDate,mAppVerified,mId,mExemptDriver,mExemptRemarks,mDotCarrierId,mCompanyName,mDriverHomeTimeZone,mCycleType,mDLIssueState,mDLNumber,mYardMove,mAuthorizedPersonalUseCMV,mPowerUnitNumber,mTrailerNumber,mTrailerNumber2,mTrailerNumber3,mShippingDocumentNumber,mAccountStatus,mPaymentStatus,mAutoRenewal,nil];
 
 NSMutableArray * constantsArray = [[NSMutableArray alloc]initWithObjects:kDriverId,kFirstName,kMiddleName,kLastName,kUserName,kEmail,kPhoneNumber,kAdminId,kPinCode,kPassword,kSubscribeFrom,kSignatureUrl,kEmailVerified,kVerificationCode,kSubscribeTo,kCreatedDate,kAppVerified,kId,kExemptDriver,kExemptRemarks,kDotCarrierId,kCompanyName,kDriverHomeTimeZone,kCycleType,kDLIssueState,kDLNumber,kYardMove,kAuthorizedPersonalUseCMV,kPowerUnitNumber,kTrailerNumber,kTrailerNumber2,kTrailerNumber3,kShippingDocumentNumber,kAccountStatus,kPaymentStatus,kAutoRenewal,nil];
 
 
 
 for (int i = 0 ; i <= vriableArray.count ; i++ ) {
 
 if ([userDict objectForKey:[constantsArray objectAtIndex:i]]) {
 
 NSObject *obj =  [vriableArray objectAtIndex:i];
 obj = [userDict objectForKey:[constantsArray objectAtIndex:i]];
 
 
 }else{
 NSObject *obj =  [vriableArray objectAtIndex:i];
 obj = @"";
 }
 
 
 
 */


@end
