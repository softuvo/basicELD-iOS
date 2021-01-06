//
//  ChangeStatusVC.h
//  Basic ELD
//
//  Created by Gaurav Verma on 09/05/17.
//  Copyright © 2017 Gaurav Verma. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIViewController+MJPopupViewController.h"
#import "Constants.h"
#import "Helper.h"
#import "DataManager.h"
#import "AppDelegate.h"


@protocol ChangeStatusPopupDelegate;

@interface ChangeStatusVC : UIViewController<UITextFieldDelegate>
@property (assign, nonatomic) id <ChangeStatusPopupDelegate>delegate;
- (IBAction)CloseButtonAction:(id)sender;

- (IBAction)OffDutyButtonAction:(id)sender;
- (IBAction)OnDutyButtonAction:(id)sender;
- (IBAction)SleeperButtonAction:(id)sender;
- (IBAction)DrivingButtonAction:(id)sender;
- (IBAction)DutyStatusButtonAction:(id)sender;
- (IBAction)UncategorizedDrivingTimeButtonAction:(id)sender;

- (IBAction)OnDutyYardMoveButtonAction:(id)sender;
- (IBAction)OffDutyPersonalUseButtonAction:(id)sender;

@property (strong, nonatomic) IBOutlet UIButton *mOnDutyYardMoveButton;
@property (strong, nonatomic) IBOutlet UIButton *mOffDutyPersonalUseButton;
@property (strong, nonatomic)NSString *enterdPin;

@property (strong, nonatomic) IBOutlet UILabel *mDriverOnename;
@property (strong, nonatomic) IBOutlet UILabel *mDriverTwoName;
@property (strong, nonatomic) IBOutlet UIButton *mChangeStatusButton;

- (IBAction)ChangeStatusButtonAction:(id)sender;


@property (strong, nonatomic) IBOutlet UIView *mOffDutyPersonalUseView;
@property (strong, nonatomic) IBOutlet UIView *mOnDutyYardMoveView;

@property (strong, nonatomic) IBOutlet UIView *mOnDutyView;
@property (strong, nonatomic) IBOutlet UIView *mOffDutyView;
@property (strong, nonatomic) IBOutlet UIView *mSleeperView;
@property (strong, nonatomic) IBOutlet UIView *mDrivingView;
@property (strong, nonatomic) IBOutlet UIView *mEditDailyLogsView;

@property (strong, nonatomic) IBOutlet UIButton *mOnDutyButton;
@property (strong, nonatomic) IBOutlet UIButton *mOffDutyButton;
@property (strong, nonatomic) IBOutlet UIButton *mSleeperButton;
@property (strong, nonatomic) IBOutlet UIButton *mEditLogButton;
@property (strong, nonatomic) IBOutlet UIButton *mDrivingButton;
@property (strong, nonatomic) IBOutlet UIButton *mUncategorizedDrivingTimeButton;


@property (strong, nonatomic) IBOutlet UIControl *CFPinView;

@property (strong, nonatomic) IBOutlet UITextField *pin1TF;
@property (strong, nonatomic) IBOutlet UITextField *pin2TF;
@property (strong, nonatomic) IBOutlet UITextField *pin3TF;
@property (strong, nonatomic) IBOutlet UITextField *pin4TF;
- (IBAction)CFPinCloseButtonAction:(id)sender;
- (IBAction)CFPinSubmitButtonAction:(id)sender;

@property (strong, nonatomic) IBOutlet UIImageView *mOnDutyIV;
@property (strong, nonatomic) IBOutlet UIImageView *mOffDutyIV;
@property (strong, nonatomic) IBOutlet UIImageView *mDrivingIV;
@property (strong, nonatomic) IBOutlet UIImageView *mEditDataRemarkIV;
@property (strong, nonatomic) IBOutlet UIImageView *mSleeperIV;

@property (strong, nonatomic) IBOutlet UILabel *mDriverNameLabel;


@property (strong, nonatomic) NSMutableDictionary * preSelectedContent ;
@property (strong, nonatomic) NSString * preSelectedRef ;
@property (strong, nonatomic) NSString * preSelectedPopUpRef ;
@property (strong, nonatomic) NSString * preSelectedStatusRef ;
@property (strong, nonatomic) NSString * driverId ;
@property (strong, nonatomic) NSString * driverPin ;
@property (strong, nonatomic) NSString * flowRef ;
@property (strong, nonatomic) NSString * driverTwoName ;
@property (strong, nonatomic) SKUser * driverModel ;


@property (strong, nonatomic) NSString * personalUse ;
@property (strong, nonatomic) NSString * yardMove ;
@property (strong, nonatomic) NSString * OnutyStatus ;



//
@property (weak, nonatomic) IBOutlet UIControl *mRemarksPopUpView;
@property (weak, nonatomic) IBOutlet UITextView *mRemarksTextView;

- (IBAction)RemarksSubmitButtonAction:(id)sender;
- (IBAction)RemarksCloseButtonAction:(id)sender;






@end


@protocol ChangeStatusPopupDelegate<NSObject>
@optional

- (void)ChangeStatuscancelButtonClicked:(ChangeStatusVC*)ChangeStatusViewController;

- (IBAction)OfDutyButtonAction:(id)sender;
- (IBAction)OnDutyButtonAction:(id)sender;
- (IBAction)SleepButtonAction:(id)sender;
- (IBAction)DrivingButtonAction:(id)sender;
- (IBAction)DutyStatusButtonAction:(id)sender;


@end
