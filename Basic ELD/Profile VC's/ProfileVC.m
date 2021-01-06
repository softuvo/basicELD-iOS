//
//  ProfileVC.m
//  Basic ELD
//
//  Created by Manoj Gadamsetty on 08/09/17.
//  Copyright © 2017 Gaurav Verma. All rights reserved.
//

#import "ProfileVC.h"
#import "PasswordVC.h"
#import "DataManager.h"
#import "IQKeyboardManager.h"
#import "ResetPasswordVC.h"
#import "DataManager.h"
#import "Constants.h"
#import "SKUser.h"
#import "AppDelegate.h"
#import "ChangeCycleTypeVC.h"

@interface ProfileVC (){
    NSMutableArray * DataArray;
    NSMutableArray * PowerUnitArray ;
    NSMutableArray * powerUnitNamesArray ;
    NSString * driverID ;
    NSString * enterdPin ;
    NSString * pin ;
    NSString *SelectedDriver;
    BOOL OkButtonCheckBool;
    UIActionSheet * powerUnitNumberActionSheet ;
    
    
    
    
    NSString *mcycle_type_id;
    NSString *mcycle_type;
    NSString *mcargo_type;
    NSString *mrestart;
    NSString *mrest_break;
    NSString *mshort_hand_exception;
    NSString *mwell_site;
    NSString *mfarm_school_exception;
    
}

@end

@implementation ProfileVC
@synthesize driverOne,driverTwo ;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    mcycle_type = @"";
    mcycle_type_id = @"";
    mcargo_type = @"";
    mrestart = @"";
    mrest_break = @"";
    mshort_hand_exception = @"";
    mwell_site = @"";
    mfarm_school_exception = @"";
    
    
    self.CFPinView.hidden = YES ;
    SelectedDriver = kSelectedDriverOne;


    self.mHeaderView.layer.borderWidth = 1;
    self.mHeaderView.layer.borderColor = [[UIColor whiteColor]CGColor];
    
    driverOne = [[SKUser alloc] init];
    [driverOne setupUser:[Helper mCurrentUser:kCurrentUserOne]];
    
    driverTwo = [[SKUser alloc] init];
    [driverTwo setupUser:[Helper mCurrentUser:kCurrentUserTwo]];
    
    
    
    [self.mScrollView layoutIfNeeded];
    self.mScrollView.contentSize = self.mContentView.bounds.size;
    
    self.mDriverOneButton.selected = YES ;
    IQKeyboardManager.sharedManager.enable = true;

    
    [self.mDriverOneButton setImage:[UIImage imageNamed:@"selectedDriver"] forState:UIControlStateSelected];
    [self.mDriverOneButton setImage:[UIImage imageNamed:@"unSelectedDriver"] forState:UIControlStateNormal];
    
    [self.mDriverTwoButton setImage:[UIImage imageNamed:@"selectedDriver"] forState:UIControlStateSelected];
    [self.mDriverTwoButton setImage:[UIImage imageNamed:@"unSelectedDriver"] forState:UIControlStateNormal];

    if ([DM.loginType isEqualToString:kLoginTypeSingle]) {
        //self.mDriverView.hidden = YES ;
        driverID = driverOne.mDriverId;
        pin = driverOne.mPinCode;
        self.mDriverOneButton.hidden = YES;
        self.mDriverOneLabel.hidden = YES;
        self.mDriverTwoLabel.hidden = YES ;
        self.mDriverTwoButton.hidden = YES ;
        
        self.mDriverButton.hidden = NO;
        self.mDriverLabel.text = [NSString stringWithFormat:@"%@",driverOne.mDriverType];

    }else{
        self.mDriverView.hidden = NO ;
        self.mDriverButton.hidden = YES;
        self.mDriverLabel.hidden = YES;
        self.mDriverOneButton.selected = YES ;
        driverID = driverOne.mDriverId;
        pin = driverOne.mPinCode;

    }
    
    [self.mYardMoveAuthYesButton setImage:[UIImage imageNamed:@"check_icon"] forState:UIControlStateSelected];
    [self.mYardMoveAuthYesButton setImage:[UIImage imageNamed:@"unCheck_icon"] forState:UIControlStateNormal];
    
    [self.mYardMoveAuthNoButton setImage:[UIImage imageNamed:@"check_icon"] forState:UIControlStateSelected];
    [self.mYardMoveAuthNoButton setImage:[UIImage imageNamed:@"unCheck_icon"] forState:UIControlStateNormal];
    
    [self.mPersonalUseAuthYesButton setImage:[UIImage imageNamed:@"check_icon"] forState:UIControlStateSelected];
    [self.mPersonalUseAuthYesButton setImage:[UIImage imageNamed:@"unCheck_icon"] forState:UIControlStateNormal];
    
    [self.mPersonalUseAuthNoButton setImage:[UIImage imageNamed:@"check_icon"] forState:UIControlStateSelected];
    [self.mPersonalUseAuthNoButton setImage:[UIImage imageNamed:@"unCheck_icon"] forState:UIControlStateNormal];
    
    [self GetData];
    if ([DM.loginType isEqualToString:kLoginTypeSingle]) {
        
    }
    else{
        self.mContentView.hidden = true;

    }

    
    powerUnitNumberActionSheet = [[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:nil];
    powerUnitNumberActionSheet.delegate = self;
    // Do any additional setup after loading the view.
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(SelectedCycleRules:)
                                                 name:kNOTIFICATION_UpdateCycleRules object:nil];
}

