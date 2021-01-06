//
//  ResetPasswordVC.m
//  Basic ELD
//
//  Created by Manoj Gadamsetty on 13/09/17.
//  Copyright © 2017 Gaurav Verma. All rights reserved.
//

#import "ResetPasswordVC.h"

@interface ResetPasswordVC ()

@end

@implementation ResetPasswordVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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

- (IBAction)CloseButtonTap:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];

}

- (IBAction)OverLayBackGroundTap:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];

}
- (IBAction)SubmitButtonTap:(id)sender {
    
    if([self isValidPassword:self.mNewPasswordTF.text]) {
            [self SubmitButtonAction];
    }else{
        if (self.mNewPasswordTF.text.length < 6 ) {
    [Helper ISAlertTypeError:@"Error !!!" andMessage:@"Password should be more than 6 Characters"];
    }
   }
}

-(void)SubmitButtonAction{
    
    NSString * path = [NSString stringWithFormat:@"%@resetPassword",kServiceBaseURL];
    
    NSMutableDictionary * parameter = [[NSMutableDictionary alloc]init];
    [parameter setValue:self.driverId forKey:@"driverId"];
    [parameter setValue:self.mOldPasswordTF.text forKey:@"oldPassword"];
    [parameter setValue:self.mNewPasswordTF.text forKey:@"newPassword"];
    [parameter setValue:self.mConfirmPasswordTF.text forKey:@"confirmPassword"];

    [DM PostRequest:path parameter:parameter onCompletion:^(id  _Nullable dict) {
        
        NSError *errorJson=nil;
        NSDictionary* responseDict = [NSJSONSerialization JSONObjectWithData:dict options:kNilOptions error:&errorJson];
        NSLog(@"%@",responseDict);
        NSString *ErrorString = [NSString stringWithFormat:@"%@",[responseDict valueForKey:@"message"]];
        if ([[responseDict valueForKey:@"status"] integerValue] == 0) {
            [Helper ISAlertTypeError:@"Error!!" andMessage:ErrorString];
        }
        else{
            NSLog(@"%@",responseDict);
            [Helper ISAlertTypeSuccess:@"Sucess !!" andMessage:ErrorString];
            [self CloseButtonTap:nil];
        }
        
    } onError:^(NSError * _Nullable Error) {
        NSLog(@"%@",Error);
        NSString *ErrorString = [NSString stringWithFormat:@"%@",Error];
        [Helper ISAlertTypeError:@"Error!!" andMessage:ErrorString];
    }];
    
}

-(BOOL)isValidPassword:(NSString *)passwordString
{
    
    NSString *stricterFilterString = @"^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[$@$!%*?&])[A-Za-z\\d$@$!%*?&]{6,}";
    NSPredicate *passwordTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", stricterFilterString];
    
    return [passwordTest evaluateWithObject:passwordString];
}

-(BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    
    if (textField == self.mNewPasswordTF) {
        
            if([self isValidPassword:self.mNewPasswordTF.text]) {
                if (self.mNewPasswordTF.text.length < 6 ) {
                    [Helper ISAlertTypeError:@"Error!!" andMessage:@"Password should be more than 6 Characters"];
                }
            }
            else {
                NSString * string  = @"Password must be minimum 6 characters,at least 1 Uppercase Alphabet, 1 Lowercase Alphabet,1 Number and 1 Special Character";
                [Helper ISAlertTypeError:@"Error!!" andMessage:string];
            }
        
    }
    if (textField == self.mConfirmPasswordTF) {
        
        NSString * passwodRef =[NSString stringWithFormat:@"%@",self.mConfirmPasswordTF.text];
        
        if ([self.mConfirmPasswordTF.text isEqualToString:self.mNewPasswordTF.text]){
        }else if (![self.mConfirmPasswordTF.text isEqualToString:passwodRef]){
            [Helper ISAlertTypeError:@"Error!!" andMessage:@"Password Mismatch"];
            self.mConfirmPasswordTF.text = nil ;
            
        }
    }
    return YES;
}




@end
