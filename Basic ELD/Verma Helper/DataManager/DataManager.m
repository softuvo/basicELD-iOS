//
//  DataManager.m
//  VermaTestFirebase
//
//  Created by Gaurav Verma on 21/10/16.
//  Copyright © 2016 Gaurav Verma. All rights reserved.
//

#import "DataManager.h"
#import <sqlite3.h>
#import "Records.h"
#import "SOMotionDetector.h"
#import "SOStepDetector.h"

static DataManager *sharedDataManager = nil;



@implementation DataManager{
    BOOL Truckmovingcheckbool;

}
@synthesize mInternetStatus,mAppObj;



#pragma Mark ================================================================
#pragma Mark INITIALIZE SINGLETON OBJECT START
#pragma Mark ================================================================


+(DataManager *)sharedDataManager {
    /*
    if (!sharedDataManager) {
        sharedDataManager = [[DataManager alloc] init];
        sharedDataManager.mAppObj =  (AppDelegate *)appDelegate;
        [sharedDataManager startReachability];
        
    }
    return sharedDataManager;
    */

    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedDataManager = [[DataManager alloc] init];
        sharedDataManager.mAppObj =  (AppDelegate *)appDelegate;
        [sharedDataManager startReachability];
        [sharedDataManager GetCurrentLocation];
        [sharedDataManager checkAndCreateDatabase];
        [sharedDataManager checkForAlertsFunc];
        [sharedDataManager MotionActivity];

       
    });return sharedDataManager;
    
}
#pragma Mark ================================================================
#pragma Mark INITIALIZE SINGLETON OBJECT END
#pragma Mark ================================================================

-(void)checkForAlertsFunc{
     self.checkForAlerts = [[NSUserDefaults standardUserDefaults] valueForKey:kCheckForAlerts];
    if (self.checkForAlerts.length == 0) {
        NSUserDefaults *checkForAlerts = [NSUserDefaults standardUserDefaults];
        [checkForAlerts setObject:kNo forKey:kCheckForAlerts];
        [checkForAlerts synchronize];
        NSLog(@"checkForAlerts kNo");
        self.checkForAlerts = [[NSUserDefaults standardUserDefaults] valueForKey:kCheckForAlerts];
    }
    
}

#pragma Mark ================================================================
#pragma mark core locatiom Start
#pragma Mark ================================================================

-(void)GetCurrentLocation{
    
    self->locationManager = [[CLLocationManager alloc] init];
    self->geocoder = [[CLGeocoder alloc] init];
    self->locationManager.delegate = self;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;

    if(IS_OS_8_OR_LATER){
        NSUInteger code = [CLLocationManager authorizationStatus];
        if (code == kCLAuthorizationStatusNotDetermined && ([self->locationManager respondsToSelector:@selector(requestAlwaysAuthorization)] || [self->locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]))
        {
            // choose one request according to your business.
            if([[NSBundle mainBundle] objectForInfoDictionaryKey:@"NSLocationAlwaysUsageDescription"])
            {
                [self->locationManager requestAlwaysAuthorization];
            }
            else if([[NSBundle mainBundle] objectForInfoDictionaryKey:@"NSLocationWhenInUseUsageDescription"])
            {
                [self->locationManager  requestWhenInUseAuthorization];
            }
            else
            {
                NSLog(@"Info.plist does not contain NSLocationAlwaysUsageDescription or NSLocationWhenInUseUsageDescription");
            }
        }
    }
    [self->locationManager startUpdatingLocation];
}




#pragma mark--------------------------------------------------------------------
#pragma mark CLLocationManagerDelegate Start
#pragma mark--------------------------------------------------------------------

// for Battery Save automatic update
- (IBAction)getCurrentLocation:(id)sender {
    locationManager.delegate = self;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    
    [locationManager startUpdatingLocation];
}


- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"didFailWithError: %@", error);
    UIAlertView *errorAlert = [[UIAlertView alloc]
                               initWithTitle:@"Error" message:@"Failed to Get Your Location" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [errorAlert show];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
   // NSLog(@"didUpdateToLocation: %@", newLocation);
    CLLocation *currentLocation = newLocation;
    
    if (currentLocation != nil) {

        self.longitude = [NSString stringWithFormat:@"%.8f", currentLocation.coordinate.longitude];
        self.latitude = [NSString stringWithFormat:@"%.8f", currentLocation.coordinate.latitude];
    }
    
     // Stop Location Manager
     // [locationManager stopUpdatingLocation];
     
     // Reverse Geocoding
//     NSLog(@"Resolving the Address");
     [geocoder reverseGeocodeLocation:currentLocation completionHandler:^(NSArray *placemarks, NSError *error) {
     //NSLog(@"Found placemarks: %@, error: %@", placemarks, error);
     if (error == nil && [placemarks count] > 0) {
     placemark = [placemarks lastObject];
         
//       self.address =  [NSString stringWithFormat:@"\n%@ \n%@\n%@ \n%@\n%@\n%@\n%@\n%@\n%@\n%@\n%@\n%@",placemark.name,placemark.thoroughfare,placemark.subThoroughfare,placemark.locality,placemark.subLocality,placemark.administrativeArea,placemark.subAdministrativeArea,placemark.postalCode,placemark.ISOcountryCode,placemark.country,placemark.inlandWater,placemark.ocean];
//         NSLog(@"Address=======%@========", self.address);

         
     self.address = [NSString stringWithFormat:@"%@ %@ %@ %@ %@ %@",placemark.thoroughfare,placemark.subLocality,placemark.locality, placemark.postalCode,placemark.administrativeArea,placemark.country];
    // NSLog(@"%@", self.address);

     } else {
     NSLog(@"%@", error.debugDescription);
     }
     } ];
    
}

-(CLLocationCoordinate2D) getLocation{
    locationManager = [[CLLocationManager alloc] init] ;
    locationManager.delegate = self;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    locationManager.distanceFilter = kCLDistanceFilterNone;
    [locationManager startUpdatingLocation];
    CLLocation *location = [locationManager location];
    CLLocationCoordinate2D coordinate = [location coordinate];
    
    return coordinate;
}

#pragma mark--------------------------------------------------------------------
#pragma mark CLLocationManagerDelegate Start
#pragma mark--------------------------------------------------------------------



#pragma Mark ================================================================
#pragma mark core locatiom End
#pragma Mark ================================================================




#pragma Mark ================================================================
#pragma MarkINITIALIZE AFNETWORKING OBJECT START
#pragma Mark ================================================================

-(id)init {
    if (sharedDataManager) {
        self=sharedDataManager;
    } else if (self=[super init]) {
        sharedDataManager=self;
        self.manager=[AFHTTPSessionManager manager];
    }
    return  self;
}


#pragma Mark ================================================================
#pragma Mark INITIALIZE AFNETWORKING OBJECT START
#pragma Mark ================================================================











#pragma Mark ================================================================
#pragma Mark REACHABILITY START
#pragma Mark ================================================================



-(void)startReachability {
    self.mReachability = [Reachability reachabilityWithHostname:@"www.google.com"];
    self.mReachability.reachableBlock = ^(Reachability * reachability) {
        self.mInternetStatus = true;
    };
    
    self.mReachability.unreachableBlock = ^(Reachability * reachability)
    {
        self.mInternetStatus = false;
    };
    
    [self.mReachability startNotifier];
    
    self.mLocalWiFiReach = [Reachability reachabilityForLocalWiFi];
    
    // we ONLY want to be reachable on WIFI - cellular is NOT an acceptable connectivity
    
    self.mLocalWiFiReach.reachableOnWWAN = NO;
    
    self.mLocalWiFiReach.reachableBlock = ^(Reachability * reachability)
    {
        self.mInternetStatus = true;
    };
    
    self.mLocalWiFiReach.unreachableBlock = ^(Reachability * reachability)
    {
        self.mInternetStatus = false;
    };
    
    [self.mLocalWiFiReach startNotifier];
    
    
    
    // create a Reachability object for the internet
    
    self.mInternetConnectionReach = [Reachability reachabilityForInternetConnection];
    
    self.mInternetConnectionReach.reachableBlock = ^(Reachability * reachability) {
        self.mInternetStatus = true;
    };
    
    self.mInternetConnectionReach.unreachableBlock = ^(Reachability * reachability) {
        self.mInternetStatus = false;
    };
    [self.mInternetConnectionReach startNotifier];
}