- (void)SelectedCycleRules:(NSNotification *)note {
    
    NSDictionary *dct = [note userInfo];
    
    mcycle_type_id = [dct objectForKey:@"cycle_type_id"];
    mcycle_type = [dct objectForKey:@"cycle_type"];
    mcargo_type = [dct objectForKey:@"cargo_type"];
    mrestart = [dct objectForKey:@"restart"];
    mrest_break = [dct objectForKey:@"rest_break"];
    mshort_hand_exception = [dct objectForKey:@"short_hand_exception"];
    mwell_site = [dct objectForKey:@"well_site"];
    mfarm_school_exception = [dct objectForKey:@"farm_school_exception"];
    
    self.mCycleNameLabel.text = mcycle_type;

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)CycleTypeEditButton:(id)sender {
   // [Helper movewithStoryBourdID:DM.mAppObj.mBaseNavigation Id:@"ChangeCycleTypeVC" animation:NO];

    ChangeCycleTypeVC * ChangeCycleType = [self.storyboard instantiateViewControllerWithIdentifier:@"ChangeCycleTypeVC"];

    
    ChangeCycleType.mWebCycleRuleSelectedID = mcycle_type_id;

    ChangeCycleType.mWebCycleRuleSelected = mcycle_type;
    ChangeCycleType.mWebCargoTypeSelected = mcargo_type;
    ChangeCycleType.mWebRestBreakSelected = mrest_break;
    ChangeCycleType.mWebRestartTypeSelected = mrestart;
    ChangeCycleType.mWebCwellSiteTypeSelected = mwell_site;
    ChangeCycleType.mWebShortHaulTypeSelected = mshort_hand_exception;
    ChangeCycleType.mWebFarmSchoolBusExceptioneSelected = mfarm_school_exception;


    [self.navigationController pushViewController:ChangeCycleType animated:YES ];


    
    

    
}

- (IBAction)ResetPinButtonAction:(id)sender {
    
    PasswordVC * VC = [self.storyboard instantiateViewControllerWithIdentifier:@"PasswordVC"];
    VC.driverId = driverID;
    VC.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    VC.modalTransitionStyle = UIModalPresentationPopover;
    [self presentViewController:VC animated:YES completion:nil];
    
}

