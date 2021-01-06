//
//  ChangeCurrentDutyStatusVC.m
//  Basic ELD
//
//  Created by Manoj Gadamsetty on 12/09/17.
//  Copyright © 2017 Gaurav Verma. All rights reserved.
//

#import "ChangeCurrentDutyStatusVC.h"

@interface ChangeCurrentDutyStatusVC (){
    NSString * modeString ;
    
    
    
    CLLocationManager *locationManager;
    CLLocation *currentLocation;
    
    int locationFetchCounter;
    
    
}


@end

@implementation ChangeCurrentDutyStatusVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.mHeaderView.layer.borderWidth = 1;
    self.mHeaderView.layer.borderColor = [[UIColor whiteColor]CGColor];
    
    modeString = nil;
    locationManager = [CLLocationManager new];
    locationManager.delegate = self;
    locationManager.distanceFilter = kCLDistanceFilterNone;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)OffDutyButtonAction:(id)sender{
    self.mOnDutyButton.selected = NO ;
    self.mOffDutyButton.selected = YES ;
    self.mDrivingButton.selected = NO ;
    self.mSleeperButton.selected = NO ;
    modeString = kStatusTypeOffDuty;
}
- (IBAction)OnDutyButtonAction:(id)sender{
    
    self.mOnDutyButton.selected = YES ;
    self.mOffDutyButton.selected = NO ;
    self.mDrivingButton.selected = NO ;
    self.mSleeperButton.selected = NO ;
    modeString = kStatusTypeOnDuty;
    
}
- (IBAction)SleeperButtonAction:(id)sender{
    
    self.mOnDutyButton.selected = NO ;
    self.mOffDutyButton.selected = NO ;
    self.mDrivingButton.selected = NO ;
    self.mSleeperButton.selected = YES ;
    modeString = kStatusTypeSleeper;
}
- (IBAction)DrivingButtonAction:(id)sender{
    self.mOnDutyButton.selected = NO ;
    self.mOffDutyButton.selected = NO ;
    self.mDrivingButton.selected = YES ;
    self.mSleeperButton.selected = NO ;
    modeString = kStatusTypeDriving;
    
}

- (IBAction)CurrentLocationButtonTap:(id)sender {
    [locationManager startUpdatingLocation];
}


- (IBAction)SaveButtonTap:(id)sender {
    [self PostData];
}

- (IBAction)CancelBUttonTap:(id)sender {
    [self BackButtonAction:nil];
}
- (IBAction)BackButtonAction:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)PostData
{
    if (modeString.length == 0) {
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
    [parameter setValue:self.mLocationTF.text forKey:@"location"];
    [parameter setValue:self.mNotesTF.text forKey:@"notes"];
    
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




/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
