//
//  ChangeStatusVC.m
//  Basic ELD
//
//  Created by Gaurav Verma on 09/05/17.
//  Copyright © 2017 Gaurav Verma. All rights reserved.
//

#import "ChangeStatusVC.h"

@interface ChangeStatusVC (){

    
    NSString *refPin ;
    
    
    NSString *refStringForPopUp ;
    NSString *remarkString ;
    
    
}

@end

@implementation ChangeStatusVC
@synthesize driverModel,enterdPin;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.CFPinView.hidden = YES ;
    self.mRemarksPopUpView.hidden = YES ;
    
    _personalUse = kZero;
    _yardMove = kZero;

    [self.mOnDutyYardMoveButton setImage:[UIImage imageNamed:@"check_icon"] forState:UIControlStateSelected];
    [self.mOnDutyYardMoveButton setImage:[UIImage imageNamed:@"unCheck_icon"] forState:UIControlStateNormal];
    
    [self.mOffDutyPersonalUseButton setImage:[UIImage imageNamed:@"check_icon"] forState:UIControlStateSelected];
    [self.mOffDutyPersonalUseButton setImage:[UIImage imageNamed:@"unCheck_icon"] forState:UIControlStateNormal];

    [_mRemarksTextView .layer setBorderColor:[[[UIColor whiteColor] colorWithAlphaComponent:0.5] CGColor]];
    [_mRemarksTextView.layer setBorderWidth:2.0];
    _mRemarksTextView.layer.cornerRadius = 5;
    _mRemarksTextView.clipsToBounds = YES;

    if ([DM.loginType isEqualToString:kLoginTypeSingle]) {
        self.mDriverOnename.frame = CGRectMake(123, 244, 79, 22);
        self.mDriverTwoName.hidden = YES ;
        self.mDriverOnename.text = driverModel.mFirstName;
        self.mOnDutyYardMoveView.hidden = NO ;
        self.mOffDutyPersonalUseView.hidden = NO ;
        
        NSString * yardMoveString = [NSString stringWithFormat:@"%@",driverModel.mYardMove];
        if ([yardMoveString isEqualToString:@"Yes"]){
            self.mOnDutyYardMoveView.hidden = NO ;
        }else{
            self.mOnDutyYardMoveView.hidden = YES ;
        }
        
        NSString * personalUseString = [NSString stringWithFormat:@"%@",driverModel.mAuthorizedPersonalUseCMV];
        if ([personalUseString isEqualToString:@"Yes"]){
            self.mOffDutyPersonalUseView.hidden = NO ;
        }else{
            self.mOffDutyPersonalUseView.hidden = YES ;
        }
        
        
        if ([self.driverModel.mDriverType isEqualToString:kExempt_Driver])
        {
            [self.mEditLogButton setEnabled:NO]  ;
        }
        else{
            [self.mEditLogButton setEnabled:YES]  ;
        }
        
        
        
        
    }else{
        self.mDriverTwoName.text = _driverTwoName;
        self.mDriverOnename.text = driverModel.mFirstName;
        self.mOnDutyYardMoveView.hidden = YES ;
        self.mOffDutyPersonalUseView.hidden = YES ;
    }
    refPin = driverModel.mPinCode;
    if ([_preSelectedRef isEqualToString:kStatusTypeDriving]) {
        [self.mDrivingIV setImage:[UIImage imageNamed:@"yellowBGImage"]];
        self.mOffDutyIV.image = nil ;
        self.mOnDutyIV.image = nil ;
        self.mSleeperIV.image = nil ;
        self.mEditDataRemarkIV.image = nil ;
    }
    if ([_preSelectedRef isEqualToString:kStatusTypeOnDuty]){
        
        [self.mOnDutyIV setImage:[UIImage imageNamed:@"yellowBGImage"]];
        self.mOffDutyIV.image = nil ;
        self.mSleeperIV.image = nil ;
        self.mDrivingIV.image = nil ;
        self.mEditDataRemarkIV.image = nil ;
    }
    if ([_preSelectedRef isEqualToString:kStatusTypeOffDuty]){
        
        [self.mOffDutyIV setImage:[UIImage imageNamed:@"yellowBGImage"]];
        self.mOnDutyIV.image = nil ;
        self.mSleeperIV.image = nil ;
        self.mDrivingIV.image = nil ;
        self.mEditDataRemarkIV.image = nil ;
    }
    if ([_preSelectedRef isEqualToString:kStatusTypeSleeper]){
       
        [self.mSleeperIV setImage:[UIImage imageNamed:@"yellowBGImage"]];
        self.mOffDutyIV.image = nil ;
        self.mOnDutyIV.image = nil ;
        self.mDrivingIV.image = nil ;
        self.mEditDataRemarkIV.image = nil ;
    }
    if ([_preSelectedRef isEqualToString:kStatusTypeEditLog]){
       
        [self.mEditDataRemarkIV setImage:[UIImage imageNamed:@"yellowBGImage"]];
        self.mOffDutyIV.image = nil ;
        self.mOnDutyIV.image = nil ;
        self.mSleeperIV.image = nil ;
        self.mDrivingIV.image = nil ;
    }
    if ([_preSelectedPopUpRef isEqualToString:kStatusTypeYardMove]) {
        
        [self.mOnDutyIV setImage:[UIImage imageNamed:@"yellowBGImage"]];
        self.mOffDutyIV.image = nil ;
        self.mSleeperIV.image = nil ;
        self.mDrivingIV.image = nil ;
        self.mEditDataRemarkIV.image = nil ;
        
        if ([_preSelectedRef isEqualToString:@"yard_move"]) {
            self.mOnDutyYardMoveButton.selected = YES;
            _personalUse = kOne;
        }else{
        self.mOnDutyYardMoveButton.selected = NO;
            _personalUse = kZero;
        }
    }
    if ([_preSelectedPopUpRef isEqualToString:kStatusTypePersonalUse]) {
    
        [self.mOffDutyIV setImage:[UIImage imageNamed:@"yellowBGImage"]];
        self.mOnDutyIV.image = nil ;
        self.mSleeperIV.image = nil ;
        self.mDrivingIV.image = nil ;
        self.mEditDataRemarkIV.image = nil ;
        
        if ([_preSelectedRef isEqualToString:@"personal_use"]) {
            self.mOffDutyPersonalUseButton.selected = YES;
            _yardMove = kOne;
        }else{
            self.mOffDutyPersonalUseButton.selected = NO;
            _yardMove = kZero;
        }
        
    }
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    // add your code here for tagging the map
    // saving to nsuserdefaults.
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)closePopup:(id)sender
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(ChangeStatuscancelButtonClicked:)])
    {
        [self.delegate ChangeStatuscancelButtonClicked:self];
        enterdPin = nil ;
        refPin = nil ;
        remarkString = nil ;
    }
}


