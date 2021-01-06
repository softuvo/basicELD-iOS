//
//  FirstTimeUserVC.m
//  Basic ELD
//
//  Created by Deepak  on 21/07/17.
//  Copyright © 2017 Gaurav Verma. All rights reserved.
//

#import "FirstTimeUserVC.h"
#import "TermsAndConditionsVC.h"


@interface FirstTimeUserVC ()
{
   
    NSString *message;
    NSString *refMessage;
    
    UIImage * signatureImage;
    NSString * passwordText;
    BOOL * isSigned;
    BOOL * passwordCheckboxButton ;

}

@end

@implementation FirstTimeUserVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.usernameTick.hidden = YES ;
    self.passwordTick.hidden = YES ;
    self.confirmPasswordTick.hidden = YES ;
    self.mSignaturePopUpView.hidden = YES ;

    _mSignaturePopUpView.layer.cornerRadius = 5;
    _mSignaturePopUpView.layer.masksToBounds = true;
    self.mPopUPVIew.layer.cornerRadius = 5 ;
    self.mPopUPVIew.layer.masksToBounds = true ;
    IQKeyboardManager.sharedManager.enable = true;
    
    [self.mTermsAndConditionsButton setImage:[UIImage imageNamed:@"check_icon"] forState:UIControlStateSelected];
    [self.mTermsAndConditionsButton setImage:[UIImage imageNamed:@"unCheck_icon"] forState:UIControlStateNormal];

    // Do any additional setup after loading the view.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)clearButtonTap:(id)sender {
    [self textfildsnil];
}