- (IBAction)ResetPasswordButtonAction:(id)sender {
    ResetPasswordVC * VC = [self.storyboard instantiateViewControllerWithIdentifier:@"ResetPasswordVC"];
    VC.driverId = driverID;
    VC.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    VC.modalTransitionStyle = UIModalPresentationPopover;
    [self presentViewController:VC animated:YES completion:nil];
}



- (IBAction)OKButtonAction:(id)sender {
    [self UpdateProfile];
   // OkButtonCheckBool = true;
   // self.CFPinView.hidden = NO ;
}





- (IBAction)DriverOneButtonTap:(id)sender {
    
    SelectedDriver = kSelectedDriverOne;
    
    pin = driverOne.mPinCode;
    if ([DM.loginType isEqualToString:kLoginTypeSingle]) {
        [self Driver1Status];
    }
    else{
        self.CFPinView.hidden = NO ;
    }
    
}
-(void)Driver1Status{
    
    OkButtonCheckBool = false;
    self.mContentView.hidden = false;
    
    self.mDriverOneButton.selected = YES ;
    self.mDriverTwoButton.selected = NO ;
    driverID = driverOne.mDriverId ;
    pin = driverOne.mPinCode;

    [self DriverDataPost:[DataArray objectAtIndex:0]];
}
- (IBAction)DriverTwoButtonTap:(id)sender {
    SelectedDriver = kSelectedDrivertwo;
    
    pin = driverTwo.mPinCode;
    if ([DM.loginType isEqualToString:kLoginTypeSingle]) {
        [self Driver2Status];
        
    }
    else{
        self.CFPinView.hidden = NO ;
    }
}

-(void)Driver2Status{
    OkButtonCheckBool = false;
    self.mContentView.hidden = false;

    self.mDriverTwoButton.selected = YES ;
    self.mDriverOneButton.selected = NO ;
    driverID = driverTwo.mDriverId;
    pin = driverTwo.mPinCode;
    [self DriverDataPost:[DataArray objectAtIndex:1]];
}