- (IBAction)OffDutyButtonAction:(id)sender{
    
    
//    if ([self.mOffDutyPersonalUseButton isSelected]) {
//        self.yardMove = kZero ;
//        self.personalUse = kZero ;
//        [self PostData:kStatusTypeOffDuty];
//        return;
//    }
//    if ([_preSelectedRef isEqualToString:kStatusTypeOffDuty]) {
//      
//        [Helper ISAlertTypeError:@"Error" andMessage:@"Can't select a selected status"];
//        return;
//    }
    
    
    if ([_preSelectedRef isEqualToString:kStatusTypeOffDuty]){
        [Helper ISAlertTypeWarning:@"Error" andMessage:@"You have already selected the same mode"];
        return;
    }
    
    
    
    if (enterdPin || [DM.loginType isEqualToString:kLoginTypeSingle]) {
        self.yardMove = kZero ;
        self.personalUse = kZero ;
        [self PostData:kStatusTypeOffDuty];
    }
    else{
        [Helper ISAlertTypeError:@"Error" andMessage:@"Please Validate with your Pin"];
    }
    
}
- (IBAction)OnDutyButtonAction:(id)sender{
   
//    if ([self.mOnDutyYardMoveButton isSelected]) {
//        self.yardMove = kZero ;
//        self.personalUse = kZero ;
//        [self PostData:kStatusTypeOnDuty];
//        return;
//    }
//    if ([_preSelectedRef isEqualToString:kStatusTypeOnDuty]) {
//        [Helper ISAlertTypeError:@"Error" andMessage:@"Can't select a selected status"];
//        return ;
//    }
    
    
    
    if ([_preSelectedRef isEqualToString:kStatusTypeOnDuty]){
        
        [Helper ISAlertTypeWarning:@"Error" andMessage:@"You have already selected the same mode"];
        return;
    }
    
    
    
    
   
    
    if (enterdPin || [DM.loginType isEqualToString:kLoginTypeSingle]) {
        NSLog(@"%@",kStatusTypeOnDuty);
        self.yardMove = kZero ;
        self.personalUse = kZero ;
        [self PostData:kStatusTypeOnDuty];
    }
    else{
        [Helper ISAlertTypeError:@"Error" andMessage:@"Please Validate with your Pin"];
    }

}
- (IBAction)SleeperButtonAction:(id)sender{
    

    
    if ([_preSelectedRef isEqualToString:kStatusTypeSleeper]){
        [Helper ISAlertTypeWarning:@"Error" andMessage:@"You have already selected the same mode"];
        return;
        
    }
    
    
    
    if ([driverModel.mDriverType isEqualToString:kNon_Driver]) {
    
        [Helper ISAlertTypeError:@"Error" andMessage:@"Non-Driver dont have option to select Sleeper"];
        return ;
    }
    
    if ([_preSelectedRef isEqualToString:kStatusTypeSleeper]) {
        
        [Helper ISAlertTypeError:@"Error" andMessage:@"Can't select a selected status"];
        
        return ;
    }
    
    
    if (enterdPin || [DM.loginType isEqualToString:kLoginTypeSingle]) {
        NSLog(@"%@",kStatusTypeSleeper);
        self.yardMove = kZero ;
        self.personalUse = kZero ;
        [self PostData:kStatusTypeSleeper];
    }
    else{
        [Helper ISAlertTypeError:@"Error" andMessage:@"Please Validate with your Pin"];
    }

}
- (IBAction)DrivingButtonAction:(id)sender{
    
    
    if ([_preSelectedRef isEqualToString:kStatusTypeDriving]) {
        [Helper ISAlertTypeWarning:@"Error" andMessage:@"You have already selected the same mode"];
        return;
    }
    
    if ([self.OnutyStatus isEqualToString:kStatusTypeDriving]){
        
        [Helper ISAlertTypeWarning:@"Error" andMessage:[NSString stringWithFormat:@"%@ must exit diving status",[_driverTwoName uppercaseString]]];
         return;
         }
    
    
    
    if ([driverModel.mDriverType isEqualToString:kNon_Driver]) {
        
        [Helper ISAlertTypeError:@"Error" andMessage:@"Non-Driver don't have option to select Driving"];
        return ;
    }
    
   
    if (enterdPin || [DM.loginType isEqualToString:kLoginTypeSingle]) {
        self.yardMove = kZero ;
        self.personalUse = kZero ;
        [self PostData:kStatusTypeDriving];
    }
    else{
        [Helper ISAlertTypeError:@"Error" andMessage:@"Please Validate with your Pin"];
    }

}

