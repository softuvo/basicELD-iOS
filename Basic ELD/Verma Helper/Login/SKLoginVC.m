//
//  SKLoginVC.m
//  SHKUN
//
//  Created by Gaurav Verma on 21/12/16.
//  Copyright © 2016 Gaurav Verma. All rights reserved.
//

#import "SKLoginVC.h"
#import <QuartzCore/QuartzCore.h>
#import "SKUser.h"
#import "FirstTimeUserVC.h"


#define RemoveN0ull(field) ([[result objectForKey:field] isKindOfClass:[NSNull class]]) ? @"" : [result objectForKey:field];


@interface SKLoginVC (){
    
    NSString *message;
    NSString *driverOneId;


    NSString *Image_Social;
    NSString *First_Name_Social;
    NSString *Last_Name_Social;
    NSString *Email_Social;
    
    BOOL confirmPinCheckBOOL;
    NSString *confirmPin;
    NSString *ChangePin;
    
    CLLocationManager * locationManager;
    
}

@end

@implementation SKLoginVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.ScrollView layoutIfNeeded];
    self.ScrollView.contentSize = self.ContentView.bounds.size;
    self.mForgotPasswodView.hidden = true;
    
    self.imgTickPassword.hidden=YES;
    self.imgTickEmail.hidden=YES;
    self.imgTickForgotEmail.hidden=YES;
    
    IQKeyboardManager.sharedManager.enable = true;
    
    self.SingleDriverSelected.selected = YES ;
    DM.loginType = [NSString stringWithFormat:@"%@",kLoginTypeSingle];
    NSString *valueToSave = [NSString stringWithFormat:@"%@",kLoginTypeSingle];
    [[NSUserDefaults standardUserDefaults] setObject:valueToSave forKey:kUserLoggedInType];
    [[NSUserDefaults standardUserDefaults] synchronize];
    self.singleDriverImageView.image = [UIImage imageNamed:@"loginType_bi_selected"];
    [self.SingleDriverSelected setHighlighted:NO];
    [self.TeamDriverSelected setHighlighted:NO];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(PlaceHolderChange) name:kPlaceHolderChangeNotification object:nil];
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self ;
    [locationManager requestAlwaysAuthorization];
}


-(void)viewWillAppear:(BOOL)animated{
    
    DM.mAppObj.checkslide = YES;
    
    DM.mAppObj.restrictRotation = YES;
    [[UIDevice currentDevice] setValue:
     [NSNumber numberWithInteger: UIInterfaceOrientationPortrait]
                                forKey:@"orientation"];
    
    
    [super viewWillAppear:YES];
    [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationFade];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:YES];
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationFade];
}



- (IBAction)RegisterButtonAction:(id)sender{
    self.ScrollView.hidden = true;
    self.ScrollView.contentOffset = CGPointMake(0,0);
}

- (IBAction)LoginButtonPressed:(id)sender{
    [self keyborddown];
    if (message) {
        [Helper ISAlertTypeWarning:@"Warning!" andMessage:message];
    }
    else{
        if (DM.mInternetStatus == false) {
            NSLog(@"No Internet Connection.");
            [Helper ISAlertTypeError:@"Internet Connection!!" andMessage:kNOInternet];
                        return;
        }
        else{
            [self LoginWithPFUser];
        }
        }
    
    message = nil;
}



#pragma Mark ================================================================
#pragma Mark LOGIN START
#pragma Mark ================================================================



