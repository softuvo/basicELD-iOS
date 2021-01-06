//
//  FirstTimeUserVC.h
//  Basic ELD
//
//  Created by Deepak  on 21/07/17.
//  Copyright © 2017 Gaurav Verma. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IQKeyboardManager.h"
#import "UIViewController+MJPopupViewController.h"
#import "Constants.h"
#import "Helper.h"
#import "DataManager.h"
#import "AppDelegate.h"
#import "SignatureView.h"
#import "TermsVC.h"

@protocol FirstTimeUserVCDelegate;

@interface FirstTimeUserVC : UIViewController<UITextFieldDelegate>

@property (assign, nonatomic) id <FirstTimeUserVCDelegate>delegate;

@property (strong, nonatomic) SignatureView *signatureView ;

@property (weak, nonatomic) IBOutlet UIView *ContentView;
@property (strong, nonatomic) IBOutlet UITextField *emailTextField;
@property (strong, nonatomic) IBOutlet UITextField *pin1TF;
@property (strong, nonatomic) IBOutlet UITextField *pin2TF;
@property (strong, nonatomic) IBOutlet UITextField *pin3TF;
@property (strong, nonatomic) IBOutlet UITextField *pin4TF;
@property (strong, nonatomic) IBOutlet UITextField *createPasswordTF;
@property (strong, nonatomic) IBOutlet UITextField *confirmPasswordTF;
@property (strong, nonatomic) IBOutlet UIImageView *usernameTick;
@property (strong, nonatomic) IBOutlet UIImageView *passwordTick;
@property (strong, nonatomic) IBOutlet UIImageView *confirmPasswordTick;
@property (strong, nonatomic) IBOutlet UIView *mPopUPVIew;
@property (strong, nonatomic) IBOutlet UIButton *mTermsAndConditionsButton;

@property (strong, nonatomic) IBOutlet UIView *mSignatureView;
@property (strong, nonatomic) IBOutlet UIImageView *mSignatureIV;
@property (strong, nonatomic) IBOutlet UILabel *mSignatureLabel;
- (IBAction)SignatureTap:(id)sender;

@property (strong, nonatomic) IBOutlet UIView *mSignaturePopUpView;
- (IBAction)DoneButtonSignaturePopUpTap:(id)sender;
- (IBAction)AcceptButtonTap:(id)sender;
- (IBAction)TermsAndConditionsTap:(id)sender;
- (IBAction)closeButtonTap:(id)sender;
- (IBAction)TermsAndConditionsLabelTap:(id)sender;

@end
@protocol FirstTimeUserVCDelegate<NSObject>
@optional

- (void)ChangeStatuscancelButtonClicked:(FirstTimeUserVC*)firstTimeUserViewController;
- (IBAction)clearButtonTap:(id)sender;
@end
