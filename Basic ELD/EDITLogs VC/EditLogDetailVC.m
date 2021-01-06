//
//  EditLogDetailVC.m
//  Basic ELD
//
//  Created by Manoj Gadamsetty on 02/09/17.
//  Copyright © 2017 Gaurav Verma. All rights reserved.
//

#import "EditLogDetailVC.h"
#import "DataManager.h"
#import "IQKeyboardManager.h"


@interface EditLogDetailVC (){
    

    CLLocationManager *locationManager;
    CLLocation *currentLocation;

    int locationFetchCounter;
    
    NSString * modeString ;
    
    UIDatePicker *EndTimeDatePicker ;
    UIDatePicker *datePicker ;
    NSDateFormatter *timeFormatter;

    
}

@end

@implementation EditLogDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _personalUse = kZero;
    _yardMove = kZero;

    
    [self.mOnDutyYardMoveButton setImage:[UIImage imageNamed:@"check_icon"] forState:UIControlStateSelected];
    [self.mOnDutyYardMoveButton setImage:[UIImage imageNamed:@"unCheck_icon"] forState:UIControlStateNormal];
    
    [self.mOffDutyPersonalUseButton setImage:[UIImage imageNamed:@"check_icon"] forState:UIControlStateSelected];
    [self.mOffDutyPersonalUseButton setImage:[UIImage imageNamed:@"unCheck_icon"] forState:UIControlStateNormal];
    
    
    self.mCancelButton.enabled = YES ;
    IQKeyboardManager.sharedManager.enable = true;


    self.mHeaderView.layer.borderWidth = 1;
    self.mHeaderView.layer.borderColor = [[UIColor whiteColor]CGColor];
    
    NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"NL"];
    timeFormatter = [[NSDateFormatter alloc] init];
    [timeFormatter setDateFormat:@"HH:mm:ss"];

    datePicker = [[UIDatePicker alloc]init];
    datePicker.datePickerMode = UIDatePickerModeTime;
    [datePicker setLocale:locale];
    [datePicker addTarget:self action:@selector(StartTimeDoneButtonAction) forControlEvents:UIControlEventValueChanged];
    [self.mStartTimeTF setInputView:datePicker];
    
    EndTimeDatePicker = [[UIDatePicker alloc]init];
    [EndTimeDatePicker setLocale:locale];
    EndTimeDatePicker.datePickerMode = UIDatePickerModeTime;
    [EndTimeDatePicker addTarget:self action:@selector(EndTimeDoneButtonAction) forControlEvents:UIControlEventValueChanged];
    [self.mEndTimeTF setInputView:EndTimeDatePicker];
    
    
    locationManager = [CLLocationManager new];
    locationManager.delegate = self;
    locationManager.distanceFilter = kCLDistanceFilterNone;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    
    if ([self.flowMsg isEqualToString:kInsertLogs]) {
        
        [self InsertLog];
    }
    else if ([self.flowMsg isEqualToString:kEditLogs]) {
        
        [self EditLog];
    }
    else if ([self.flowMsg isEqualToString:kCurrentDutyLogs]) {
         [self CurrentDutyLogs];
    }
    else{
        
    }

    // Do any additional setup after loading the view.
    
    
  
    
    
}