-(void)LoginWithPFUser{

    if (self.imgTickEmail.hidden == YES && self.imgTickPassword.hidden == YES) {
       
        [Helper ISAlertTypeError:@"Login Failed!" andMessage:@"Please enter a valid email or password for login."];
        
    }
    else {
        
        [Helper showLoaderVProgressHUD];

        NSMutableDictionary *Parameter = [[NSMutableDictionary alloc] init];
        [Parameter setObject:self.mUserNameTextField.text
                      forKey:@"user_name"];
        [Parameter setObject:self.mPasswordTextField.text forKey:@"password"];
        [Parameter setObject:DM.loginType forKey:@"driver_mode"];
         if (_SingleDriverSelected.isSelected) {
            [Parameter setObject:@"0" forKey:@"logged_driver_id"];
         }else{
             if (DM.message) {
                 [Parameter setObject:DM.driverOneID forKey:@"logged_driver_id"];
             }else{
                 [Parameter setObject:@"0" forKey:@"logged_driver_id"];
             }
         }
        CLLocationCoordinate2D coordinate = [DM getLocation];    NSString *latLong = [NSString stringWithFormat:@"%f,%f", coordinate.latitude,coordinate.longitude];
        
        [Parameter setValue:latLong forKey:@"lat_long"];
        
        NSString *path=[NSString stringWithFormat:@"%@%@",kServiceBaseURL,kLogin];
        [DM PostRequest:path parameter:Parameter onCompletion:^(id dict) {
            NSError *errorJson=nil;
            
            NSString *myStrinag = [[NSString alloc] initWithData:dict encoding:NSUTF8StringEncoding];
            NSLog(@"%@",myStrinag);
        
            NSDictionary* responseDict = [NSJSONSerialization JSONObjectWithData:dict options:kNilOptions error:&errorJson];
            NSLog(@"%@",responseDict);
            
            if ([[responseDict valueForKey:@"status"] integerValue] == 0) {
                
                NSString *ErrorString = [NSString stringWithFormat:@"%@",[responseDict valueForKey:@"message"]];
                [Helper ISAlertTypeError:@"Error!!" andMessage:ErrorString];
            }
            else{
        
                if (_SingleDriverSelected.isSelected) {
                    SKUser *currentUser = [[SKUser alloc] init];
                    [currentUser setupCurrentUser:[[responseDict valueForKey:@"driver"]objectAtIndex:0] driverName:kCurrentUserOne];
                    [DM.mAppObj checkLogin];

                }else if (_TeamDriverSelected.isSelected){
                      if (DM.message) {
                        SKUser *currentUser = [[SKUser alloc] init];
                        [currentUser setupCurrentUser:[[responseDict valueForKey:@"driver"]objectAtIndex:0] driverName:kCurrentUserOne];
                        SKUser *currentUser2 = [[SKUser alloc] init];
                        [currentUser2 setupCurrentUser:[[responseDict valueForKey:@"driver"]objectAtIndex:1] driverName:kCurrentUserTwo];
                        NSLog(@"%@",[[responseDict valueForKey:@"driver"]objectAtIndex:1]);
                        NSLog(@"Driver Two %@",currentUser);
                        [DM.mAppObj checkLogin];
                        DM.message = nil;
                    }else{
                        DM.driverOneID = [NSString stringWithFormat:@"%@",[[[responseDict valueForKey:@"driver"]objectAtIndex:0]valueForKey:@"driver_id"]];
                        NSLog(@"%@",[[responseDict valueForKey:@"driver"]objectAtIndex:0]);
                        [self textfildsnil];
                        [self PlaceHolderChange];
                        DM.message = @"yes";
                    }
                }
            }
            [Helper hideLoaderSVProgressHUD];
        } onError:^(NSError *Error) {
            [Helper hideLoaderSVProgressHUD];
            NSLog(@"%@",Error);
            NSString *ErrorString = [NSString stringWithFormat:@"%@",Error];
            [Helper ISAlertTypeError:@"Error!!" andMessage:ErrorString];
        }];
}
}

-(void)PlaceHolderChange{
     self.mUserNameTextField.placeholder = @"USER2 NAME";
}

-(void)textfildsnil{
    self.mUserNameTextField.text  = nil;
    self.mPasswordTextField.text = nil;
    self.imgTickPassword.hidden=YES;
    self.imgTickEmail.hidden=YES;
    self.imgTickForgotEmail.hidden=YES;
}


#pragma Mark ================================================================
#pragma Mark LOGIN END
#pragma Mark ================================================================

- (IBAction)ForgotPasswodButtonAction:(id)sender{
    self.mForgotPasswodView.hidden = false;
}

- (IBAction)CancelForgotPasswodButtonAction:(id)sender{
    self.mForfotPassEmailTextField.text = nil;
    self.mForgotPasswodView.hidden = true;
}

