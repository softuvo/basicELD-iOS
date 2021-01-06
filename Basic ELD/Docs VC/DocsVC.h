//
//  DocsVC.h
//  Basic ELD
//
//  Created by Manoj Gadamsetty on 30/08/17.
//  Copyright © 2017 Gaurav Verma. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DocsCell.h"
#import "DataManager.h"
#import "SKUser.h"
#import "DocumentVC.h"

@interface DocsVC : UIViewController


//User Data
@property (nonatomic,strong)SKUser *driverOne;
@property (nonatomic,strong)SKUser *driverTwo;
//Header
@property (weak, nonatomic) IBOutlet UIView *mHeaderView;
@property (weak, nonatomic) IBOutlet UILabel *mDriverNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *mVehicalNumberLabel;
@property (weak, nonatomic) IBOutlet UIProgressView *mProgressiveBar;
@property (weak, nonatomic) IBOutlet UILabel *mErrorTypeLabel;
@property (weak, nonatomic) IBOutlet UITableView *mDocsTableView;

@property (weak, nonatomic) IBOutlet UIView *mDriversSelectionView;
@property (weak, nonatomic) IBOutlet UIButton *mDriverOneButton;
@property (weak, nonatomic) IBOutlet UIButton *mDriverTwoButton;

- (IBAction)DriverOneButtonAction:(id)sender;
- (IBAction)DriverTwoButtonAction:(id)sender;


- (IBAction)BackButtonAction:(id)sender;
- (IBAction)AddDocsButtonAction:(id)sender;

// Passcode
@property (strong, nonatomic) IBOutlet UIControl *CFPinView;
@property (strong, nonatomic) IBOutlet UITextField *pin1TF;
@property (strong, nonatomic) IBOutlet UITextField *pin2TF;
@property (strong, nonatomic) IBOutlet UITextField *pin3TF;
@property (strong, nonatomic) IBOutlet UITextField *pin4TF;
- (IBAction)CFPinCloseButtonAction:(id)sender;
- (IBAction)CFPinSubmitButtonAction:(id)sender;


@end