-(void)EditLog{

    
    if ([DM.loginType isEqualToString:kLoginTypeSingle]) {
        
        self.mOnDutyYardMoveView.hidden = NO ;
        self.mOffDutyPersonalUseView.hidden = NO ;
        
        DM.yardMoveString = [NSString stringWithFormat:@"%@",self.driverModel.mYardMove];
        if ([DM.yardMoveString isEqualToString:@"Yes"]){
            self.mOnDutyYardMoveView.hidden = NO ;
        }else{
            self.mOnDutyYardMoveView.hidden = YES ;
        }
        
        DM.personalUseString = [NSString stringWithFormat:@"%@",self.driverModel.mAuthorizedPersonalUseCMV];
        
        if ([DM.personalUseString isEqualToString:@"Yes"]){
            self.mOffDutyPersonalUseView.hidden = NO ;
        }else{
            self.mOffDutyPersonalUseView.hidden = YES ;
        }
        
        
    }else{
        self.mOnDutyYardMoveView.hidden = YES ;
        self.mOffDutyPersonalUseView.hidden = YES ;
    }
    
    
    
    
    self.mStartTimeTF.text = [_mDataDict valueForKey:@"start_time"];

    if ([[_mDataDict valueForKey:@"start_time"]isEqualToString:@"00:00:00"]) {
        [self.mStartTimeTF setUserInteractionEnabled:NO];
    }else{
        [self.mStartTimeTF setUserInteractionEnabled:YES];
    }
    
    
    if ([[_mDataDict valueForKey:@"start_time"]isEqualToString:@"23:59:59"]) {
        [self.mEndTimeTF setUserInteractionEnabled:NO];
    }else{
        [self.mEndTimeTF setUserInteractionEnabled:YES];
    }
    
    
    self.mEndTimeTF.text = [_mDataDict valueForKey:@"end_time"];
    self.mLocationTF.text = [_mDataDict valueForKey:@"address"];
    self.mNotesTF.text = [_mDataDict valueForKey:@"notes"];
    
    if ([[_mDataDict valueForKey:@"mode"]isEqualToString:kStatusTypeOnDuty]) {
        self.mOnDutyButton.selected = YES ;
        
        modeString = kStatusTypeOnDuty;
    }else if ([[_mDataDict valueForKey:@"mode"]isEqualToString:kStatusTypeSleeper]) {
        
        self.mSleeperButton.selected = YES ;
        modeString = kStatusTypeSleeper;
        
    }else if ([[_mDataDict valueForKey:@"mode"]isEqualToString:kStatusTypeOffDuty]) {
        self.mOffDutyButton.selected = YES ;
        
        modeString = kStatusTypeOffDuty;
        
    }else if ([[_mDataDict valueForKey:@"mode"]isEqualToString:kStatusTypeDriving]) {
        
        self.mDrivingButton.selected = YES ;
        modeString = kStatusTypeDriving;
    }
    
    
    
    
    if ([[_mDataDict valueForKey:@"mode"]isEqualToString:kEditStatusTypeYardMove]) {

        self.mOnDutyButton.selected = YES ;
        modeString = kStatusTypeOnDuty;
        
        if ([[_mDataDict valueForKey:@"actualmode"]isEqualToString:kStatusTypeOnDuty]) {
            self.mOnDutyYardMoveButton.selected = YES;
            _yardMove = kOne;
        }else{
            self.mOnDutyYardMoveButton.selected = NO;
            _yardMove = kZero;
        }
    }
    
    if ([[_mDataDict valueForKey:@"mode"]isEqualToString:kEditStatusTypePersonalUse]) {
        
        self.mOffDutyButton.selected = YES ;
        modeString = kStatusTypeOffDuty;
        
        if ([[_mDataDict valueForKey:@"actualmode"]isEqualToString:kStatusTypeOffDuty]) {
            self.mOffDutyPersonalUseButton.selected = YES;
            _personalUse = kOne;
        }else{
            self.mOffDutyPersonalUseButton.selected = NO;
            _personalUse = kZero;
        }
        
    }
    
    
    
    NSDate *endDate=[timeFormatter dateFromString:[_mDataDict valueForKey:@"end_time"]];
    [EndTimeDatePicker setDate:endDate];
    NSDate *date=[timeFormatter dateFromString:[_mDataDict valueForKey:@"start_time"]];
    [datePicker setDate:date];

}