#pragma Mark ================================================================
#pragma Mark REACHABILITY END
#pragma Mark ================================================================














#pragma Mark ================================================================
#pragma Mark GET REQUEST START
#pragma Mark ================================================================


-(void)GetRequest:(NSString*)url parameter:(id)parameter onCompletion:(JSonRepresentation)completion onError:(errorBlock)Error
{
    /*
      AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
     manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
     manager.requestSerializer = [AFJSONRequestSerializer serializer];
     [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
     [self.manager.requestSerializer setTimeoutInterval:900];

    */
    
    if (DM.mInternetStatus == false) {
        NSLog(@"No Internet Connection.");
        [Helper ISAlertTypeError:@"Internet Connection!!" andMessage:kNOInternet];
        return;
    }

    
    self.manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [self.manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    self.manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [self.manager GET:url parameters:parameter progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if(responseObject) {
            [UIApplication sharedApplication].networkActivityIndicatorVisible=NO;
            completion(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        Error(error);
    }];
}


#pragma Mark ================================================================
#pragma Mark GET REQUEST END
#pragma Mark ================================================================











#pragma Mark ================================================================
#pragma Mark POST REQUEST START
#pragma Mark ================================================================

-(void)PostRequest:(NSString*)url parameter:(id)parameter onCompletion:(JSonRepresentation)completion onError:(errorBlock)Error
{
    /*
     AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
     manager.requestSerializer = [AFJSONRequestSerializer serializer];
       manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
     [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
     */
    
    if (DM.mInternetStatus == false) {
        NSLog(@"No Internet Connection.");
        [Helper ISAlertTypeError:@"Internet Connection!!" andMessage:kNOInternet];
        return;
    }

    
    
    self.manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [self.manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    self.manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [self.manager POST:url parameters:parameter progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
     {
         if(responseObject)
         {
             completion(responseObject);
         }
     } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
     {
         Error(error);
         NSLog(@"error: %@", error);
         
     }];
}


#pragma Mark ================================================================
#pragma Mark POST REQUEST END
#pragma Mark ================================================================













#pragma Mark ================================================================
#pragma Mark UPLOAd IMAGE Start
#pragma Mark ================================================================


-(void)UploadImage:(NSString*)url image:(UIImage*)image imageName:(NSString*)imageName parameter:(NSDictionary*)parameter onCompletion:(JSonRepresentation)completion onError:(errorBlock)Error
{
    if (DM.mInternetStatus == false) {
        NSLog(@"No Internet Connection.");
        [Helper ISAlertTypeError:@"Internet Connection!!" andMessage:kNOInternet];
        return;
    }

    NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer] multipartFormRequestWithMethod:@"POST" URLString:url parameters:parameter constructingBodyWithBlock:^(id<AFMultipartFormData> formData)
                                    {
                                        NSData *imageData = UIImageJPEGRepresentation(image,0.5);
                                        [formData appendPartWithFileData:imageData name:@"image" fileName:[NSString stringWithFormat:@"%@.png",imageName]mimeType:@"image/png"];
                                    } error:nil];
    [self.manager setResponseSerializer:[AFJSONResponseSerializer serializer]];
    NSURLSessionUploadTask *uploadTask;
    uploadTask = [_manager
                  uploadTaskWithStreamedRequest:request
                  progress:^(NSProgress * _Nonnull uploadProgress) {
                      NSLog(@"%@",uploadProgress);
                      
                      // This is not called back on the main queue.
                      // You are responsible for dispatching to the main queue for UI updates
                      dispatch_async(dispatch_get_main_queue(), ^{
                          //Update the progress view
                           //[progressView setProgress:uploadProgress.fractionCompleted];
                      });
                  }
                  completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
                      [UIApplication sharedApplication].networkActivityIndicatorVisible=NO;
                      if (error)
                      {
                          Error(error);
                      } else
                      {
                          NSLog(@"%@",response);
                          completion(responseObject);
                      }
                  }];
    [uploadTask resume];
}