-(void)DriverDataPost:(NSDictionary*)dict
{
    SKUser *user = [[SKUser alloc]init];
    [user setupUser:dict];
    NSDictionary *dct = [Helper formatJSONDict:dict];
    
    self.mDriverNameTF.text = [NSString stringWithFormat:@"%@ %@ %@",user.mFirstName,user.mMiddleName,user.mLastName];
    self.mUserNameTF.text = [NSString stringWithFormat:@"%@",user.mUserName];
    self.mDLIssuingStateTF.text = [NSString stringWithFormat:@"%@",user.mDLIssueState];
    self.mDLTF.text = [NSString stringWithFormat:@"%@",user.mDLNumber];
    self.mDotCarrierIDTF.text = [NSString stringWithFormat:@"%@",user.mDotCarrierId];
    self.mCarrierTF.text = [NSString stringWithFormat:@"%@",user.mCompanyName];
    self.mHomeTimeZoneTF.text = [NSString stringWithFormat:@"%@",user.mDriverHomeTimeZone];
    self.mDLExpityTF.text = [NSString stringWithFormat:@"%@",user.mDLExpiryDate];
    self.mShippingDocNumber.text = [NSString stringWithFormat:@"%@",user.mShippingDocumentNumber];
    self.mEmailTF.text = [NSString stringWithFormat:@"%@",user.mEmail];
    self.mPhoneNumberTF.text = [NSString stringWithFormat:@"%@",user.mPhoneNumber];
    
    NSString*stingLength = [NSString stringWithFormat:@"%@",user.mPowerUnitNumber];
    
    
    for (NSDictionary *MatchObj in PowerUnitArray) {
        if ([[MatchObj valueForKey:@"id"]isEqualToString:stingLength]) {
            NSString * string = [NSString stringWithFormat:@"%@/%@",[MatchObj valueForKey:@"vin"],[MatchObj valueForKey:@"power_unit"]];
            self.mPowerUnitNumberTF.text = [NSString stringWithFormat:@"%@",string];
        }
    }
    
    NSString * yardMoveString = [NSString stringWithFormat:@"%@",[dct valueForKey:@"yard_move"]];
    if ([yardMoveString isEqualToString:@"Yes"]){
        self.mYardMoveAuthYesButton.selected = YES ;
        self.mYardMoveAuthNoButton.selected = NO ;
    }else{
        self.mYardMoveAuthYesButton.selected = NO ;
        self.mYardMoveAuthNoButton.selected = YES ;
    }
    
    NSString * personalUseString = [NSString stringWithFormat:@"%@",[dct valueForKey:@"prev_authorized_personal_use_cmv"]];
     if ([personalUseString isEqualToString:@"Yes"]){
         self.mPersonalUseAuthYesButton.selected = YES ;
         self.mPersonalUseAuthNoButton.selected = NO;
     }else{
         self.mPersonalUseAuthYesButton.selected = NO;
         self.mPersonalUseAuthNoButton.selected = YES;
     }
   // self.mCycleNameLabel.text = [NSString stringWithFormat:@"%@",user.mCycleType];
    
    mcycle_type_id = [dict objectForKey:@"cycle_type_id"];
    mcycle_type = [dict objectForKey:@"cycle_type"];
    mcargo_type = [dict objectForKey:@"cargo_type"];
    mrestart = [dict objectForKey:@"restart"];
    mrest_break = [dict objectForKey:@"rest_break"];
    mshort_hand_exception = [dict objectForKey:@"short_hand_exception"];
    mwell_site = [dict objectForKey:@"well_site"];
    mfarm_school_exception = [dict objectForKey:@"farm_school_exception"];
    self.mCycleNameLabel.text = mcycle_type;

    
    self.mTrailerNumberTF.text = [NSString stringWithFormat:@"%@",user.mTrailerNumber];
    
    NSString * trailerNumber1 = [NSString stringWithFormat:@"%@",user.mTrailerNumber2];
   
    if (trailerNumber1.length > 0) {
        self.mTrailer1NumberTF.hidden = NO;
        self.mTrailer1NumberTF.text = trailerNumber1;
      //  self.mRestView.frame = CGRectMake(28, 569, 264, 155);
    }else{
        self.mTrailer1NumberTF.hidden = YES ;
       // self.mRestView.frame = CGRectMake(28, 534, 264, 155);
    }
    NSString * trailerNumber2 = [NSString stringWithFormat:@"%@",user.mTrailerNumber3];

    if (trailerNumber2.length > 0) {
        self.mTrailer2NumberTF.hidden = NO;
        self.mTrailer2NumberTF.text = trailerNumber2;
       // self.mRestView.frame = CGRectMake(28, 604, 264, 155);
    }else{
        self.mTrailer2NumberTF.hidden = YES ;
       // self.mRestView.frame = CGRectMake(28, 569, 264, 155);
    }
    
}