-(void)InsertLog{
    
    
    if ([DM.loginType isEqualToString:kLoginTypeSingle]) {
        
        self.mOnDutyYardMoveView.hidden = NO ;
        self.mOffDutyPersonalUseView.hidden = NO ;
        
        DM.yardMoveString = [NSString stringWithFormat:@"%@",self.driverModel.mYardMove];
        if ([DM.yardMoveString isEqualToString:@"Yes"]){
            self.mOnDutyYardMoveView.hidden = NO ;
        }else{
            self.mOnDutyYardMoveView.hidden = YES ;
        }
        
        DM.personalUseString = [NSString stringWithFormat:@"%@",self.driverModel.mAuthorizedPersonalUseCMV];
        
        if ([DM.personalUseString isEqualToString:@"Yes"]){
            self.mOffDutyPersonalUseView.hidden = NO ;
        }else{
            self.mOffDutyPersonalUseView.hidden = YES ;
        }
        
        
    }else{
        self.mOnDutyYardMoveView.hidden = YES ;
        self.mOffDutyPersonalUseView.hidden = YES ;
    }
    
    
    self.mStartTimeTF.text = @"00:00:00";
    [self.mStartTimeTF setUserInteractionEnabled:YES];
    [self.mEndTimeTF setUserInteractionEnabled:YES];

    
    self.mEndTimeTF.text = @"23:59:59";
    self.mLocationTF.text = @"";
    self.mNotesTF.text = @"";
    
    self.mOnDutyButton.selected = NO ;
    self.mSleeperButton.selected = NO ;
    self.mOffDutyButton.selected = NO ;
    self.mDrivingButton.selected = NO ;
    
    modeString = @"";
    
    self.mOnDutyYardMoveButton.selected = NO;
    _yardMove = kZero;
    
    self.mOffDutyPersonalUseButton.selected = NO;
    _personalUse = kZero;
    
    [EndTimeDatePicker setDate:[NSDate date]];
    [datePicker setDate:[NSDate date]];
    
}


-(void)CurrentDutyLogs{
    
    
    self.mUpperView.hidden = YES;
    self.mLowerView.frame = CGRectMake(-10,90,341,315);
    
    if ([DM.loginType isEqualToString:kLoginTypeSingle]) {
        
        self.mOnDutyYardMoveView.hidden = NO ;
        self.mOffDutyPersonalUseView.hidden = NO ;
        
        DM.yardMoveString = [NSString stringWithFormat:@"%@",self.driverModel.mYardMove];
        if ([DM.yardMoveString isEqualToString:@"Yes"]){
            self.mOnDutyYardMoveView.hidden = NO ;
        }else{
            self.mOnDutyYardMoveView.hidden = YES ;
        }
        
        DM.personalUseString = [NSString stringWithFormat:@"%@",self.driverModel.mAuthorizedPersonalUseCMV];
        
        if ([DM.personalUseString isEqualToString:@"Yes"]){
            self.mOffDutyPersonalUseView.hidden = NO ;
        }else{
            self.mOffDutyPersonalUseView.hidden = YES ;
        }
        
        
    }else{
        self.mOnDutyYardMoveView.hidden = YES ;
        self.mOffDutyPersonalUseView.hidden = YES ;
    }
    
    
    self.mStartTimeTF.text = @"00:00:00";
    [self.mStartTimeTF setUserInteractionEnabled:YES];
    [self.mEndTimeTF setUserInteractionEnabled:YES];
    
    
    self.mEndTimeTF.text = @"23:59:59";
    self.mLocationTF.text = @"";
    self.mNotesTF.text = @"";
    
    self.mOnDutyButton.selected = NO ;
    self.mSleeperButton.selected = NO ;
    self.mOffDutyButton.selected = NO ;
    self.mDrivingButton.selected = NO ;
    
    modeString = @"";
    
    self.mOnDutyYardMoveButton.selected = NO;
    _yardMove = kZero;
    
    self.mOffDutyPersonalUseButton.selected = NO;
    _personalUse = kZero;
    
    [EndTimeDatePicker setDate:[NSDate date]];
    [datePicker setDate:[NSDate date]];
    
}


-(void)StartTimeDoneButtonAction{
    self.mStartTimeTF.text = [timeFormatter stringFromDate:datePicker.date];
}
-(void)EndTimeDoneButtonAction{
    self.mEndTimeTF.text = [timeFormatter stringFromDate:EndTimeDatePicker.date];
}


