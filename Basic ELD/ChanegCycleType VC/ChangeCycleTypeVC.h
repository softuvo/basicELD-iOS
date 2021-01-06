//
//  ChangeCycleTypeVC.h
//  Basic ELD
//
//  Created by Manoj Gadamsetty on 18/09/17.
//  Copyright © 2017 Gaurav Verma. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DownPicker.h"
#import "DataManager.h"
#import "CycleTableCell.h"
#import "Constants.h"

@interface ChangeCycleTypeVC : UIViewController<UITextFieldDelegate>

@property (nonatomic) DownPicker * downPicker1;
@property (nonatomic) DownPicker * downPicker2;
@property (nonatomic) DownPicker * downPicker3;
@property (nonatomic) DownPicker * downPicker4;
@property (nonatomic) DownPicker * downPicker5;
@property (nonatomic) DownPicker * downPicker6;
@property (nonatomic) DownPicker * downPicker7;

@property (weak, nonatomic) IBOutlet UIView *mHeaderView;
@property (weak, nonatomic) IBOutlet UILabel *mDriverNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *mVehicalNumberLabel;
@property (weak, nonatomic) IBOutlet UIProgressView *mProgressiveBar;
@property (weak, nonatomic) IBOutlet UILabel *mErrorTypeLabel;
@property (weak, nonatomic) IBOutlet UITableView *mTableView;

@property (weak, nonatomic) IBOutlet UIView *mCycleView;
@property (weak, nonatomic) IBOutlet UIView *mOptionView;


@property (weak, nonatomic) IBOutlet UIScrollView *mScrollView;
@property (weak, nonatomic) IBOutlet UIView *mContentView;


@property (weak, nonatomic) IBOutlet UIView *mCycleRuleView;
@property (weak, nonatomic) IBOutlet UIView *mCargoTypeView;
@property (weak, nonatomic) IBOutlet UIView *mRestartTypeView;
@property (weak, nonatomic) IBOutlet UIView *mCwellSiteTypeView;
@property (weak, nonatomic) IBOutlet UIView *mShortHaulTypeView;
@property (weak, nonatomic) IBOutlet UIView *mFarmSchoolBusExceptionTypeView;
@property (weak, nonatomic) IBOutlet UIView *mRestBreakView;


@property (weak, nonatomic) IBOutlet UITextField *mCycleRuleTextField;
@property (weak, nonatomic) IBOutlet UITextField *mCargoTypeTextField;
@property (weak, nonatomic) IBOutlet UITextField *mRestartTypeTextField;
@property (weak, nonatomic) IBOutlet UITextField *mCwellSiteTypeTextField;
@property (weak, nonatomic) IBOutlet UITextField *mShortHaulTypeTextField;
@property (weak, nonatomic) IBOutlet UITextField *mFarmSchoolBusExceptionTextField;
@property (weak, nonatomic) IBOutlet UITextField *mRestBreakTextField;


@property (strong, nonatomic)  NSString *mWebCycleRuleSelectedID;

@property (strong, nonatomic)  NSString *mWebCycleRuleSelected;
@property (strong, nonatomic)  NSString *mWebCargoTypeSelected;
@property (strong, nonatomic)  NSString *mWebRestBreakSelected;
@property (strong, nonatomic)  NSString *mWebRestartTypeSelected;
@property (strong, nonatomic)  NSString *mWebCwellSiteTypeSelected;
@property (strong, nonatomic)  NSString *mWebShortHaulTypeSelected;
@property (strong, nonatomic)  NSString *mWebFarmSchoolBusExceptioneSelected;




- (IBAction)CycleRuleActionSheetButtonPressed:(id)sender;
- (IBAction)CargoTypeActionSheetButtonPressed:(id)sender;
- (IBAction)RestartTypeActionSheetButtonPressed:(id)sender;
- (IBAction)CwellSiteTypeActionSheetButtonPressed:(id)sender;
- (IBAction)ShortHaulTypeActionSheetButtonPressed:(id)sender;
- (IBAction)FarmSchoolBusExceptionActionSheetButtonPressed:(id)sender;
- (IBAction)RestBreakActionSheetButtonPressed:(id)sender;

- (IBAction)BackButtonAction:(id)sender;

@end
