//
//  EditLogsVC.h
//  Basic ELD
//
//  Created by Manoj Gadamsetty on 30/08/17.
//  Copyright © 2017 Gaurav Verma. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EditCell.h"
#import "SKUser.h"

@interface EditLogsVC : UIViewController

@property (nonatomic,strong)SKUser *driverOne;
@property (nonatomic,strong)SKUser *driverTwo;

//Header View
@property (weak, nonatomic) IBOutlet UIView *mHeaderView;
@property (weak, nonatomic) IBOutlet UILabel *mDriverName;
@property (weak, nonatomic) IBOutlet UILabel *mVehicleNumber;
@property (weak, nonatomic) IBOutlet UIProgressView *mProgressBar;
@property (weak, nonatomic) IBOutlet UILabel *mErrorsLabel;

@property (weak, nonatomic) IBOutlet UIButton *mDriverOneButton;
@property (weak, nonatomic) IBOutlet UIButton *mDriverTwoButton;
@property (weak, nonatomic) IBOutlet UIButton *mUnidentifiedButton;
@property (strong, nonatomic) SKUser * driverModell ;


@property (weak, nonatomic) IBOutlet UIButton *mCertifyLogsButton;


- (IBAction)DriverOneButtonTap:(id)sender;
- (IBAction)UnidentifiedButtonTap:(id)sender;
- (IBAction)DriverTwoButtonTap:(id)sender;

@property (weak, nonatomic) IBOutlet UILabel *mDriverOneNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *mDriverTwoNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *mUnIdentifiedNameLabel;

@property (weak, nonatomic) IBOutlet UITextView *mLogRemarkTextView;

@property (weak, nonatomic) IBOutlet UITableView *mLogsTableView;

@property (weak, nonatomic) IBOutlet UITextField *mDateTextField;

@property (weak, nonatomic) IBOutlet UIView *mDriversView;
@property (weak, nonatomic) IBOutlet UIView *mEditlogView;


@property (weak, nonatomic) NSString *msg;

- (IBAction)BackButtonAction:(id)sender;
- (IBAction)ConfirmAndSignButtonAction:(id)sender;

//Pluse Button view
@property (weak, nonatomic) IBOutlet UIView *mPlusButtonPopUpView;
@property (weak, nonatomic) IBOutlet UIButton *mPopUpCloseButton;
@property (weak, nonatomic) IBOutlet UIButton *mChangeCurrentStatus;
@property (weak, nonatomic) IBOutlet UIButton *mInsertPastDutyStatus;
@property (weak, nonatomic) IBOutlet UIButton *mAddRemark;

- (IBAction)AddRemarkTap:(id)sender;
- (IBAction)CloseButtonAction:(id)sender;
- (IBAction)ChangeCurrentDutyStatusTap:(id)sender;
- (IBAction)InsertPastDutyStatus:(id)sender;

@property (weak, nonatomic) IBOutlet UIView *insertLogPopUpViewOne;
@property (weak, nonatomic) IBOutlet UIView *changeCurrentDutyStatusView;


// Passcode
@property (strong, nonatomic) IBOutlet UIControl *CFPinView;
@property (strong, nonatomic) IBOutlet UITextField *pin1TF;
@property (strong, nonatomic) IBOutlet UITextField *pin2TF;
@property (strong, nonatomic) IBOutlet UITextField *pin3TF;
@property (strong, nonatomic) IBOutlet UITextField *pin4TF;
- (IBAction)CFPinCloseButtonAction:(id)sender;
- (IBAction)CFPinSubmitButtonAction:(id)sender;
@end