- (IBAction)SubmitForgotPasswodButtonAction:(id)sender{
    
    if ([self.mResetPasswordButton.currentTitle isEqualToString:@"OKAY"]) {
       
        [self CancelForgotPasswodButtonAction:self];
        self.mForfotPassEmailTextField.hidden = NO ;
        self.mForfotPassEmailTextField.text = nil ;
        self.imgTickForgotEmail.hidden = YES ;
        self.mForgetToastMsgLabel.hidden = NO ;
        self.mForgetToastMsgLabel.text = @"Enter the email Address of your account" ;
        self.mForgetToastMsgLabel.textAlignment = NSTextAlignmentCenter ;
        [self.mResetPasswordButton setTitle:@"REST PASSWORD" forState:UIControlStateNormal];

    }
    else
    {
    [self keyborddown];
    [self forgotVelidations];
    
    if (message) {
        [Helper ISAlertTypeWarning:@"Warning!" andMessage:message];
    }
    else{
    if (DM.mInternetStatus == false) {
        NSLog(@"No Internet Connection.");
        [Helper ISAlertTypeError:@"Internet Connection!!" andMessage:kNOInternet];
            
        return;
        }
        else{
            [Helper showLoaderVProgressHUD];
    NSMutableDictionary *Parameter = [[NSMutableDictionary alloc] init];
    [Parameter setObject:self.mForfotPassEmailTextField.text forKey:@"email"];
    
    NSString *path=[NSString stringWithFormat:@"%@forgotpassword",kServiceBaseURL];
        
    [DM PostRequest:path parameter:Parameter onCompletion:^(id dict) {
     [Helper hideLoaderSVProgressHUD];
    NSError *errorJson=nil;

    NSString *myStrinag = [[NSString alloc] initWithData:dict encoding:NSUTF8StringEncoding];
    NSLog(@"%@",myStrinag);
                
    NSDictionary* responseDict = [NSJSONSerialization JSONObjectWithData:dict options:kNilOptions error:&errorJson];
    NSLog(@"%@",responseDict);
    
    if ([[responseDict valueForKey:@"responsestatus"] integerValue] == 0) {
        
        NSString *ErrorString = [NSString stringWithFormat:@"%@",[responseDict valueForKey:@"message"]];
                    [Helper ISAlertTypeError:@"Error!!" andMessage:ErrorString];
        }
    else{
                    
        self.mForfotPassEmailTextField.hidden = YES ;
        self.imgTickForgotEmail.hidden = YES ;
        self.mForgetToastMsgLabel.text = [NSString stringWithFormat:@"%@",[responseDict valueForKey:@"message"]];
        self.mForgetToastMsgLabel.numberOfLines = 3 ;
        self.mForgetToastMsgLabel.textAlignment = NSTextAlignmentCenter ;
        [self.mResetPasswordButton setTitle:@"OKAY" forState:UIControlStateNormal];
        
    }
            } onError:^(NSError *Error) {
                [Helper hideLoaderSVProgressHUD];
                NSLog(@"%@",Error);
                NSString *ErrorString = [NSString stringWithFormat:@"%@",Error];
                [Helper ISAlertTypeError:@"Error!!" andMessage:ErrorString];
                
            }];
            
        }
        
    }
    
    message = nil;
    }
}



-(void)TextfieldVelidations{
    
    
    if ([self.mUserNameTextField.text length ] == 0  || [self.mPasswordTextField.text length] == 0 ) {
        message = @"Please enter a valid email or password for login.";
    }
    
    else{

    }
    
}

-(void)forgotVelidations{
    
    if ([self.mForfotPassEmailTextField.text length ] == 0   ) {
        message = @"Please enter a valid email.";
    }
    else{

    }
    
}



#pragma mark ---------------------------------------------------------
#pragma mark KEYBORD AUTO MOVE START
#pragma mark ---------------------------------------------------------

-(void)keyborddown{
    [self.view endEditing:YES];
}



- (IBAction)textFieldDoneEditing:(id)sender {
    [sender resignFirstResponder];
}

- (IBAction)backgroundTap:(id)sender {
    [self keyborddown];
}


- (void) animateTextField: (UITextField*) textField up: (BOOL) up{
    int txtPosition = (textField.frame.origin.y - 200);
    const int movementDistance = (txtPosition < 0 ? 0 : txtPosition);
    const float movementDuration = 0.3f;
    
    int movement = (up ? -movementDistance : movementDistance);
    
    [UIView beginAnimations: @"anim" context: nil];
    [UIView setAnimationBeginsFromCurrentState: YES];
    [UIView setAnimationDuration: movementDuration];
    self.ContentView.frame = CGRectOffset(self.ContentView.frame, 0, movement);
    [UIView commitAnimations];
}

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    [self animateTextField: textField up: YES];
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    
    [self animateTextField: textField up: NO];
}