-(void)requestPostUrlWithImage: (NSString *)serviceName parameters:(NSDictionary *)dictParams image:(UIImage *)image
                       imageName:(NSString *)imageName
                       success:(void (^)(NSDictionary *responce))success failure:(void (^)(NSError *error))failure

{
    NSString *strService = [NSString stringWithFormat:@"%@",serviceName];
    [SVProgressHUD show];
   // NSData *fileData = image?UIImagePNGRepresentation(image):nil;
    NSData *fileData =  UIImageJPEGRepresentation(image, 0.5);
    NSLog(@"File Size %lu",(unsigned long)[fileData length]);
    NSError *error;
    NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer] multipartFormRequestWithMethod:@"POST" URLString:strService parameters:dictParams constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
        if(fileData){
            [formData appendPartWithFileData:fileData
                                        name:@"userfile"
                                    fileName:@"image.jpeg"
                                    mimeType:@"multipart/form-data"];
        }
    } error:&error];
    
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    
    NSURLSessionUploadTask *uploadTask;
    uploadTask = [manager uploadTaskWithStreamedRequest:request progress:^(NSProgress * _Nonnull uploadProgress) {
        
        NSLog(@"Wrote %f", uploadProgress.fractionCompleted);
        [SVProgressHUD showProgress:uploadProgress.fractionCompleted status:@"Uploading..."];
    }
                                      completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
                                          [SVProgressHUD dismiss];
                                          if (error)
                                          {
                                              failure(error);
                                          }
                                          else
                                          {
                  NSLog(@"POST Response  : %@",responseObject);
                  if ([[responseObject valueForKey:@"responsestatus"] integerValue] == 0) {
                  [SVProgressHUD showErrorWithStatus:@"Failed"];
                 }
              else{
                  [SVProgressHUD showSuccessWithStatus:@"Uploaded"];
                                          }
                                              
                                              success(responseObject);
                                              
                                          }
                                      }];
    
    [uploadTask resume];
    
}




#pragma Mark ================================================================
#pragma Mark UPLOAd IMAGE END
#pragma Mark ================================================================





#pragma Mark ================================================================
#pragma Mark UPLOAd FILE START
#pragma Mark ================================================================

-(void)UploadFile:(NSString*)url image:(UIImage*)image filename:(NSString*)filename parameter:(NSDictionary*)parameter fileurl:(NSURL*)fileurl onCompletion:(JSonRepresentation)completion onError:(errorBlock)Error
{
    NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer] multipartFormRequestWithMethod:@"POST" URLString:url parameters:parameter constructingBodyWithBlock:^(id<AFMultipartFormData> formData)
                                    {
                                        if (image)
                                        {
                                            NSData *imageData = UIImageJPEGRepresentation(image,0.5);
                                            [formData appendPartWithFileData:imageData name:filename fileName:[NSString stringWithFormat:@"file%@.jpg",[Helper date_Time_String] ]mimeType:@"image/jpg"];
                                        }
                                        if(fileurl)
                                        {
                                            [formData appendPartWithFileURL:fileurl name:filename fileName:@"file.mp4" mimeType:@"video/mp4" error:nil];
                                        }
                                    } error:nil];
    [_manager setResponseSerializer:[AFJSONResponseSerializer serializer]];
    NSURLSessionUploadTask *uploadTask;
    uploadTask = [_manager
                  uploadTaskWithStreamedRequest:request
                  progress:^(NSProgress * _Nonnull uploadProgress) {
                      // This is not called back on the main queue.
                      // You are responsible for dispatching to the main queue for UI updates
                      dispatch_async(dispatch_get_main_queue(), ^{
                          //Update the progress view
                          // [progressView setProgress:uploadProgress.fractionCompleted];
                      });
                  }
                  completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
                      [UIApplication sharedApplication].networkActivityIndicatorVisible=NO;
                      
                      if (error)
                      {
                          Error(error);
                      } else
                      {
                        NSLog(@"%@",response);
                        completion(responseObject);
                      }
                  }];
    [uploadTask resume];
}

