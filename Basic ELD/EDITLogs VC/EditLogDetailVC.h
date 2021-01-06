//
//  EditLogDetailVC.h
//  Basic ELD
//
//  Created by Manoj Gadamsetty on 02/09/17.
//  Copyright © 2017 Gaurav Verma. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import "Constants.h"
#import "Helper.h"
#import "DataManager.h"
#import "AppDelegate.h"

@interface EditLogDetailVC : UIViewController<CLLocationManagerDelegate>


//Header View
@property (weak, nonatomic) IBOutlet UIView *mHeaderView;
@property (weak, nonatomic) IBOutlet UILabel *mDriverName;
@property (weak, nonatomic) IBOutlet UILabel *mVehicleNumber;
@property (weak, nonatomic) IBOutlet UIProgressView *mProgressBar;
@property (weak, nonatomic) IBOutlet UILabel *mErrorsLabel;

@property (weak, nonatomic) IBOutlet UITextField *mStartTimeTF;
@property (weak, nonatomic) IBOutlet UIImageView *mStartTimeLockIV;
@property (weak, nonatomic) IBOutlet UITextField *mEndTimeTF;
@property (weak, nonatomic) IBOutlet UIImageView *mEndTimeLockIV;

@property (strong, nonatomic) IBOutlet UIButton *mOnDutyButton;
@property (strong, nonatomic) IBOutlet UIButton *mOffDutyButton;
@property (strong, nonatomic) IBOutlet UIButton *mSleeperButton;
@property (strong, nonatomic) IBOutlet UIButton *mDrivingButton;

@property (strong, nonatomic) NSDictionary * mDataDict;


@property (strong, nonatomic) IBOutlet UIButton *mOffDutyPersonalUseButton;
@property (strong, nonatomic) IBOutlet UIButton *mOnDutyYardMoveButton;

@property (strong, nonatomic) IBOutlet UIView *mOffDutyPersonalUseView;
@property (strong, nonatomic) IBOutlet UIView *mOnDutyYardMoveView;

@property (strong, nonatomic) IBOutlet UIView *mUpperView;
@property (strong, nonatomic) IBOutlet UIView *mLowerView;


- (IBAction)OnDutyYardMoveButtonAction:(id)sender;
- (IBAction)OffDutyPersonalUseButtonAction:(id)sender;

@property (strong, nonatomic) SKUser * driverModel ;


@property (strong, nonatomic) NSString * mSelectedDate ;

@property (strong, nonatomic) NSString * personalUse ;
@property (strong, nonatomic) NSString * yardMove ;
@property (strong, nonatomic) NSString * OnutyStatus ;

@property (strong, nonatomic) NSString * driverId;
@property (strong, nonatomic) NSString * flowMsg;


@property (weak, nonatomic) IBOutlet UIButton *mCancelButton;

- (IBAction)OffDutyButtonAction:(id)sender;
- (IBAction)OnDutyButtonAction:(id)sender;
- (IBAction)SleeperButtonAction:(id)sender;
- (IBAction)DrivingButtonAction:(id)sender;

@property (weak, nonatomic) IBOutlet UITextField *mLocationTF;
@property (weak, nonatomic) IBOutlet UITextField *mNotesTF;
- (IBAction)BackButtonAction:(id)sender;
- (IBAction)SaveButtonTap:(id)sender;
- (IBAction)CancelButtonTap:(id)sender;
- (IBAction)CurrentLocationButtonTap:(id)sender;

@end