- (BOOL)textFieldShouldReturn:(UITextField *)theTextField {
    [theTextField resignFirstResponder];
    return YES;
}


-(BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    if ([self.mUserNameTextField.text length]==0) {
        self.imgTickEmail.hidden=YES;
    }
    else{
        self.imgTickEmail.hidden=NO;
        
    }
    
    if ([self.mForfotPassEmailTextField.text length]==0) {
        self.imgTickForgotEmail.hidden=YES;
    }
    else if ([self validateEmailWithString:self.mForfotPassEmailTextField.text]) {
        self.imgTickForgotEmail.hidden=NO;
    }
    else{
        self.imgTickForgotEmail.hidden=NO;
        
    }
    
    if ([self.mPasswordTextField.text length]==0){
        self.imgTickPassword.hidden=YES;
        
    }
    else{
        self.imgTickPassword.hidden=NO;
        
    }
    return YES;
}

- (BOOL)validateEmailWithString:(NSString*)email
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}




#pragma mark ---------------------------------------------------------
#pragma mark KEYBORD AUTO MOVE END
#pragma mark ---------------------------------------------------------


#pragma mark ---------------------------------------------------------
#pragma mark LOGIN WITH FACEBOOK START
#pragma mark ---------------------------------------------------------


- (IBAction)SingleDriverSelectedAction:(id)sender {
    
    if (_TeamDriverSelected.selected == YES) {
        self.TeamDriverSelected.selected = NO ;
        self.teamDriverImageView.image = [UIImage imageNamed:@"loginType_bi_normal"];
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:kUserLoggedInType];

    }
        DM.loginType = nil ;
        DM.loginType = [NSString stringWithFormat:@"%@",kLoginTypeSingle];
        self.SingleDriverSelected.selected = YES ;
        self.singleDriverImageView.image = [UIImage imageNamed:@"loginType_bi_selected"];
        [self.SingleDriverSelected setHighlighted:NO];
        [self TextFieldNil];
        self.mUserNameTextField.placeholder = @"USERNAME";
        NSString *valueToSave = [NSString stringWithFormat:@"%@",kLoginTypeSingle];
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:kCurrentUserOne];
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:kCurrentUserTwo];
        [[NSUserDefaults standardUserDefaults] setObject:valueToSave forKey:kUserLoggedInType];
        [[NSUserDefaults standardUserDefaults] synchronize];
}

- (IBAction)TeamDriverSelected:(id)sender {
    
    if (self.SingleDriverSelected.selected == YES) {
        self.SingleDriverSelected.selected = NO ;
        self.singleDriverImageView.image = [UIImage imageNamed:@"loginType_bi_normal"];
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:kUserLoggedInType];

    }
        DM.loginType = nil ;
        DM.loginType = [NSString stringWithFormat:@"%@",kLoginTypeTeam];
        self.TeamDriverSelected.selected = YES ;
        self.teamDriverImageView.image = [UIImage imageNamed:@"loginType_bi_selected"];
        [self.TeamDriverSelected setHighlighted:NO];
        [self TextFieldNil];
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:kCurrentUserOne];
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:kCurrentUserTwo];
        NSString *valueToSave = [NSString stringWithFormat:@"%@",kLoginTypeTeam];
        [[NSUserDefaults standardUserDefaults] setObject:valueToSave forKey:kUserLoggedInType];
        [[NSUserDefaults standardUserDefaults] synchronize];
}

- (IBAction)firstTimeUserButtonAction:(id)sender {
    
    [self TextFieldNil];

    FirstTimeUserVC *firstTimeUserVC = [self.storyboard instantiateViewControllerWithIdentifier:@"FirstTimeUserVC"];
    firstTimeUserVC.delegate = self;
    [self presentPopupViewController:firstTimeUserVC animationType:MJPopupViewAnimationFade];

}

- (void)ChangeStatuscancelButtonClicked:(FirstTimeUserVC*)ChangeStatusViewController{
    [self dismissPopupViewControllerWithanimationType:MJPopupViewAnimationFade];
}

-(void)TextFieldNil{
    self.mUserNameTextField.text = nil;
    self.mPasswordTextField.text = nil;
    self.imgTickEmail.hidden = YES ;
    self.imgTickPassword.hidden = YES ;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




@end