#pragma Mark ================================================================
#pragma Mark UPLOAd FILE END
#pragma Mark ================================================================













#pragma Mark ================================================================
#pragma Mark ENCODE BASE64 START
#pragma Mark ================================================================

- (NSString *)EncodeToBase64String:(UIImage *)image {
    return [UIImagePNGRepresentation(image) base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
}

#pragma Mark ================================================================
#pragma Mark ENCODE BASE64 END
#pragma Mark ================================================================








#pragma Mark ================================================================
#pragma Mark TEST FUNCTIONS START
#pragma Mark ================================================================

- (void)TestGetAPIButtonPressed{
    NSMutableDictionary *mWebDataDict = [[NSMutableDictionary alloc] init];
    [mWebDataDict setObject:@"Gaurav Verma" forKey:@"name"];
    [mWebDataDict setObject:@"g@gmail.com" forKey:@"email"];
    NSString *path=[NSString stringWithFormat:@"http://ec2-54-194-200-74.eu-west-1.compute.amazonaws.com/pundit-web/api/Users/login/"];
    
    [DM GetRequest:path parameter:mWebDataDict onCompletion:^(id dict) {
        NSError *errorJson=nil;
        NSDictionary* responseDict = [NSJSONSerialization JSONObjectWithData:dict options:kNilOptions error:&errorJson];
        NSLog(@"%@",responseDict);
    } onError:^(NSError *Error) {
        NSLog(@"%@",Error);
        NSString *ErrorString = [NSString stringWithFormat:@"%@",Error];
        [Helper ISAlertTypeError:ErrorString andMessage:kNOInternet];
    }];
    
    
}





- (void)TestPostAPIButtonPressed{
    
    NSMutableDictionary *mWebDataDict = [[NSMutableDictionary alloc] init];
    [mWebDataDict setObject:@"Gaurav Verma" forKey:@"name"];
    [mWebDataDict setObject:@"g@gmail.com" forKey:@"email"];
    NSString *path=[NSString stringWithFormat:@"http://ec2-54-194-200-74.eu-west-1.compute.amazonaws.com/pundit-web/api/Users/login/"];
    
    [DM PostRequest:path parameter:mWebDataDict onCompletion:^(id dict) {
        NSError *errorJson=nil;
        NSDictionary* responseDict = [NSJSONSerialization JSONObjectWithData:dict options:kNilOptions error:&errorJson];
        NSLog(@"%@",responseDict);
    } onError:^(NSError *Error) {
        NSLog(@"%@",Error);
        NSString *ErrorString = [NSString stringWithFormat:@"%@",Error];
        [Helper ISAlertTypeError:ErrorString andMessage:kNOInternet];
        
    }];
    
}

#pragma Mark ================================================================
#pragma Mark TEST FUNCTIONS START
#pragma Mark ================================================================








#pragma Mark ================================================================
#pragma Mark SQLITE DATA BASE START
#pragma Mark ================================================================



#pragma Mark ================================================================
#pragma Mark DatabasePath
#pragma Mark ================================================================


- (NSString *)DatabasePath {
    NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDir = [documentPaths objectAtIndex:0];
    NSString *databasePath = [documentsDir stringByAppendingPathComponent:@"ELDDB.sqlite"];
    return databasePath;
}
#pragma Mark ================================================================
#pragma Mark checkAndCreateDatabase
#pragma Mark ================================================================

- (void) checkAndCreateDatabase {
    BOOL success;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    success = [fileManager fileExistsAtPath:[sharedDataManager DatabasePath]];
    if(success) return;
    NSString *databasePathFromApp = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"ELDDB.sqlite"];
    [fileManager copyItemAtPath:databasePathFromApp toPath:[sharedDataManager DatabasePath] error:nil];
}
#pragma Mark ================================================================
#pragma Mark insertData
#pragma Mark ================================================================

