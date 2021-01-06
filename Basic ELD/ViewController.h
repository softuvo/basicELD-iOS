//
//  ViewController.h
//  Basic ELD
//
//  Created by Gaurav Verma on 04/05/17.
//  Copyright © 2017 Gaurav Verma. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>
#import "Constants.h"
#import "Helper.h"
#import "DataManager.h"
#import "AppDelegate.h"
#import "SKUser.h"
#import "DashBoardPressedVC.h"
#import "MZTimerLabel.h"

@import GooglePlaces;
@import GooglePlacePicker;
@import GoogleMaps;

@interface ViewController : UIViewController<CLLocationManagerDelegate,UIAlertViewDelegate,DashboardPressedPopupDelegate,GMSPlacePickerViewControllerDelegate,MZTimerLabelDelegate>




@property (nonatomic,strong)SKUser *driverOne;
@property (nonatomic,strong)SKUser *driverTwo;
@property (strong, nonatomic) IBOutlet UIButton *SideBarButton;

@property (strong, nonatomic) IBOutlet UILabel *BasicEldNavigationlable;

@property (strong, nonatomic) IBOutlet UILabel *MilesDrivenLable;
@property (strong, nonatomic) IBOutlet UILabel *TimetillBreak;

@property (strong, nonatomic) IBOutlet UILabel *mStatusLable;
@property (strong, nonatomic) IBOutlet UILabel *mTruckNumber;
@property (strong, nonatomic) IBOutlet UIButton *Driver1Button;
@property (strong, nonatomic) IBOutlet UIButton *Driver2Button;
@property (strong, nonatomic) IBOutlet UIButton *mapButton;
@property (strong, nonatomic) IBOutlet UILabel *Erros_Title;
@property (strong, nonatomic) IBOutlet UILabel *TimeRemaimngLable;

@property (strong, nonatomic) IBOutlet UIView *CustomNavigationView;
@property (strong, nonatomic) IBOutlet UIImageView *ErosBoxes;
@property (strong, nonatomic) IBOutlet UILabel *mDriverOneName;
@property (strong, nonatomic) IBOutlet UILabel *mDriverTwoName;
@property (strong, nonatomic) IBOutlet UILabel *mErrorsLabel;
@property (strong, nonatomic) IBOutlet MZTimerLabel *mTimeRemainingLabel;
@property (strong, nonatomic) IBOutlet UILabel *mMilesDrivenLabel;
@property (strong, nonatomic) IBOutlet MZTimerLabel *mTimeTillBreakLabel;
@property (strong, nonatomic) IBOutlet UIProgressView *mProgressiveBar;

@property (strong, nonatomic) IBOutlet UILabel *mDriverTwoTitleLabel;
@property (strong, nonatomic) IBOutlet UILabel *mDriverOneTitleLabel;

@property (strong, nonatomic) IBOutlet UILabel *StatusTitleLabel;

@property (strong, nonatomic) IBOutlet UIImageView *mDriverOneStatusIV;
@property (strong, nonatomic) IBOutlet UIImageView *mDriverTwoStatusIV;

@property () BOOL mrestrictRotation;

@property (nonatomic) UIDeviceOrientation currentDeviceOrientation;
@property (weak, nonatomic) IBOutlet UIScrollView *ScrollView;

@property (weak, nonatomic) IBOutlet UIView *ContentView;

@property (nonatomic, retain) IBOutlet MKMapView *mMapView;

@property (strong, nonatomic) IBOutlet UIView *Driver1View;
@property (strong, nonatomic) IBOutlet UIView *Driver2View;
- (IBAction)Driver1StatusButtonAction:(id)sender;
- (IBAction)Driver2StatusButtonAction:(id)sender;


-(IBAction)MapButtonAction:(id)sender;
-(IBAction)ChangeStatusButtonAction:(id)sender;
-(IBAction)trayButtonAction:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *mDocumentsButton;
@property (strong, nonatomic) IBOutlet UIButton *mEditLogButton;
@property (strong, nonatomic) IBOutlet UIButton *mInspectLogButton;


- (IBAction)DashBoardPressedButtonAction:(id)sender;

- (IBAction)InspectLogButtonAction:(id)sender;
- (IBAction)EditLogButtonAction:(id)sender;
- (IBAction)DocumentsButtonAction:(id)sender;

// Passcode
@property (strong, nonatomic) IBOutlet UIControl *CFPinView;
@property (strong, nonatomic) IBOutlet UITextField *pin1TF;
@property (strong, nonatomic) IBOutlet UITextField *pin2TF;
@property (strong, nonatomic) IBOutlet UITextField *pin3TF;
@property (strong, nonatomic) IBOutlet UITextField *pin4TF;
- (IBAction)CFPinCloseButtonAction:(id)sender;
- (IBAction)CFPinSubmitButtonAction:(id)sender;
@property (strong, nonatomic) IBOutlet UIView *BothDriverView;
@property (strong, nonatomic) IBOutlet UIImageView *DashboardImage;
@property (strong, nonatomic) IBOutlet UIImageView *StaticGrafImage;
@property (strong, nonatomic) IBOutlet UIView *DriversView;
@property (strong, nonatomic) IBOutlet UIView *GraphView;
@property (strong, nonatomic) IBOutlet UIButton *DashBoardButton;


@end

