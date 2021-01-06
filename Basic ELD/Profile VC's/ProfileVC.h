//
//  ProfileVC.h
//  Basic ELD
//
//  Created by Manoj Gadamsetty on 08/09/17.
//  Copyright © 2017 Gaurav Verma. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataManager.h"
#import "SKUser.h"

@interface ProfileVC : UIViewController<UITextFieldDelegate,UIActionSheetDelegate>


@property (nonatomic,strong)SKUser *driverOne;
@property (nonatomic,strong)SKUser *driverTwo;

@property (weak, nonatomic) IBOutlet UIView *mHeaderView;
@property (weak, nonatomic) IBOutlet UILabel *mDriverNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *mVehicalNumberLabel;
@property (weak, nonatomic) IBOutlet UIProgressView *mProgressiveBar;
@property (weak, nonatomic) IBOutlet UILabel *mErrorTypeLabel;

@property (weak, nonatomic) IBOutlet UIView *mDriverView;
@property (weak, nonatomic) IBOutlet UIScrollView *mScrollView;
@property (weak, nonatomic) IBOutlet UIView *mContentView;
@property (weak, nonatomic) IBOutlet UILabel *mHeadingLabel;

@property (weak, nonatomic) IBOutlet UITextField *mDriverNameTF;
@property (weak, nonatomic) IBOutlet UITextField *mUserNameTF;
@property (weak, nonatomic) IBOutlet UITextField *mDLIssuingStateTF;
@property (weak, nonatomic) IBOutlet UITextField *mDLTF;
@property (weak, nonatomic) IBOutlet UITextField *mDotCarrierIDTF;
@property (weak, nonatomic) IBOutlet UITextField *mCarrierTF;
@property (weak, nonatomic) IBOutlet UITextField *mHomeTimeZoneTF;
@property (weak, nonatomic) IBOutlet UITextField *mEmailTF;
@property (weak, nonatomic) IBOutlet UITextField *mPhoneNumberTF;
@property (weak, nonatomic) IBOutlet UITextField *mPowerUnitNumberTF;
@property (weak, nonatomic) IBOutlet UITextField *mTrailerNumberTF;
@property (weak, nonatomic) IBOutlet UIButton *mCycleTypeEditButton;
@property (weak, nonatomic) IBOutlet UILabel *mCycleNameLabel;
@property (weak, nonatomic) IBOutlet UITextField *mTrailer1NumberTF;
@property (weak, nonatomic) IBOutlet UITextField *mTrailer2NumberTF;
@property (weak, nonatomic) IBOutlet UITextField *mDLExpityTF;

@property (weak, nonatomic) IBOutlet UIButton *mDriverButton;
@property (weak, nonatomic) IBOutlet UILabel *mDriverLabel;
@property (weak, nonatomic) IBOutlet UITextField *mShippingDocNumber;

- (IBAction)CycleTypeEditButton:(id)sender;
- (IBAction)ResetPinButtonAction:(id)sender;
- (IBAction)ResetPasswordButtonAction:(id)sender;
- (IBAction)OKButtonAction:(id)sender;

////Driver Selection
@property (weak, nonatomic) IBOutlet UIButton *mDriverOneButton;
- (IBAction)DriverOneButtonTap:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *mDriverTwoButton;
- (IBAction)DriverTwoButtonTap:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *mRestView;

@property (weak, nonatomic) IBOutlet UILabel *mDriverOneLabel;
@property (weak, nonatomic) IBOutlet UILabel *mDriverTwoLabel;



@property (weak, nonatomic) IBOutlet UIButton *mYardMoveAuthYesButton;
@property (weak, nonatomic) IBOutlet UIButton *mYardMoveAuthNoButton;
@property (weak, nonatomic) IBOutlet UIButton *mPersonalUseAuthYesButton;
@property (weak, nonatomic) IBOutlet UIButton *mPersonalUseAuthNoButton;

@property (strong, nonatomic) IBOutlet UITextField *pin1TF;
@property (strong, nonatomic) IBOutlet UITextField *pin2TF;
@property (strong, nonatomic) IBOutlet UITextField *pin3TF;
@property (strong, nonatomic) IBOutlet UITextField *pin4TF;

- (IBAction)CFPinCloseButtonAction:(id)sender;
- (IBAction)CFPinSubmitButtonAction:(id)sender;

@property (weak, nonatomic) IBOutlet UIView *CFPinView;

- (IBAction)BackButtonAction:(id)sender;



@end