- (IBAction)OffDutyButtonAction:(id)sender{
    self.mOnDutyButton.selected = NO ;
    self.mOffDutyButton.selected = YES ;
    self.mDrivingButton.selected = NO ;
    self.mSleeperButton.selected = NO ;
    
    
    if (!(sender == self)) {
        self.mOffDutyPersonalUseButton.selected = NO;
        _yardMove = kZero;
    }
    
    
    
    modeString = kStatusTypeOffDuty;
}
- (IBAction)OnDutyButtonAction:(id)sender{
    
    self.mOnDutyButton.selected = YES ;
    self.mOffDutyButton.selected = NO ;
    self.mDrivingButton.selected = NO ;
    self.mSleeperButton.selected = NO ;
    
    if (!(sender == self)) {
        self.mOnDutyYardMoveButton.selected = NO;
        _personalUse = kZero;
    }
    
    
    modeString = kStatusTypeOnDuty;
    
}
- (IBAction)SleeperButtonAction:(id)sender{
    
    self.mOnDutyButton.selected = NO ;
    self.mOffDutyButton.selected = NO ;
    self.mDrivingButton.selected = NO ;
    self.mSleeperButton.selected = YES ;
    
    self.mOffDutyPersonalUseButton.selected = NO;
    _yardMove = kZero;
    self.mOnDutyYardMoveButton.selected = NO;
    _personalUse = kZero;
    
    modeString = kStatusTypeSleeper;
}
- (IBAction)DrivingButtonAction:(id)sender{
    self.mOnDutyButton.selected = NO ;
    self.mOffDutyButton.selected = NO ;
    self.mDrivingButton.selected = YES ;
    self.mSleeperButton.selected = NO ;
    
    self.mOffDutyPersonalUseButton.selected = NO;
    _yardMove = kZero;
    self.mOnDutyYardMoveButton.selected = NO;
    _personalUse = kZero;
    
    modeString = kStatusTypeDriving;
    
}

- (IBAction)BackButtonAction:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)SaveButtonTap:(id)sender {
    
    
    if ([self.flowMsg isEqualToString:kInsertLogs]) {
        
        [self InsertLogData];
    }
    else if ([self.flowMsg isEqualToString:kEditLogs]) {
        
        [self PostData];

    }
    else if ([self.flowMsg isEqualToString:kCurrentDutyLogs]) {
        
        [self CurrentDutyData];
    }
    
    
}


-(void)CurrentDutyData{
    CLLocationCoordinate2D coordinate = [DM getLocation];
    NSString *latLong = [NSString stringWithFormat:@"%f,%f", coordinate.latitude,coordinate.longitude];
    
    
    if ([modeString isEqualToString:@""]) {
        [Helper ISAlertTypeWarning:@"Warning" andMessage:@"Please Select Status"];
        return;
    }
   
    if ([self.mLocationTF.text isEqualToString:@""]) {
        [Helper ISAlertTypeWarning:@"Warning" andMessage:@"Please Enter Location"];
        return;
    }
    [Helper showLoaderVProgressHUD];
    
    
    
    NSString * path = [NSString stringWithFormat:@"%@changeCurrentStatus",kServiceBaseURL];
    NSMutableDictionary * parameter = [[NSMutableDictionary alloc]init];
    [parameter setValue:self.driverId forKey:@"driverId"];
    [parameter setValue:modeString forKey:@"mode"];
    [parameter setValue:self.mNotesTF.text forKey:@"notes"];
    [parameter setValue:self.mLocationTF.text forKey:@"location"];
    
    [parameter setValue:_personalUse forKey:@"personal_use"];
    [parameter setValue:_yardMove forKey:@"yard_move"];
    [parameter setValue:latLong forKey:@"lat_long"];
    
    
    
    
    [DM PostRequest:path parameter:parameter onCompletion:^(id  _Nullable dict) {
        
        NSError *errorJson=nil;
        NSDictionary* responseDict = [NSJSONSerialization JSONObjectWithData:dict options:kNilOptions error:&errorJson];
        NSLog(@"%@",responseDict);
        if ([[responseDict valueForKey:@"status"] integerValue] == 0) {
            NSString *ErrorString = [NSString stringWithFormat:@"%@",[responseDict valueForKey:@"message"]];
            [Helper ISAlertTypeError:@"Error!!" andMessage:ErrorString];
        }
        else{
            NSLog(@"%@",responseDict);
            NSString *ErrorString = [NSString stringWithFormat:@"%@",[responseDict valueForKey:@"message"]];
            [Helper ISAlertTypeSuccess:@"Success!!" andMessage:ErrorString];
            self.mCancelButton.enabled = NO ;
            
        }
        [Helper hideLoaderSVProgressHUD];
        
    } onError:^(NSError * _Nullable Error) {
        NSLog(@"%@",Error);
        NSString *ErrorString = [NSString stringWithFormat:@"%@",Error];
        [Helper hideLoaderSVProgressHUD];
        [Helper ISAlertTypeError:@"Error!!" andMessage:ErrorString];
        
    }];
}



