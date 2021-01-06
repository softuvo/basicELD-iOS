//
//  ResetPasswordVC.h
//  Basic ELD
//
//  Created by Manoj Gadamsetty on 13/09/17.
//  Copyright © 2017 Gaurav Verma. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataManager.h"

@interface ResetPasswordVC : UIViewController

- (IBAction)CloseButtonTap:(id)sender;
- (IBAction)OverLayBackGroundTap:(id)sender;


@property (weak, nonatomic) IBOutlet UITextField *mOldPasswordTF;
@property (weak, nonatomic) IBOutlet UITextField *mNewPasswordTF;
@property (weak, nonatomic) IBOutlet UIButton *mSubmitButton;
@property (weak, nonatomic) IBOutlet UITextField *mConfirmPasswordTF;
- (IBAction)SubmitButtonTap:(id)sender;

@property (weak, nonatomic)  NSString * driverId;


@end
