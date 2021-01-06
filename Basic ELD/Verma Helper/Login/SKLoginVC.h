//
//  SKLoginVC.h
//  SHKUN
//
//  Created by Gaurav Verma on 21/12/16.
//  Copyright © 2016 Gaurav Verma. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataManager.h"
#import "Constants.h"
#import "AppDelegate.h"
#import "Helper.h"

#import "SCPinViewController.h"
#import "SCPinAppearance.h"

@interface SKLoginVC : UIViewController<SCPinViewControllerCreateDelegate, SCPinViewControllerDataSource, SCPinViewControllerValidateDelegate,CLLocationManagerDelegate>{
    SCPinViewController *vc;
}


@property (weak, nonatomic) IBOutlet UIScrollView *ScrollView;

@property (weak, nonatomic) IBOutlet UIView *ContentView;
@property (weak, nonatomic) IBOutlet UIView *mForgotPasswodView;

@property (weak, nonatomic) IBOutlet UIImageView *imgTickEmail;
@property (weak, nonatomic) IBOutlet UIImageView *imgTickForgotEmail;
@property (weak, nonatomic) IBOutlet UIImageView *imgTickPassword;

@property (weak, nonatomic) IBOutlet UITextField *mUserNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *mPasswordTextField;
@property (weak, nonatomic) IBOutlet UITextField *mForfotPassEmailTextField;

@property (strong, nonatomic) IBOutlet UIButton *TeamDriverSelected;
@property (strong, nonatomic) IBOutlet UIImageView *teamDriverImageView;
@property (strong, nonatomic) IBOutlet UIButton *SingleDriverSelected;
@property (strong, nonatomic) IBOutlet UIImageView *singleDriverImageView;

- (IBAction)SingleDriverSelectedAction:(id)sender;
- (IBAction)TeamDriverSelected:(id)sender;
- (IBAction)firstTimeUserButtonAction:(id)sender;


- (IBAction)LoginButtonPressed:(id)sender;
- (IBAction)ForgotPasswodButtonAction:(id)sender;
- (IBAction)CancelForgotPasswodButtonAction:(id)sender;
- (IBAction)SubmitForgotPasswodButtonAction:(id)sender;
@property (strong, nonatomic) IBOutlet UILabel *mForgetToastMsgLabel;
@property (strong, nonatomic) IBOutlet UIButton *mResetPasswordButton;


- (IBAction)LoginwithFacebookButtonPressed:(id)sender;
- (IBAction)RegisterButtonAction:(id)sender;

@end
