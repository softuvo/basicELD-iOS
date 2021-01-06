//
//  InspectionLogVC.h
//  Basic ELD
//
//  Created by Gaurav Verma on 09/10/17.
//  Copyright © 2017 Gaurav Verma. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "Helper.h"
#import "DataManager.h"
#import "SKUser.h"
#import "DZNWebViewController.h"

@interface InspectionLogVC : UIViewController
- (IBAction)BackButtonAction:(id)sender;

//User Data
@property (nonatomic,strong)SKUser *driverOne;
@property (nonatomic,strong)SKUser *driverTwo;
//Header
@property (weak, nonatomic) IBOutlet UIView *mHeaderView;
@property (weak, nonatomic) IBOutlet UILabel *mDriverNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *mVehicalNumberLabel;
@property (weak, nonatomic) IBOutlet UIProgressView *mProgressiveBar;
@property (weak, nonatomic) IBOutlet UILabel *mErrorTypeLabel;

@property (weak, nonatomic) IBOutlet UIView *mDriversSelectionView;
@property (weak, nonatomic) IBOutlet UIButton *mDriverOneButton;
@property (weak, nonatomic) IBOutlet UIButton *mDriverTwoButton;
@property (weak, nonatomic) IBOutlet UITableView *mTableView;
@property (weak, nonatomic) IBOutlet UIView *mInspectionlogView;

- (IBAction)DriverOneButtonAction:(id)sender;
- (IBAction)DriverTwoButtonAction:(id)sender;



@property (weak, nonatomic) IBOutlet UITextField *mDateTextField;
@property (weak, nonatomic) IBOutlet UIButton *mNextDayButton;
@property (weak, nonatomic) IBOutlet UIButton *mPreviousDayButton;
- (IBAction)PreviousDayTap:(id)sender;
- (IBAction)NextDayTap:(id)sender;
@property (strong, nonatomic) IBOutlet UIView *mDayControllView;


// Passcode
@property (strong, nonatomic) IBOutlet UIControl *CFPinView;
@property (strong, nonatomic) IBOutlet UITextField *pin1TF;
@property (strong, nonatomic) IBOutlet UITextField *pin2TF;
@property (strong, nonatomic) IBOutlet UITextField *pin3TF;
@property (strong, nonatomic) IBOutlet UITextField *pin4TF;
- (IBAction)CFPinCloseButtonAction:(id)sender;
- (IBAction)CFPinSubmitButtonAction:(id)sender;


@end