- (IBAction)DutyStatusButtonAction:(id)sender{
    
 
    
    
    if ([_preSelectedRef isEqualToString:kStatusTypeEditLog]) {
        
        [Helper ISAlertTypeError:@"Error" andMessage:@"Can't select a selected status"];
        
        return ;
    }

    if (enterdPin || [DM.loginType isEqualToString:kLoginTypeSingle]) {
        NSLog(@"%@",kStatusTypeEditLog);
        NSDictionary *dct = [NSDictionary dictionaryWithObjectsAndKeys:kStatusTypeEditLog,@"val", nil];
        [[NSNotificationCenter defaultCenter] postNotificationName:KDutyStatusPopupNotification object:nil userInfo:dct];
        [self closePopup:nil];
        enterdPin = nil ;
    }
    else{
        [Helper ISAlertTypeError:@"Error" andMessage:@"Please Validate with your Pin"];
    }
}

- (IBAction)UncategorizedDrivingTimeButtonAction:(id)sender {
    
}

- (IBAction)OnDutyYardMoveButtonAction:(id)sender {
    
    if (self.mOnDutyYardMoveButton.selected) {
        self.mOnDutyYardMoveButton.selected = NO ;
        self.yardMove = kZero ;
        refStringForPopUp = kStatusTypeOnDuty;
        [self OnDutyButtonAction:self];

    }
    else{
        self.mOnDutyYardMoveButton.selected = YES ;
        self.mRemarksPopUpView.hidden = NO ;
        self.yardMove = kOne ;
        refStringForPopUp = kStatusTypeYardMove;
    }
}