-(void)GetData{
    
    NSString * path = [NSString stringWithFormat:@"%@getUserProfile",kServiceBaseURL];
    
    NSMutableDictionary * parameter = [[NSMutableDictionary alloc]init];
    
   
    [parameter setObject:DM.loginType forKey:@"loginType"];
    [parameter setObject:driverOne.mDriverId forKey:@"driverId1"];
    [parameter setObject:driverTwo.mDriverId forKey:@"driverId2"];

    
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
            DataArray = [[NSMutableArray alloc]init];
            DataArray = [responseDict valueForKey:@"Result"];
            PowerUnitArray = [[NSMutableArray alloc]init];
            PowerUnitArray = [responseDict valueForKey:@"powerUnit"];
            
            for (NSDictionary *MatchObj in PowerUnitArray) {
                NSString * string ;
                NSString * vin  = [NSString stringWithFormat:@"%@",[MatchObj valueForKey:@"vin"]];
                NSString * powerUnitNumber  = [NSString stringWithFormat:@"%@",[MatchObj valueForKey:@"power_unit"]];

                if (vin.length > 0 && powerUnitNumber.length > 0) {
                 string = [NSString stringWithFormat:@"%@/%@",[MatchObj valueForKey:@"vin"],[MatchObj valueForKey:@"power_unit"]];
                }else if (vin.length >0 && powerUnitNumber.length == 0){
                     string = [NSString stringWithFormat:@"%@",[MatchObj valueForKey:@"vin"]];
                }else{
                    string = [NSString stringWithFormat:@"%@",[MatchObj valueForKey:@"power_unit"]];
                }
                
                [powerUnitNumberActionSheet addButtonWithTitle:string];
                [powerUnitNamesArray addObject:string];
            }
            
            
            if ([DM.loginType isEqualToString:kLoginTypeSingle]) {
                [self DriverDataPost:[DataArray objectAtIndex:0]];
            }
            
            
            
        }
        
    } onError:^(NSError * _Nullable Error) {
        NSLog(@"%@",Error);
        NSString *ErrorString = [NSString stringWithFormat:@"%@",Error];
        [Helper ISAlertTypeError:@"Error!!" andMessage:ErrorString];
    }];
    
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    

    if(textField.tag == 10 )// tag will be integer
    {
        [self.view endEditing:YES];
        NSLog(@"ACTION SHEET WILL DISPLAY");
        [textField resignFirstResponder];
        [powerUnitNumberActionSheet showInView:self.view];
        return NO;
    }else{
        return YES;
    }
    
    return YES;
    
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    
    [textField resignFirstResponder];
    
    return YES;
    
}


-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSString *buttonTitle = [actionSheet buttonTitleAtIndex:buttonIndex];
    if ([buttonTitle isEqualToString:@"Cancel"]) {
    }
    else{
        self.mPowerUnitNumberTF.text = buttonTitle ;
        [self.mPowerUnitNumberTF resignFirstResponder];
    }
}

- (IBAction)BackButtonAction:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}