- (IBAction)CancelButtonTap:(id)sender {
    [self BackButtonAction:nil];
}

- (IBAction)CurrentLocationButtonTap:(id)sender {
    [locationManager startUpdatingLocation];
}




-(void)PostData
{
    
    CLLocationCoordinate2D coordinate = [DM getLocation];
    NSString *latLong = [NSString stringWithFormat:@"%f,%f", coordinate.latitude,coordinate.longitude];
    
    [Helper showLoaderVProgressHUD];
    NSString * path = [NSString stringWithFormat:@"%@logsedit",kServiceBaseURL];
    NSMutableDictionary * parameter = [[NSMutableDictionary alloc]init];
    
    
    [parameter setValue:self.driverId forKey:@"driverId"];
    [parameter setValue:[_mDataDict valueForKey:@"start_time"] forKey:@"startTime"];
    [parameter setValue:[_mDataDict valueForKey:@"start_date"] forKey:@"date"];
    [parameter setValue:self.mStartTimeTF.text forKey:@"editedDriverStartTime"];
    [parameter setValue:self.mEndTimeTF.text forKey:@"editedDriverEndTime"];
    [parameter setValue:modeString forKey:@"editedriverMode"];
    [parameter setValue:self.mNotesTF.text forKey:@"notes"];
    [parameter setValue:self.mLocationTF.text forKey:@"address"];
    [parameter setValue:_personalUse forKey:@"personal_use"];
    [parameter setValue:_yardMove forKey:@"yard_move"];
    [parameter setValue:latLong forKey:@"lat_long"];

    
    
    
   
    
    [DM PostRequest:path parameter:parameter onCompletion:^(id  _Nullable dict) {
        
        NSError *errorJson=nil;
        NSDictionary* responseDict = [NSJSONSerialization JSONObjectWithData:dict options:kNilOptions error:&errorJson];
        NSLog(@"%@",responseDict);
        if ([[responseDict valueForKey:@"status"] integerValue] == 0) {
             NSString *ErrorString = [NSString stringWithFormat:@"%@",[responseDict valueForKey:@"message"]];
             [Helper ISAlertTypeError:@"Error!!" andMessage:ErrorString];
        }
        else{
            NSLog(@"%@",responseDict);
            NSString *ErrorString = [NSString stringWithFormat:@"%@",[responseDict valueForKey:@"message"]];
            [Helper ISAlertTypeSuccess:@"Success!!" andMessage:ErrorString];
            self.mCancelButton.enabled = NO ;
            
        }
        [Helper hideLoaderSVProgressHUD];
    } onError:^(NSError * _Nullable Error) {
        NSLog(@"%@",Error);
        NSString *ErrorString = [NSString stringWithFormat:@"%@",Error];
        [Helper hideLoaderSVProgressHUD];
        [Helper ISAlertTypeError:@"Error!!" andMessage:ErrorString];

    }];
}








