//
//  PasswordVC.m
//  Basic ELD
//
//  Created by Manoj Gadamsetty on 13/09/17.
//  Copyright © 2017 Gaurav Verma. All rights reserved.
//

#import "PasswordVC.h"
#import "SKUser.h"

@interface PasswordVC ()

@end

@implementation PasswordVC

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

- (IBAction)SubmitButtonTap:(id)sender {
    
    if ([self.mSubmitButton.titleLabel.text isEqualToString:@"Ok"]) {
        [self OverLayTap:nil];
    }else{
        if([self isValidPassword:self.mPasswordTF.text]) {
            [self SubmitButtonAction];
        }else{
            if (self.mPasswordTF.text.length < 6 ) {
                [Helper ISAlertTypeError:@"Error !!!" andMessage:@"Password should be more than 6 Characters"];
        }
    }
}
    
    
}
- (IBAction)OverLayTap:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)CloseButtonTap:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)SubmitButtonAction{
    
    NSString * path = [NSString stringWithFormat:@"%@resetPin",kServiceBaseURL];
    
    NSMutableDictionary * parameter = [[NSMutableDictionary alloc]init];
    [parameter setValue:self.driverId forKey:@"driverId"];
    [parameter setValue:self.mPasswordTF.text forKey:@"password"];
   
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
            //[self.view setUserInteractionEnabled:NO];
            self.msgLabel.text = ErrorString;
            self.mPasswordTF.hidden = YES ;
            self.enterPasswordLabel.hidden = YES ;
            self.msgLabel.hidden = NO ;
            [self.mSubmitButton setTitle:@"Ok" forState:UIControlStateNormal];
            
            if ([[[Helper mCurrentUser:kCurrentUserOne]valueForKey:kDriverId]isEqualToString:self.driverId]) {
                
                
                
                SKUser * user = [[SKUser alloc]init];
                [user setupCurrentUser:[responseDict valueForKey:@"Result"] driverName:kCurrentUserOne];
                
               // [user UpdateCurrentUser:[responseDict valueForKey:@"updatedPin"] userDictt:[[Helper mCurrentUser:kCurrentUserOne]mutableCopy] driverName:kCurrentUserOne];
            }
            if ([[[Helper mCurrentUser:kCurrentUserTwo]valueForKey:kDriverId]isEqualToString:self.driverId]) {
                SKUser * user = [[SKUser alloc]init];
                [user setupCurrentUser:[responseDict valueForKey:@"Result"] driverName:kCurrentUserOne];

                //[user UpdateCurrentUser:[responseDict valueForKey:@"updatedPin"] userDictt:[[Helper mCurrentUser:kCurrentUserTwo]mutableCopy] driverName:kCurrentUserTwo];
            }
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



@end
