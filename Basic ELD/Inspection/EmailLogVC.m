//
//  EmailLogVC.m
//  Basic ELD
//
//  Created by Gaurav Verma on 17/11/17.
//  Copyright © 2017 Gaurav Verma. All rights reserved.
//

#import "EmailLogVC.h"

@interface EmailLogVC (){
    NSMutableArray * driverOneData ;
    NSMutableArray * driverTwoData ;
    
    NSMutableArray *dataArray;
    
    NSString * driverId ;
    
    
    NSString *refPin ;
    NSString *enterdPin ;
    NSString *TodaydateString;
    
    NSString *SelectedDriver;
    NSString *message;

}

@end

@implementation EmailLogVC
@synthesize driverOne,driverTwo;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    SelectedDriver = kSelectedDriverOne;
    
    dataArray = [[NSMutableArray alloc] init];
    self.CFPinView.hidden = YES ;
    
    [self.mDriverOneButton setImage:[UIImage imageNamed:@"selectedDriver"] forState:UIControlStateSelected];
    [self.mDriverOneButton setImage:[UIImage imageNamed:@"unSelectedDriver"] forState:UIControlStateNormal];
    
    [self.mDriverTwoButton setImage:[UIImage imageNamed:@"selectedDriver"] forState:UIControlStateSelected];
    [self.mDriverTwoButton setImage:[UIImage imageNamed:@"unSelectedDriver"] forState:UIControlStateNormal];
    
    
    driverOne = [[SKUser alloc] init];
    [driverOne setupUser:[Helper mCurrentUser:kCurrentUserOne]];
    
    
    driverTwo = [[SKUser alloc] init];
    [driverTwo setupUser:[Helper mCurrentUser:kCurrentUserTwo]];
    
    
    if ([DM.loginType isEqualToString:kLoginTypeSingle]) {
        self.mDriversSelectionView.hidden = YES ;
        self.mEmaillogView.frame = CGRectMake(0, 95, 320, 431);
        driverId = driverOne.mDriverId;
    }else{
        self.mDriversSelectionView.hidden = NO ;
        self.mDriverOneButton.selected = YES ;
        driverId = driverOne.mDriverId;
        //self.mDriverOneButton.selected = YES ;
    }

    if ([DM.loginType isEqualToString:kLoginTypeSingle]) {
        
        //  [self GetData:driverOne.mDriverId date:TodaydateString];
          self.mEmaillogView.hidden = false;
        
    }
    else{
           self.mEmaillogView.hidden = true;
    }



}




-(void)viewWillAppear:(BOOL)animated{
    self.mDriverOneButton.selected = YES ;
    self.mDriverTwoButton.selected = NO ;
    
 //   driverId = driverOne.mDriverId;
    [super viewWillAppear:YES];
}

- (IBAction)DriverOneButtonAction:(id)sender {
    SelectedDriver = kSelectedDriverOne;
    refPin = driverOne.mPinCode;
    if ([DM.loginType isEqualToString:kLoginTypeSingle]) {
        [self Driver1Status];
        
    }
    else{
        self.CFPinView.hidden = NO ;
    }
    
    
    
}

-(void)Driver1Status{
    self.mDriverOneButton.selected = YES ;
    self.mDriverTwoButton.selected = NO ;
    
    self.mEmailTextField.text = nil;
    self.mMessageTextView.text = nil;
    driverId = driverOne.mDriverId ;
    
}

- (IBAction)DriverTwoButtonAction:(id)sender {
    SelectedDriver = kSelectedDrivertwo;
    refPin = driverTwo.mPinCode;
    
    if ([DM.loginType isEqualToString:kLoginTypeSingle]) {
        [self Driver2Status];
        
    }
    else{
        self.CFPinView.hidden = NO ;
    }
    
    
    
}
-(void)Driver2Status{
    self.mDriverOneButton.selected = NO ;
    self.mDriverTwoButton.selected = YES ;
    
    self.mEmailTextField.text = nil;
    self.mMessageTextView.text = nil;
    
    driverId = driverTwo.mDriverId ;
    
}