- (void)insertData:(NSString *)insertStatement {
    sqlite3 *database;
    
    if(sqlite3_open([[sharedDataManager DatabasePath] UTF8String], & database) == SQLITE_OK) {
        const char *sqlStatement = [insertStatement UTF8String];
        int testvalue =sqlite3_exec(database, sqlStatement,NULL,NULL,NULL);
        if(testvalue == SQLITE_OK) {
            NSLog(@"YES YES");
        }
        else{
            NSLog(@"NOT NOT %@",insertStatement);
            
        }
    }
    
    sqlite3_close(database);
}


#pragma Mark ================================================================
#pragma Mark fetchFavouritesByType
#pragma Mark ================================================================

- (NSArray *)fetchFavouritesByType:(NSString *)typeStr{
    NSString *stmnt = [NSString stringWithFormat:@"select order_val from Fav_Trails where type_val = %@",typeStr];
    
    
    sqlite3 *database;
    NSMutableArray *array = [[NSMutableArray alloc] init] ;
    
    if(sqlite3_open([[sharedDataManager DatabasePath] UTF8String], &database) == SQLITE_OK) {
        const char *sqlStatement = [stmnt UTF8String];
        sqlite3_stmt *compiledStatement;
        if(sqlite3_prepare_v2(database, sqlStatement , -1, &compiledStatement, NULL) == SQLITE_OK) {
            while(sqlite3_step(compiledStatement) == SQLITE_ROW) {
                const char *coloumText;
                coloumText = (char *)sqlite3_column_text(compiledStatement,0);
                if(coloumText!=NULL) {
                    NSString *itemNameString = [NSString stringWithUTF8String:coloumText];
                    [array addObject:itemNameString];
                    //wpt.mTourName = itemNameString;
                }
                
                
            }
        }
        sqlite3_finalize(compiledStatement);
        
    }
    sqlite3_close(database);
    return array;
}

#pragma Mark ================================================================
#pragma Mark fetchRecordExistance
#pragma Mark ================================================================


- (NSInteger)fetchRecordExistance:(NSString *)statement{
    sqlite3 *database;
    if(sqlite3_open([[sharedDataManager DatabasePath] UTF8String], &database) == SQLITE_OK) {
        const char *sqlStatement = [statement UTF8String];
        sqlite3_stmt *compiledStatement;
        if(sqlite3_prepare_v2(database, sqlStatement , -1, &compiledStatement, NULL) == SQLITE_OK) {
            while(sqlite3_step(compiledStatement) == SQLITE_ROW) {
                const char *coloumText;
                coloumText = (char *)sqlite3_column_text(compiledStatement,0);
                if(coloumText!=NULL) {
                    NSString *itemNameString = [NSString stringWithUTF8String:coloumText];
                    sqlite3_finalize(compiledStatement);
                    sqlite3_close(database);
                    
                    return [itemNameString intValue];
                    
                    //wpt.mTourName = itemNameString;
                }
                
            }
        }
        sqlite3_finalize(compiledStatement);
        
    }
    sqlite3_close(database);
    return 0;
}

#pragma Mark ================================================================
#pragma Mark fetchRecordByID
#pragma Mark ================================================================