- (IBAction)OffDutyPersonalUseButtonAction:(id)sender {

    if (self.mOffDutyPersonalUseButton.selected) {
        self.mOffDutyPersonalUseButton.selected = NO ;
        self.personalUse = kZero ;
        refStringForPopUp = kStatusTypePersonalUse ;
        [self OffDutyButtonAction:self];

    }else{
        self.mOffDutyPersonalUseButton.selected = YES ;
        self.mRemarksPopUpView.hidden = NO ;
        self.personalUse = kOne ;

       refStringForPopUp = kStatusTypePersonalUse ;
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)CloseButtonAction:(id)sender {
   
    if (self.delegate && [self.delegate respondsToSelector:@selector(ChangeStatuscancelButtonClicked:)])
    {
        [self.delegate ChangeStatuscancelButtonClicked:self];
    }

}
- (IBAction)ChangeStatusButtonAction:(id)sender {
    if ([DM.loginType isEqualToString:kLoginTypeSingle]) {
        //[Helper ISAlertTypeError:@"Alert" andMessage:@"Single Driver No need to Authenticate"];
    }
    else{
        self.CFPinView.hidden = NO ;
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
        if ((textField.text.length < 1) && (string.length > 0))
        {
            NSInteger nextTag = textField.tag + 1;
            UIResponder* nextResponder = [textField.superview viewWithTag:nextTag];
            if (! nextResponder){
                [textField resignFirstResponder];
            }
            textField.text = string;
            if (nextResponder)
                [nextResponder becomeFirstResponder];
            
            return NO;
            
        }else if ((textField.text.length >= 1) && (string.length > 0)){
            //FOR MAXIMUM 1 TEXT
            
            NSInteger nextTag = textField.tag + 1;
            UIResponder* nextResponder = [textField.superview viewWithTag:nextTag];
            if (! nextResponder){
                [textField resignFirstResponder];
            }
            textField.text = string;
            if (nextResponder)
                [nextResponder becomeFirstResponder];
            
            return NO;
        }
        else if ((textField.text.length >= 1) && (string.length == 0)){
            // on deleteing value from Textfield
            
            NSInteger prevTag = textField.tag - 1;
            // Try to find prev responder
            UIResponder* prevResponder = [textField.superview viewWithTag:prevTag];
            if (! prevResponder){
                [textField resignFirstResponder];
            }
            textField.text = string;
            if (prevResponder)
                // Found next responder, so set it.
                [prevResponder becomeFirstResponder];
            
            return NO;
        }
    return YES;
}



- (IBAction)CFPinCloseButtonAction:(id)sender {
    
    self.CFPinView.hidden = YES ;
    [self textfildsnil];
}


- (IBAction)CFPinSubmitButtonAction:(id)sender {
    
    enterdPin = nil ;
    enterdPin = [NSString stringWithFormat:@"%@%@%@%@",self.pin1TF.text,self.pin2TF.text,self.pin3TF.text,self.pin4TF.text];
    if ([enterdPin isEqualToString:refPin]) {
        self.CFPinView.hidden = YES ;
        [self textfildsnil];
    }else{
        [Helper ISAlertTypeWarning:@"Error" andMessage:@"Please Enter Correct Pin Code"];
        [self textfildsnil];
    }
    NSLog(@"%@",enterdPin);
    
}

-(void)textfildsnil{
    self.pin1TF.text = nil ;
    self.pin2TF.text = nil ;
    self.pin3TF.text = nil ;
    self.pin4TF.text = nil ;
}

-(void)PostData:(NSString *)logType{
    
    [Helper showLoaderVProgressHUD];
    NSString * path = [NSString stringWithFormat:@"%@addlog",kServiceBaseURL];
    
    if([CLLocationManager locationServicesEnabled]){
        NSLog(@"Location Services Enabled");
        if([CLLocationManager authorizationStatus]==kCLAuthorizationStatusDenied){
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"App Permission Denied"
                                                               message:@"To re-enable, please go to Settings and turn on Location Service for this app."
                                                              delegate:nil
                                                     cancelButtonTitle:@"OK"
                                                     otherButtonTitles:nil];
            [alert show];
        }
    }
    CLLocationCoordinate2D coordinate = [DM getLocation];
    NSString *latLong = [NSString stringWithFormat:@"%f,%f", coordinate.latitude,coordinate.longitude];
    NSMutableDictionary * parameter = [[NSMutableDictionary alloc]init];
   
    [parameter setValue:driverModel.mDriverId forKey:@"driverid"];
    [parameter setValue:DM.loginType forKey:@"login_type"];
    [parameter setValue:logType forKey:@"mode"];
    [parameter setValue:latLong forKey:@"lat_long"];
    [parameter setValue:self.mRemarksTextView.text forKey:@"user_remark"];
    [parameter setValue:self.yardMove forKey:@"yard_move"];
    [parameter setValue:self.personalUse forKey:@"personal_use"];
    
    [DM PostRequest:path parameter:parameter onCompletion:^(id  _Nullable dict) {
        NSError *errorJson=nil;
        NSDictionary* responseDict = [NSJSONSerialization JSONObjectWithData:dict options:kNilOptions error:&errorJson];
        NSLog(@"%@",responseDict);
        if ([[responseDict valueForKey:@"status"] integerValue] == 0) {
            NSString *ErrorString = [NSString stringWithFormat:@"%@",[responseDict valueForKey:@"message"]];
            [Helper ISAlertTypeError:@"Error!!" andMessage:ErrorString];
        }
        else{
            NSLog(@"%@",responseDict);
            enterdPin = nil ;
            [self closePopup:nil];
        }
        [Helper hideLoaderSVProgressHUD];
    } onError:^(NSError * _Nullable Error) {
        NSLog(@"%@",Error);
        [Helper hideLoaderSVProgressHUD];
        NSString *ErrorString = [NSString stringWithFormat:@"%@",Error];
        [Helper ISAlertTypeError:@"Error!!" andMessage:ErrorString];
    }];
}

- (IBAction)RemarksSubmitButtonAction:(id)sender {
    
    if (self.mRemarksTextView.text.length > 5 ) {
        remarkString = self.mRemarksTextView.text;
        if ([refStringForPopUp isEqualToString:kStatusTypePersonalUse]) {
            [self PostData:kStatusTypeOffDuty];
        }
        if ([refStringForPopUp isEqualToString:kStatusTypeYardMove]) {
            [self PostData:kStatusTypeOnDuty];
        }
        self.mRemarksPopUpView.hidden = YES;
    }else{
        [Helper ISAlertTypeWarning:@"Warning" andMessage:@"Please add Remarks"];
    }

}
- (IBAction)RemarksCloseButtonAction:(id)sender {
    
    if (self.mOnDutyYardMoveButton.selected) {
        self.mOnDutyYardMoveButton.selected = NO ;
    }
    if (self.mOffDutyPersonalUseButton.selected) {
        self.mOffDutyPersonalUseButton.selected = NO ;
    }

    self.mRemarksPopUpView.hidden = YES ;
    self.mRemarksTextView.text = nil ;

}
@end