- (IBAction)BackButtonAction:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
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
        
        [self PasscodeSuccess];
        
        
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

-(void)PasscodeSuccess{
    
      self.mEmaillogView.hidden = false;
    
    
    if ([DM.loginType isEqualToString:kLoginTypeSingle]) {
        [self Driver1Status];
        
        
        //  [self GetData:driverOne.mDriverId date:TodaydateString];
    }
    else{
        if ([SelectedDriver isEqualToString:kSelectedDriverOne]) {
            [self Driver1Status];
            
            //  [self GetData:driverOne.mDriverId date:TodaydateString];
            
        }
        else if ([SelectedDriver isEqualToString:kSelectedDrivertwo]){
            [self Driver2Status];
            
            //  [self GetData:driverTwo.mDriverId date:TodaydateString];
            
        }
    }
}

-(void)keyborddown{
    [self.view endEditing:YES];
}



- (IBAction)textFieldDoneEditing:(id)sender {
    [sender resignFirstResponder];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



-(void)Keydow{
    [self.view endEditing:YES];
}


- (IBAction)SendButtonPressed:(id)sender{
    
    
    [self Keydow];
    [self TextfieldVelidations];
    
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
            
           
           // Hit API
            [Helper showLoaderVProgressHUD];

            [self SendEmail:driverId email:self.mEmailTextField.text message:self.mMessageTextView.text];
            
        }
        
        
        
    }
    
    message = nil;
    
}





-(void)SendEmail:(NSString*)driverID email:(NSString*)email message:(NSString*)message{
    NSString * path = [NSString stringWithFormat:@"%@sendEventReport",kServiceBaseURL];
    
    NSMutableDictionary * parameter = [[NSMutableDictionary alloc]init];
    [parameter setValue:driverID forKey:@"driver_id"];
    [parameter setValue:email forKey:@"email"];
    [parameter setValue:message forKey:@"message"];

    
    [DM PostRequest:path parameter:parameter onCompletion:^(id  _Nullable dict) {
        
        NSError *errorJson=nil;
        NSDictionary* responseDict = [NSJSONSerialization JSONObjectWithData:dict options:kNilOptions error:&errorJson];
        NSLog(@"%@",responseDict);
        if ([[responseDict valueForKey:@"status"] integerValue] == 0) {
            NSString *ErrorString = [NSString stringWithFormat:@"%@",[responseDict valueForKey:@"message"]];
            [Helper hideLoaderSVProgressHUD];

            [Helper ISAlertTypeError:@"Error!!" andMessage:ErrorString];
        }
        else{
            NSLog(@"%@",responseDict);
            [Helper hideLoaderSVProgressHUD];

             [Helper ISAlertTypeSuccess:@"Alert!!" andMessage:[responseDict valueForKey:@"message"]];
            
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            self.mEmailTextField.text = nil;
            self.mMessageTextView.text = nil;
            
        });
        

    } onError:^(NSError * _Nullable Error) {
        NSLog(@"%@",Error);
        NSString *ErrorString = [NSString stringWithFormat:@"%@",Error];
        // [Helper ISAlertTypeError:@"Error!!" andMessage:ErrorString];
    }];
    
}











-(void)TextfieldVelidations{
    
    
    if ([self.mEmailTextField.text length ] == 0  ) {
        message = @"Please enter a valid email.";
    }
    
    else{
        if (self.mEmailTextField.text != nil)
        {
            NSString *emailString = self.mEmailTextField.text;
            
            NSString *emailReg = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
            NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",emailReg];
            if (([emailTest evaluateWithObject:emailString] != YES) || [emailString isEqualToString:@""])
            {
                message = @" Enter Valid Email";
                
                self.mEmailTextField.text = nil;
            }
        }
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

@end