- (NSArray *)fetchRecordByID:(NSString *)stmntStr {
    sqlite3 *database;
    NSMutableArray *array = [[NSMutableArray alloc] init] ;
    if(sqlite3_open([[sharedDataManager DatabasePath] UTF8String], &database) == SQLITE_OK) {
        const char *sqlStatement = [stmntStr UTF8String];
        sqlite3_stmt *compiledStatement;
        if(sqlite3_prepare_v2(database, sqlStatement , -1, &compiledStatement, NULL) == SQLITE_OK) {
            while(sqlite3_step(compiledStatement) == SQLITE_ROW) {
                Records *Record = [[Records alloc] init];
                
                const char *coloumText;
                coloumText = (char *)sqlite3_column_text(compiledStatement,0);
                if(coloumText!=NULL) {
                    NSString *itemNameString = [NSString stringWithUTF8String:coloumText];
                    Record.record_id = itemNameString;
                }
                
                coloumText = (char *)sqlite3_column_text(compiledStatement,1);
                if(coloumText!=NULL) {
                    NSString *itemNameString = [NSString stringWithUTF8String:coloumText];
                    Record.partner_id = itemNameString;
                    
                    
                }
                
                coloumText = (char *)sqlite3_column_text(compiledStatement,2);
                if(coloumText!=NULL) {
                    NSString *itemNameString = [NSString stringWithUTF8String:coloumText];
                    Record.user_name = itemNameString;
                    
                }
                
                coloumText = (char *)sqlite3_column_text(compiledStatement,3);
                if(coloumText!=NULL) {
                    NSString *itemNameString = [NSString stringWithUTF8String:coloumText];
                    Record.user_uniq_id = itemNameString;
                    
                }
                
                coloumText = (char *)sqlite3_column_text(compiledStatement,4);
                if(coloumText!=NULL) {
                    NSString *itemNameString = [NSString stringWithUTF8String:coloumText];
                    Record.user_dob = itemNameString;
                    
                }
                coloumText = (char *)sqlite3_column_text(compiledStatement,5);
                if(coloumText!=NULL) {
                    NSString *itemNameString = [NSString stringWithUTF8String:coloumText];
                    Record.user_image = itemNameString;
                    
                }
                coloumText = (char *)sqlite3_column_text(compiledStatement,6);
                if(coloumText!=NULL) {
                    NSString *itemNameString = [NSString stringWithUTF8String:coloumText];
                    Record.check_devid = itemNameString;
                    
                }
                coloumText = (char *)sqlite3_column_text(compiledStatement,7);
                if(coloumText!=NULL) {
                    NSString *itemNameString = [NSString stringWithUTF8String:coloumText];
                    Record.user_desc = itemNameString;
                    
                }coloumText = (char *)sqlite3_column_text(compiledStatement,8);
                if(coloumText!=NULL) {
                    NSString *itemNameString = [NSString stringWithUTF8String:coloumText];
                    Record.orderid = itemNameString;
                    
                }
                coloumText = (char *)sqlite3_column_text(compiledStatement,9);
                if(coloumText!=NULL) {
                    NSString *itemNameString = [NSString stringWithUTF8String:coloumText];
                    Record.date_time = itemNameString;
                    
                }
                
                coloumText = (char *)sqlite3_column_text(compiledStatement,10);
                if(coloumText!=NULL) {
                    NSString *itemNameString = [NSString stringWithUTF8String:coloumText];
                    Record.order_id = itemNameString;
                    
                }
                
                coloumText = (char *)sqlite3_column_text(compiledStatement,11);
                if(coloumText!=NULL) {
                    NSString *itemNameString = [NSString stringWithUTF8String:coloumText];
                    Record.user_deleted = itemNameString;
                    
                }
                
                coloumText = (char *)sqlite3_column_text(compiledStatement,12);
                if(coloumText!=NULL) {
                    NSString *itemNameString = [NSString stringWithUTF8String:coloumText];
                    Record.first_name = itemNameString;
                    
                }
                
                coloumText = (char *)sqlite3_column_text(compiledStatement,13);
                if(coloumText!=NULL) {
                    NSString *itemNameString = [NSString stringWithUTF8String:coloumText];
                    Record.last_name = itemNameString;
                    
                }
                
                coloumText = (char *)sqlite3_column_text(compiledStatement,14);
                if(coloumText!=NULL) {
                    NSString *itemNameString = [NSString stringWithUTF8String:coloumText];
                    Record.order_status = itemNameString;
                    
                }
                
                
                NSString *mSearchString = [NSString stringWithFormat:@"%@%@",Record.user_name,Record.user_uniq_id];
                
                Record.SearchString = mSearchString;
                
                
                
                [array addObject:Record];
            }
        }
        sqlite3_finalize(compiledStatement);
        
    }
    sqlite3_close(database);
    return array;
}