-(void)closeAction{
    if (self.delegate && [self.delegate respondsToSelector:@selector(ChangeStatuscancelButtonClicked:)])
    {
        [self.delegate ChangeStatuscancelButtonClicked:self];
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
    const int movementDistance = (txtPosition < 0 ? 0 : txtPosition); // tweak as needed
    const float movementDuration = 0.3f; // tweak as needed
    
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
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
//    if (textField == self.confirmPasswordTF) {
//        if (self.passwordTick.hidden == NO) {
//            return YES;
//        }else{
//            [Helper showAlert:@"Error" andMessage:@"Please Create Password" andButton:@"Ok"];
//            return NO;
//        }
//    }
    return YES ;
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    
    [self animateTextField: textField up: NO];
}

- (BOOL)textFieldShouldReturn:(UITextField *)theTextField {
    NSInteger nextTag = theTextField.tag + 1;
    UIResponder* nextResponder = [theTextField.superview viewWithTag:nextTag];
    if (nextResponder) {
        [nextResponder becomeFirstResponder];
    } else {
        [theTextField resignFirstResponder];
    }
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {

    if (textField == self.pin1TF || textField == self.pin2TF || textField == self.pin3TF || textField == self.pin4TF)
      {
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


-(BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    
    
    if (textField == self.emailTextField) {
        if ([self.emailTextField.text length]==0) {
            self.usernameTick.hidden=YES;
        }
        else  {
            self.usernameTick.hidden=NO;
        }
    }
    if (textField == self.createPasswordTF) {
    if ([self.createPasswordTF.text length]==0) {
        self.passwordTick.hidden=YES;
    }else  {
        if([self isValidPassword:self.createPasswordTF.text]) {
            if (self.createPasswordTF.text.length < 6 ) {
                self.passwordTick.hidden=YES;
                [Helper showAlert:@"Error" andMessage:@"Password should be more than 6 Characters" andButton:@"Ok"];
            }else{
                passwordText = nil ;
                passwordText = [NSString stringWithFormat:@"%@",self.createPasswordTF.text];
                self.passwordTick.hidden=NO;
            }
        }
        else {
            NSString * string  = @"Password must be minimum 6 characters,at least 1 Uppercase Alphabet, 1 Lowercase Alphabet,1 Number and 1 Special Character";
            [Helper showAlert:@"Error" andMessage:string andButton:@"Ok"];
            self.createPasswordTF.text = nil ;
        }
    }
    }
     if (textField == self.confirmPasswordTF) {
         
         NSString * passwodRef =[NSString stringWithFormat:@"%@",self.confirmPasswordTF.text];
          if ([self.confirmPasswordTF.text length]==0){
            self.confirmPasswordTick.hidden=YES;
        
          }
           else if ([passwordText isEqualToString:passwodRef]){
              self.confirmPasswordTick.hidden=NO;
           }else if (![passwordText isEqualToString:passwodRef]){

             self.confirmPasswordTick.hidden = YES ;
             [Helper showAlert:@"Error" andMessage:@"Password Mismatch" andButton:@"Ok"];
             self.confirmPasswordTF.text = nil ;
              
           }
     }
    return YES;
}





- (BOOL)validateEmailWithString:(NSString*)email
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
   
    return [emailTest evaluateWithObject:email];
}

-(BOOL)isValidPassword:(NSString *)passwordString
{
   
    NSString *stricterFilterString = @"^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[$@$!%*?&])[A-Za-z\\d$@$!%*?&]{6,}";
    NSPredicate *passwordTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", stricterFilterString];
   
    return [passwordTest evaluateWithObject:passwordString];
}
-(BOOL) isPasswordValid:(NSString *)pwd {
    
    NSCharacterSet *upperCaseChars = [NSCharacterSet characterSetWithCharactersInString:@"ABCDEFGHIJKLKMNOPQRSTUVWXYZ"];
    NSCharacterSet *lowerCaseChars = [NSCharacterSet characterSetWithCharactersInString:@"abcdefghijklmnopqrstuvwxyz"];
    
    //NSCharacterSet *numbers = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
    
    if ( [pwd length]<6 || [pwd length]>20 )
        return NO;  // too long or too short
    NSRange rang;
    rang = [pwd rangeOfCharacterFromSet:[NSCharacterSet letterCharacterSet]];
    if ( !rang.length )
        return NO;  // no letter
    rang = [pwd rangeOfCharacterFromSet:[NSCharacterSet decimalDigitCharacterSet]];
    if ( !rang.length )
        return NO;  // no number;
    rang = [pwd rangeOfCharacterFromSet:upperCaseChars];
    if ( !rang.length )
        return NO;  // no uppercase letter;
    rang = [pwd rangeOfCharacterFromSet:lowerCaseChars];
    if ( !rang.length )
        return NO;  // no lowerCase Chars;
    return YES;
}

#pragma mark ---------------------------------------------------------
#pragma mark KEYBORD AUTO MOVE END
#pragma mark ---------------------------------------------------------


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)SignatureTap:(id)sender {
    
    self.mSignaturePopUpView.hidden = NO ;
    CGRect frame = CGRectMake(8, 27, 257, 257);
    id view = [[SignatureView alloc] initWithFrame:frame];
    [self.mPopUPVIew addSubview:view];
    self.signatureView = view;

}
- (IBAction)DoneButtonSignaturePopUpTap:(id)sender {
   
    if ([self.signatureView isSigned] == YES) {
        self.mSignatureLabel.hidden = YES ;
        signatureImage = [self.signatureView signatureImage];
        [self.mSignatureIV setImage:signatureImage];
        [self.signatureView clear];
        isSigned = true ;
    }
     self.mSignaturePopUpView.hidden = YES ;
}

- (IBAction)AcceptButtonTap:(id)sender {
    
    if (self.emailTextField.text.length != 0 && self.pin1TF.text.length != 0 && self.pin2TF.text.length != 0 && self.pin3TF.text.length != 0 && self.pin4TF.text.length != 0 && [self.createPasswordTF.text isEqualToString:self.confirmPasswordTF.text] && isSigned && self.mTermsAndConditionsButton.selected ) {
        [self LoginFunctionallity];
        
        NSLog(@"Done");
    }else if (self.emailTextField.text.length == 0 ){
        [Helper showAlert:@"Error" andMessage:@"Please Enter UserName" andButton:@"Ok"];
    }else if (self.pin1TF.text.length == 0 || self.pin2TF.text.length == 0 || self.pin3TF.text.length == 0 || self.pin4TF.text.length == 0){
        [Helper showAlert:@"Error" andMessage:@"Please Enter PIN Properly" andButton:@"Ok"];
    }else if (![self.createPasswordTF.text isEqualToString:self.confirmPasswordTF.text]){
        [Helper showAlert:@"Error" andMessage:@"Password Mismatch" andButton:@"Ok"];
    }else if ( !isSigned ){
        [Helper showAlert:@"Error" andMessage:@"Please Sign" andButton:@"Ok"];
    }else if ( !self.mTermsAndConditionsButton.selected ){
        [Helper showAlert:@"Error" andMessage:@"Please Accept Terms and Conditions" andButton:@"Ok"];
    }
}



-(void)LoginFunctionallity {
  
    if (DM.mInternetStatus == false) {
        NSLog(@"No Internet Connection.");
        [Helper ISAlertTypeError:@"Internet Connection!!" andMessage:kNOInternet];
        
        return;
        }
        else{
        [Helper showLoaderVProgressHUD];
        NSString *path=[NSString stringWithFormat:@"%@%@",kServiceBaseURL,kregister];
        NSString *pin = [NSString stringWithFormat:@"%@%@%@%@",self.pin1TF.text,self.pin2TF.text,self.pin3TF.text,self.pin4TF.text];
        NSMutableDictionary *Parameter = [[NSMutableDictionary alloc] init];
        [Parameter setObject:self.emailTextField.text forKey:@"user_name"];
        [Parameter setObject:pin forKey:@"pin_code"];
        [Parameter setObject:passwordText forKey:@"password"];
        [Parameter setObject:[Helper base64EncodedStringFromImage:signatureImage] forKey:@"user_signature"];
        [Parameter setObject:DM.loginType forKey:@"driver_mode"];
        CLLocationCoordinate2D coordinate = [DM getLocation];
        NSString *latLong = [NSString stringWithFormat:@"%f,%f", coordinate.latitude,coordinate.longitude];
        [Parameter setObject:latLong forKey:@"lat_long"];
                
        [DM PostRequest:path parameter:Parameter onCompletion:^(id dict) {
        [Helper hideLoaderSVProgressHUD];
        NSError *errorJson=nil;
        NSString *myStrinag = [[NSString alloc] initWithData:dict encoding:NSUTF8StringEncoding];
        NSLog(@"%@",myStrinag);
            
        NSDictionary* responseDict = [NSJSONSerialization JSONObjectWithData:dict options:kNilOptions error:&errorJson];
        NSLog(@"%@",responseDict);
        NSString *ErrorString = [NSString stringWithFormat:@"%@",[responseDict valueForKey:@"message"]];

        if ([[responseDict valueForKey:@"status"] integerValue] == 0) {
            [Helper ISAlertTypeError:@"" andMessage:ErrorString];
            [self closeAction];
            }
        else{
            [Helper ISAlertTypeSuccess:@"Success !!" andMessage:ErrorString];
            [self closeAction];
        }       
    } onError:^(NSError *Error) {
        [Helper hideLoaderSVProgressHUD];
        NSLog(@"%@",Error);
        NSString *ErrorString = [NSString stringWithFormat:@"%@",Error];
        [Helper ISAlertTypeError:@"Error!!" andMessage:ErrorString];
        }];
    }
}


- (IBAction)TermsAndConditionsTap:(id)sender {
    self.mTermsAndConditionsButton.selected = !self.mTermsAndConditionsButton.selected;
}

- (IBAction)closeButtonTap:(id)sender {
    [self closeAction];
}

- (IBAction)TermsAndConditionsLabelTap:(id)sender {
    TermsVC * vc = [self.storyboard instantiateViewControllerWithIdentifier:@"TermsVC"];
    [self.navigationController pushViewController:vc animated:YES];
}


-(void)textfildsnil{
   
    self.emailTextField.text = nil ;
    self.pin1TF.text = nil ;
    self.pin2TF.text = nil ;
    self.pin3TF.text = nil ;
    self.pin4TF.text = nil ;
    self.createPasswordTF.text = nil ;
    self.confirmPasswordTF.text = nil ;
    self.mSignatureIV.image = nil ;
    self.usernameTick.hidden = YES;
    self.confirmPasswordTick.hidden = YES;
    self.passwordTick.hidden = YES;
    
   }



@end
