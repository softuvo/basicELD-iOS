//
//  ADDRemarksVC.m
//  Basic ELD
//
//  Created by Manoj Gadamsetty on 11/09/17.
//  Copyright © 2017 Gaurav Verma. All rights reserved.
//

#import "ADDRemarksVC.h"

@interface ADDRemarksVC (){
    
    CLLocationManager *locationManager;
    CLLocation *currentLocation;
    
    int locationFetchCounter;
    
    UIDatePicker *datePicker ;
    NSDateFormatter *timeFormatter;
}

@end

@implementation ADDRemarksVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    IQKeyboardManager.sharedManager.enable = true;
    
    
    self.mHeaderView.layer.borderWidth = 1;
    self.mHeaderView.layer.borderColor = [[UIColor whiteColor]CGColor];
    
    NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"NL"];
    timeFormatter = [[NSDateFormatter alloc] init];
    [timeFormatter setDateFormat:@"HH:mm:ss"];
    
    datePicker = [[UIDatePicker alloc]init];
    [datePicker setDate:[NSDate date]];
    datePicker.datePickerMode = UIDatePickerModeTime;
    [datePicker setLocale:locale];
    [datePicker addTarget:self action:@selector(StartTimeDoneButtonAction) forControlEvents:UIControlEventValueChanged];
    [self.mStartTimeTF setInputView:datePicker];
    
    
    locationManager = [CLLocationManager new];
    locationManager.delegate = self;
    locationManager.distanceFilter = kCLDistanceFilterNone;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;


    // Do any additional setup after loading the view.
}

-(void)StartTimeDoneButtonAction{
    self.mStartTimeTF.text = [timeFormatter stringFromDate:datePicker.date];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)BackButtonAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)CurrentLocationButtonTap:(id)sender {
    [locationManager startUpdatingLocation];
}

- (IBAction)CancelBUttonTap:(id)sender {
    [self BackButtonAction:nil];
}

- (IBAction)SaveButtonTap:(id)sender {
    
    NSString * path = [NSString stringWithFormat:@"%@addRemark",kServiceBaseURL];
    NSMutableDictionary * parameter = [[NSMutableDictionary alloc]init];
    [parameter setValue:self.driverId forKey:@"driverId"];
    [parameter setValue:self.mStartTimeTF.text forKey:@"time"];
    [parameter setValue:self.mLocationTF.text forKey:@"location"];
    [parameter setValue:self.mNotesTF.text forKey:@"notes"];
    [parameter setValue:self.selectedDate forKey:@"start_date"];

    [DM PostRequest:path parameter:parameter onCompletion:^(id  _Nullable dict) {
        
        NSError *errorJson=nil;
        NSDictionary* responseDict = [NSJSONSerialization JSONObjectWithData:dict options:kNilOptions error:&errorJson];
        NSLog(@"%@",responseDict);
        NSString *ErrorString = [NSString stringWithFormat:@"%@",[responseDict valueForKey:@"message"]];

        if ([[responseDict valueForKey:@"status"] integerValue] == 0) {
            [Helper ISAlertTypeError:@"Error!!" andMessage:ErrorString];
        }
        else{
            NSLog(@"%@",responseDict);
            [Helper ISAlertTypeSuccess:@"Success!!" andMessage:ErrorString];

        }
        
    } onError:^(NSError * _Nullable Error) {
        NSLog(@"%@",Error);
        NSString *ErrorString = [NSString stringWithFormat:@"%@",Error];
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


@end