-(void)InsertLogData
{
    CLLocationCoordinate2D coordinate = [DM getLocation];
    NSString *latLong = [NSString stringWithFormat:@"%f,%f", coordinate.latitude,coordinate.longitude];
    

    if ([modeString isEqualToString:@""]) {
        [Helper ISAlertTypeWarning:@"Warning" andMessage:@"Please Select Status"];
        return;
    }
    if ([self.mStartTimeTF.text isEqualToString:@""]) {
        [Helper ISAlertTypeWarning:@"Warning" andMessage:@"Please Select Start Time"];
        return;
    }
    if ([self.mEndTimeTF.text isEqualToString:@""]) {
        [Helper ISAlertTypeWarning:@"Warning" andMessage:@"Please Select End Time"];
        return;
    }
    if ([self.mLocationTF.text isEqualToString:@""]) {
        [Helper ISAlertTypeWarning:@"Warning" andMessage:@"Please Enter Location"];
        return;
    }
    [Helper showLoaderVProgressHUD];
    
    NSString * path = [NSString stringWithFormat:@"%@EditInsertLogs",kServiceBaseURL];
    NSMutableDictionary * parameter = [[NSMutableDictionary alloc]init];
    [parameter setValue:self.driverId forKey:@"driverId"];
    [parameter setValue:self.mStartTimeTF.text forKey:@"start_time"];
    [parameter setValue:self.mEndTimeTF.text forKey:@"end_time"];
    [parameter setValue:modeString forKey:@"mode"];
    [parameter setValue:self.mNotesTF.text forKey:@"notes"];
    [parameter setValue:self.mLocationTF.text forKey:@"address"];
    [parameter setValue:_personalUse forKey:@"personal_use"];
    [parameter setValue:_yardMove forKey:@"yard_move"];
    [parameter setValue:latLong forKey:@"lat_long"];
    [parameter setValue:self.mSelectedDate forKey:@"date"];
    
    [DM PostRequest:path parameter:parameter onCompletion:^(id  _Nullable dict) {
        
        NSError *errorJson=nil;
        NSDictionary* responseDict = [NSJSONSerialization JSONObjectWithData:dict options:kNilOptions error:&errorJson];
        NSLog(@"%@",responseDict);
        if ([[responseDict valueForKey:@"status"] integerValue] == 0) {
            NSString *ErrorString = [NSString stringWithFormat:@"%@",[responseDict valueForKey:@"message"]];
            [Helper ISAlertTypeError:@"Error!!" andMessage:ErrorString];
        }
        else{
            NSLog(@"%@",responseDict);
            NSString *ErrorString = [NSString stringWithFormat:@"%@",[responseDict valueForKey:@"message"]];
            [Helper ISAlertTypeSuccess:@"Success!!" andMessage:ErrorString];
            self.mCancelButton.enabled = NO ;
            
        }
        [Helper hideLoaderSVProgressHUD];
        
    } onError:^(NSError * _Nullable Error) {
        NSLog(@"%@",Error);
        NSString *ErrorString = [NSString stringWithFormat:@"%@",Error];
        [Helper hideLoaderSVProgressHUD];
        [Helper ISAlertTypeError:@"Error!!" andMessage:ErrorString];

    }];
}



- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    currentLocation = [locations objectAtIndex:0];
    [locationManager stopUpdatingLocation];
    NSLog(@"Detected Location : %f, %f", currentLocation.coordinate.latitude, currentLocation.coordinate.longitude);
    CLGeocoder *geocoder = [[CLGeocoder alloc] init] ;
    [geocoder reverseGeocodeLocation:currentLocation
                   completionHandler:^(NSArray *placemarks, NSError *error) {
                       if (error){
                           NSLog(@"Geocode failed with error: %@", error);
                           return;
                       }
                       CLPlacemark *placemark = [placemarks objectAtIndex:0];
                       NSLog(@"placemark.ISOcountryCode %@",placemark.ISOcountryCode);
                       self.mLocationTF.text = [NSString stringWithFormat:@"%@",placemark.locality];
                   }];}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    NSLog(@"failed to fetch current location : %@", error);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




- (IBAction)OnDutyYardMoveButtonAction:(id)sender {
    
    if (self.mOnDutyYardMoveButton.selected) {
        self.mOnDutyYardMoveButton.selected = NO ;
        self.yardMove = kZero ;
        [self OnDutyButtonAction:self];

    }
    else{
        self.mOnDutyYardMoveButton.selected = YES ;
       // self.mRemarksPopUpView.hidden = NO ;
        self.yardMove = kOne ;
        [self OnDutyButtonAction:self];

        
        

    }
}

- (IBAction)OffDutyPersonalUseButtonAction:(id)sender {
    
    if (self.mOffDutyPersonalUseButton.selected) {
        self.mOffDutyPersonalUseButton.selected = NO ;
        self.personalUse = kZero ;
        [self OffDutyButtonAction:self];

        
    }else{
        self.mOffDutyPersonalUseButton.selected = YES ;
       // self.mRemarksPopUpView.hidden = NO ;
        self.personalUse = kOne ;
        [self OffDutyButtonAction:self];
    }
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
