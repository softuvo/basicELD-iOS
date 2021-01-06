//
//  ViewController.m
//  Basic ELD
//
//  Created by Gaurav Verma on 04/05/17.
//  Copyright © 2017 Gaurav Verma. All rights reserved.
//

#import "ViewController.h"
#import "ChangeStatusVC.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self addmap];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(SelectedRelation:) name:KDutyStatusPopupNotification object:nil];
    
}


-(void)SelectedRelation:(NSNotification *)notif{
    NSDictionary *dct = [notif userInfo];
    NSLog(@"%@",dct);
    self.mStatusLable.text = [[dct valueForKey:@"val"] uppercaseString];
    
}



-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:YES];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
}


-(IBAction)trayButtonAction:(id)sender {
    [self ProfileUpdateWebServicehit];

    [DM.mAppObj.mSlideVC showRightPanelAnimated:YES];
}


-(void)addmap{
#pragma mark--------------------------------------------------------------------
#pragma mark MAP Cordinats Settings Start
#pragma mark--------------------------------------------------------------------
   
    self.mMapView.showsUserLocation = YES;
    self.mMapView.mapType = MKMapTypeStandard;
    self.mMapView.delegate = self;
    [self.mMapView setScrollEnabled:NO];
    [self.mMapView setZoomEnabled:NO];
}
- (void)mapView:(MKMapView *)aMapView didUpdateUserLocation:(MKUserLocation *)aUserLocation {
    MKCoordinateRegion region;
    MKCoordinateSpan span;
    span.latitudeDelta = 0.010;
    span.longitudeDelta = 0.010;
    CLLocationCoordinate2D location;
    location.latitude = aUserLocation.coordinate.latitude;
    location.longitude = aUserLocation.coordinate.longitude;
    region.span = span;
    region.center = location;
    [aMapView setRegion:region animated:YES];
}





- (IBAction)ChangeStatusButtonAction:(id)sender{
    ChangeStatusVC *ChangeStatusPopUp = [self.storyboard instantiateViewControllerWithIdentifier:@"ChangeStatuView"];
    ChangeStatusPopUp.delegate = self;
    [self presentPopupViewController:ChangeStatusPopUp animationType:MJPopupViewAnimationFade];
    
}

- (void)ChangeStatuscancelButtonClicked:(ChangeStatusVC*)ChangeStatusViewController{
    [self dismissPopupViewControllerWithanimationType:MJPopupViewAnimationFade];
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)ProfileUpdateWebServicehit
{
    UIImage *UserImage =  [UIImage imageNamed:@"user_icon.jpg"];
    
    if (UserImage == nil) {
        [Helper showAlert:@"" andMessage:@"Please select your profile picture" andButton:@"Ok"];
        return;
    }
    else{
        NSMutableDictionary *Parameter = [[NSMutableDictionary alloc] init];
        SKUser *currentUser = [[SKUser alloc] init];

        [Parameter setObject:@"4" forKey:@"id"];
        [Parameter setObject:@"Gaurav Verma" forKey:@"name"];
        [Parameter setObject:@"gaurav.verma.z@gmail.com" forKey:@"email"];
        [Parameter setObject:[Helper base64EncodedStringFromImage:UserImage] forKey:@"profile_image"];
        
        if (DM.mInternetStatus == false) {
            NSLog(@"No Internet Connection.");
            
            [Helper ISAlertTypeError:@"Internet Connection!!" andMessage:kNOInternet];
            
            return;
        }
        else{
            [Helper showLoaderVProgressHUD];
            NSString *path=[NSString stringWithFormat:@"%@updateprofile",kServiceBaseURL];
            
            [DM PostRequest:path parameter:Parameter onCompletion:^(id dict) {
                [Helper hideLoaderSVProgressHUD];
                NSError *errorJson=nil;
                
                NSString *myStrinag = [[NSString alloc] initWithData:dict encoding:NSUTF8StringEncoding];
                NSLog(@"%@",myStrinag);
                
                
                NSDictionary* responseDict = [NSJSONSerialization JSONObjectWithData:dict options:kNilOptions error:&errorJson];
                NSLog(@"%@",responseDict);
                
                if ([[responseDict valueForKey:@"responsestatus"] integerValue] == 0) {
                    NSString *ErrorString = [NSString stringWithFormat:@"%@",[responseDict valueForKey:@"message"]];
                    [Helper ISAlertTypeError:@"Error!!" andMessage:ErrorString];
                }
                else{
                    
                    [ISMessages showCardAlertWithTitle:@"Success!!"
                                               message:@"Profile Update Successfully"
                                              duration:3.f
                                           hideOnSwipe:YES
                                             hideOnTap:NO
                                             alertType:ISAlertTypeSuccess
                                         alertPosition:@(0).integerValue
                                               didHide:^(BOOL finished) {
                                                   NSLog(@"Alert did hide.");
                                               }];
                    
                    
                }
                
                
                
            } onError:^(NSError *Error) {
                [Helper hideLoaderSVProgressHUD];
                NSLog(@"%@",Error);
                NSString *ErrorString = [NSString stringWithFormat:@"%@",Error];
                [Helper ISAlertTypeError:@"Error!!" andMessage:ErrorString];
                
            }];
            
            
        }
        
    }

}


@end