-(void)UpdateProfile{
    
    NSString * path = [NSString stringWithFormat:@"%@updateDriverProfile",kServiceBaseURL];
    
    NSMutableDictionary * parameter = [[NSMutableDictionary alloc]init];
    
    [parameter setObject:DM.loginType forKey:@"loginType"];
    [parameter setObject:driverID forKey:@"driverId"];
    [parameter setObject:self.mEmailTF.text forKey:@"email"];
    
    if (self.mPhoneNumberTF.text.length != 10) {
        [Helper ISAlertTypeError:@"Error !!!" andMessage:@"Please Enter phone Number"];
        return;
    }else{
        [parameter setObject:self.mPhoneNumberTF.text forKey:@"phone_number"];
    }
    
    [parameter setObject:self.mTrailerNumberTF.text forKey:@"trailer_number"];
    [parameter setObject:self.mTrailer1NumberTF.text forKey:@"trailer_number2"];
    [parameter setObject:self.mTrailer2NumberTF.text forKey:@"trailer_number3"];
    [parameter setObject:self.mShippingDocNumber.text forKey:@"shipping_document_number"];
    
    [parameter setObject:self.mCycleNameLabel.text forKey:@"cycle_type"];

    [parameter setObject:mcargo_type forKey:@"cargo_type"];
    [parameter setObject:mrestart forKey:@"restart"];
    [parameter setObject:mrest_break forKey:@"rest_break"];
    [parameter setObject:mshort_hand_exception forKey:@"short_hand_exception"];
    [parameter setObject:mwell_site forKey:@"well_site"];
    [parameter setObject:mfarm_school_exception forKey:@"farm_school_exception"];



    for (NSDictionary *MatchObj in PowerUnitArray) {
        NSString * string ;
        NSString * vin  = [NSString stringWithFormat:@"%@",[MatchObj valueForKey:@"vin"]];
        NSString * powerUnitNumber  = [NSString stringWithFormat:@"%@",[MatchObj valueForKey:@"power_unit"]];
        
        if (vin.length > 0 && powerUnitNumber.length > 0) {
            string = [NSString stringWithFormat:@"%@/%@",[MatchObj valueForKey:@"vin"],[MatchObj valueForKey:@"power_unit"]];
        }else if (vin.length >0 && powerUnitNumber.length == 0){
            string = [NSString stringWithFormat:@"%@",[MatchObj valueForKey:@"vin"]];
        }else{
            string = [NSString stringWithFormat:@"%@",[MatchObj valueForKey:@"power_unit"]];
        }
        
        if ([self.mPowerUnitNumberTF.text isEqualToString:string]) {
            [parameter setObject:[MatchObj valueForKey:@"id"] forKey:@"power_unit_number"];
        }
    }

    [DM PostRequest:path parameter:parameter onCompletion:^(id  _Nullable dict) {
        
        NSError *errorJson=nil;
        NSDictionary* responseDict = [NSJSONSerialization JSONObjectWithData:dict options:kNilOptions error:&errorJson];
        NSLog(@"%@",responseDict);
         NSString *ErrorString = [NSString stringWithFormat:@"%@",[responseDict valueForKey:@"message"]];
        if ([[responseDict valueForKey:@"status"] integerValue] == 0) {
           
            [Helper ISAlertTypeError:@"Error!!" andMessage:ErrorString];
        }
        else{
            [Helper ISAlertTypeSuccess:@"Success" andMessage:ErrorString];

        }
        
    } onError:^(NSError * _Nullable Error) {
        NSLog(@"%@",Error);
        NSString *ErrorString = [NSString stringWithFormat:@"%@",Error];
        [Helper ISAlertTypeError:@"Error!!" andMessage:ErrorString];
    }];

}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    if (textField == self.pin1TF || textField == self.pin2TF || textField == self.pin3TF || textField == self.pin4TF ) {
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
    }
    return YES;
}

-(void)textfildsnil{
    
    self.pin1TF.text = nil ;
    self.pin2TF.text = nil ;
    self.pin3TF.text = nil ;
    self.pin4TF.text = nil ;
    
}

-(void)PasscodeSuccess{
    
    self.mContentView.hidden = false;

    
    if ([DM.loginType isEqualToString:kLoginTypeSingle]) {
        SelectedDriver = kSelectedDriverOne;
        if (OkButtonCheckBool == true) {
            [self UpdateProfile];
        }
        [self GetData];
        [self Driver1Status];
        
    }
    else{
        if ([SelectedDriver isEqualToString:kSelectedDriverOne]) {
            
            if (OkButtonCheckBool == true) {
                [self UpdateProfile];
            }
            [self GetData];

            [self Driver1Status];

            
        }
        else if ([SelectedDriver isEqualToString:kSelectedDrivertwo]){
            if (OkButtonCheckBool == true) {
                [self UpdateProfile];
            }
            [self GetData];

            [self Driver2Status];

            
            
        }
    }
}



- (IBAction)CFPinSubmitButtonAction:(id)sender {
    
    enterdPin = nil ;
    enterdPin = [NSString stringWithFormat:@"%@%@%@%@",self.pin1TF.text,self.pin2TF.text,self.pin3TF.text,self.pin4TF.text];
    NSLog(@"==%@===%@==",pin,enterdPin);
    if ([enterdPin isEqualToString:pin]) {
        self.CFPinView.hidden = YES ;
        [self PasscodeSuccess];
        //[self UpdateProfile];
        [self textfildsnil];
    }else{
        [Helper ISAlertTypeWarning:@"Error" andMessage:@"Please Enter Correct Pin Code"];
        [self textfildsnil];
    }
    NSLog(@"%@",enterdPin);
    
}
- (IBAction)CFPinCloseButtonAction:(id)sender {
    self.CFPinView.hidden = YES ;
    [self textfildsnil];
}

@end
