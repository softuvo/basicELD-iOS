//
//  DVIRVC.h
//  Basic ELD
//
//  Created by Deepak  on 19/08/17.
//  Copyright © 2017 Gaurav Verma. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DVIRDetailVC.h"
#import "DataManager.h"
#import "SignatureView.h"
#import "IQKeyboardManager.h"
#import "SKUser.h"


@interface DVIRVC : UIViewController<UITextFieldDelegate,UIActionSheetDelegate>

//Header View
@property (weak, nonatomic) IBOutlet UIView *mHeaderView;
@property (weak, nonatomic) IBOutlet UILabel *mDriverName;
@property (weak, nonatomic) IBOutlet UILabel *mVehicleNumber;
@property (weak, nonatomic) IBOutlet UIProgressView *mProgressBar;
@property (weak, nonatomic) IBOutlet UILabel *mErrorsLabel;
@property (weak, nonatomic) IBOutlet UIView *mDVIRLogView;

@property (weak, nonatomic) IBOutlet UIView *mDriversSelectionView;
@property (weak, nonatomic) IBOutlet UIButton *mDriverOneButton;
@property (weak, nonatomic) IBOutlet UIButton *mDriverTwoButton;

@property (weak, nonatomic) IBOutlet UIButton *mNextDayButton;

@property (weak, nonatomic) IBOutlet UIButton *mPreviousDayButton;



- (IBAction)DriverOneButtonAction:(id)sender;
- (IBAction)DriverTwoButtonAction:(id)sender;
//User Data
@property (nonatomic,strong)SKUser *driverOne;
@property (nonatomic,strong)SKUser *driverTwo;

@property (weak, nonatomic) IBOutlet UITableView *mTableView;
- (IBAction)BackButtonAction:(id)sender;
@property (weak, nonatomic) IBOutlet UITextView *remarksTextView1;
@property (weak, nonatomic) IBOutlet UIButton *mConditionsCheckMarkButton;
@property (weak, nonatomic) IBOutlet UITextField *mDateTextField;
@property (weak, nonatomic) IBOutlet UITextField *mVehicleTextField;
@property (strong, nonatomic) IBOutlet UIView *mPopUPVIew;


@property (strong, nonatomic) SignatureView *signatureView ;
@property (strong, nonatomic) IBOutlet UIView *mSignaturePopUpView;

- (IBAction)SignaturePopUpCLoseButtonTap:(id)sender;

- (IBAction)SubmitButtonTap:(id)sender;

- (IBAction)ConditionsButtonTap:(id)sender;
- (IBAction)SignAndSubmitButtonTap:(id)sender;





- (IBAction)PreviousDayTap:(id)sender;
- (IBAction)NextDayTap:(id)sender;
- (IBAction)OverlaybackgroundTap:(id)sender;

@property (weak, nonatomic) IBOutlet UIScrollView *mScrollView;
@property (weak, nonatomic) IBOutlet UIView *mContentView;

// Passcode
@property (strong, nonatomic) IBOutlet UIControl *CFPinView;
@property (strong, nonatomic) IBOutlet UITextField *pin1TF;
@property (strong, nonatomic) IBOutlet UITextField *pin2TF;
@property (strong, nonatomic) IBOutlet UITextField *pin3TF;
@property (strong, nonatomic) IBOutlet UITextField *pin4TF;
- (IBAction)CFPinCloseButtonAction:(id)sender;
- (IBAction)CFPinSubmitButtonAction:(id)sender;



@end
