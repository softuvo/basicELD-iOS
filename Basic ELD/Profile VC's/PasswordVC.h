//
//  PasswordVC.h
//  Basic ELD
//
//  Created by Manoj Gadamsetty on 13/09/17.
//  Copyright © 2017 Gaurav Verma. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataManager.h"


@interface PasswordVC : UIViewController




@property (weak, nonatomic) NSString * driverId;

@property (weak, nonatomic) IBOutlet UITextField *mPasswordTF;
- (IBAction)SubmitButtonTap:(id)sender;
- (IBAction)OverLayTap:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *mSubmitButton;

@property (weak, nonatomic) IBOutlet UILabel *msgLabel;
@property (weak, nonatomic) IBOutlet UILabel *enterPasswordLabel;

@end
