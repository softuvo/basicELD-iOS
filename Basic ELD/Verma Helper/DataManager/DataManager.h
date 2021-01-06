//
//  DataManager.h
//  VermaTestFirebase
//
//  Created by Gaurav Verma on 21/10/16.
//  Copyright © 2016 Gaurav Verma. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Reachability.h"
#import "Constants.h"
#import "SVProgressHUD.h"
#import "Helper.h"
#import "AFNetworking.h"

#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>
#import <CoreMotion/CoreMotion.h>

#define IS_OS_8_OR_LATER ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)

#pragma mark - Block Definitions

typedef void(^JSonRepresentation)(id __nullable dict);
typedef void(^errorBlock)(NSError *__nullable Error);


typedef void (^SKCompletionBlock)(NSArray *__nullable result, NSError *__nullable error);
typedef void (^SKCompletionBlock1)(NSURL *__nullable result, NSError *__nullable error);
typedef void (^SKCompletionQueryBlock)(NSArray *__nullable result, NSError *__nullable error);

@class AppDelegate;


@interface DataManager : NSObject<NSURLSessionDelegate,MKMapViewDelegate,CLLocationManagerDelegate>{
    
    CLLocationManager *locationManager;
    CLGeocoder *geocoder;
    CLPlacemark *placemark;
    
}


//============================ Reachability ===============================

@property(strong) Reachability *__nullable mReachability;
@property(strong) Reachability *__nullable mLocalWiFiReach;
@property(strong) Reachability *__nullable mInternetConnectionReach;
@property (nonatomic,assign)BOOL mInternetStatus;
@property (nonatomic,retain)AppDelegate *__nullable mAppObj;

@property (nonatomic,strong)NSString *__nullable message;
@property (nonatomic,strong)NSString *__nullable loginType;
@property (nonatomic,strong)NSString *__nullable driverTypeRef;
@property (nonatomic,strong)NSString *__nullable driverOneID;
@property (nonatomic,strong)NSString *__nullable driverStatusSelectionRef;
@property (nonatomic,strong)NSString *__nullable refMsgfromPINVC ;
@property (nonatomic,strong)NSString *__nullable checkForAlerts ;

@property (nonatomic,strong) NSString *__nullable longitude;
@property (nonatomic,strong) NSString *__nullable latitude;
@property (nonatomic,strong) NSString *__nullable address;

@property (nonatomic,strong) NSString *__nullable mSpeed;
@property (nonatomic,assign) BOOL mTruckMovingCheckBool;



@property (nonatomic,strong) NSString *__nullable yardMoveString;
@property (nonatomic,strong) NSString *__nullable personalUseString;


@property (nonatomic,strong) NSString *__nullable iscertifiedcountAuth1_Global;
@property (nonatomic,strong) NSString *__nullable iscertifiedUsername1_Global;
@property (nonatomic,strong) NSString *__nullable iscertifiedcountAuth2_Global;
@property (nonatomic,strong) NSString *__nullable iscertifiedUsername2_Global;





@property (nonatomic,strong)NSMutableArray *__nullable DVIRSelectedArray;
@property (nonatomic,strong)NSMutableArray *__nullable DVIRRefArrayOne;
@property (nonatomic,strong)NSMutableArray *__nullable DVIRRefArrayTwo;
@property (nonatomic,strong)CLLocationManager * _Nullable locationManager;


-(void)GetRequest:(NSString*__nullable)url parameter:(id __nullable)parameter onCompletion:(JSonRepresentation __nullable)completion onError:(errorBlock __nullable)Error;
-(void)PostRequest:(NSString*__nullable)url parameter:(id __nullable)parameter onCompletion: (JSonRepresentation __nullable)completion onError:(errorBlock __nullable)Error;
-(void)UploadImage:(NSString*_Nullable)url image:(UIImage*_Nullable)image imageName:(NSString*_Nullable)imageName parameter:(NSDictionary*_Nullable)parameter onCompletion:(JSonRepresentation _Nullable )completion onError:(errorBlock _Nullable )Error;
-(void)requestPostUrlWithImage: (NSString *_Nullable)serviceName parameters:(NSDictionary *_Nullable)dictParams image:(UIImage *_Nullable)image imageName:(NSString *_Nullable)imageName success:(void (^_Nullable)(NSDictionary * _Nullable responce))success failure:(void (^_Nullable)(NSError * _Nullable error))failure;
-(void)UploadFile:(NSString*__nullable)url image:(UIImage*__nullable)image filename:(NSString*__nullable)filename parameter:(NSDictionary*__nullable)parameter fileurl:(NSURL*__nullable)fileurl onCompletion:(JSonRepresentation __nullable)completion onError:(errorBlock __nullable)Error;


+(DataManager *__nullable)sharedDataManager;
-(void)startReachability;

@property (nonatomic,retain) AFHTTPSessionManager *__nullable manager;


-(NSString*_Nullable)dateFormateForServer:(NSDate*_Nullable)date ;

- (NSString *_Nullable)DatabasePath;
- (void) checkAndCreateDatabase;
- (void)insertData:(NSString *_Nullable)insertStatement;
- (NSArray *_Nullable)fetchFavouritesByType:(NSString *_Nullable)typeStr;
- (NSInteger)fetchRecordExistance:(NSString *_Nullable)statement;
- (NSArray *_Nullable)fetchRecordByID:(NSString *_Nullable)stmntStr;
- (CLLocationCoordinate2D) getLocation;



@end