#pragma Mark ================================================================
#pragma Mark SQLITE DATA BASE END
#pragma Mark ================================================================




-(NSString*)dateFormateForServer:(NSDate*)date{
    
    NSDateFormatter *dateformateTwo=[[NSDateFormatter alloc]init];
    [dateformateTwo setDateFormat:@"yyyy-MM-dd"];
    NSString *date_StringTwo =[dateformateTwo stringFromDate:date];
    
    return date_StringTwo;
}

-(void) MotionActivity
{
    
    [SOMotionDetector sharedInstance].locationChangedBlock = ^(CLLocation *location) {
        NSLog(@"%@",location);
        self.mSpeed = [NSString stringWithFormat:@"%.2f Km/h",location.speed];
        NSLog(@"Speed = %.2f Km/h",location.speed);
        NSLog(@"%@",location.timestamp);
        NSLog(@"%.8f",location.coordinate.latitude);
        NSLog(@"%.8f",location.coordinate.longitude);
    };
    

    
    [SOMotionDetector sharedInstance].motionTypeChangedBlock = ^(SOMotionType motionType) {
        NSString *type = @"";
        switch (motionType) {
            case MotionTypeNotMoving:
                type = @"Truck Not moving";
                self.mTruckMovingCheckBool =  FALSE;
                [self TruckMoveChecks];
                break;
            case MotionTypeWalking:
                //type = @"Truck Walking";
                break;
            case MotionTypeRunning:
               // type = @"Truck Running";
                break;
            case MotionTypeAutomotive:
                type = @"Truck Moving";
                self.mTruckMovingCheckBool =  TRUE;
                [self TruckMoveChecks];
                break;
                
                //[Helper showAlert:self.mSpeed andMessage:type andButton:@"Ok"];

        }
    };
   /*
    [SOMotionDetector sharedInstance].accelerationChangedBlock = ^(CMAcceleration acceleration) {
        BOOL isShaking = [SOMotionDetector sharedInstance].isShaking;
      NSLog(@"%@",isShaking ? @"Truck Moving":@"Truck Not Moving");
        

        if (isShaking == NO) {
            if (Truckmovingcheckbool == FALSE) {
                [Helper showAlert:@"" andMessage:@"Truck Not Moving" andButton:@"Ok"];

            }
            Truckmovingcheckbool = TRUE;
        }
        else{
            if (Truckmovingcheckbool == TRUE) {
                [Helper showAlert:@"" andMessage:@"Truck Moving" andButton:@"Ok"];

            }
            
            Truckmovingcheckbool = FALSE;

        }
        
      
    };
    */
    //This is required for iOS > 9.0 if you want to receive location updates in the background
    [SOLocationManager sharedInstance].allowsBackgroundLocationUpdates = YES;
    
   
    //Starting motion detector
    [[SOMotionDetector sharedInstance] startDetection];
    
}



-(void)TruckMoveChecks{
    
    if (self.mTruckMovingCheckBool == TRUE) {
        
        [Helper showAlert:self.mSpeed andMessage:@"Moving" andButton:@"Ok"];
        
    }
    else if (self.mTruckMovingCheckBool == FALSE) {
        [Helper showAlert:self.mSpeed andMessage:@"Not Moving" andButton:@"Ok"];
    }
}


@end
