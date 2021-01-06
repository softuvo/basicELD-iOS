//
//  ContactUsVC.m
//  Basic ELD
//
//  Created by Manoj Gadamsetty on 29/08/17.
//  Copyright © 2017 Gaurav Verma. All rights reserved.
//

#import "ContactUsVC.h"
#import "AppDelegate.h"

@interface ContactUsVC ()

@end

@implementation ContactUsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.mHeaderView.layer.borderWidth = 1;
    self.mHeaderView.layer.borderColor = [[UIColor whiteColor]CGColor];
    [self getData];
    // Do any additional setup after loading the view.
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)getData{
    
    NSString *path = [NSString stringWithFormat:@"%@contact_us",kServiceBaseURL];
    
    [DM PostRequest:path parameter:nil onCompletion:^(id  _Nullable dict) {
        NSError *errorJson=nil;
        NSDictionary* responseDict = [NSJSONSerialization JSONObjectWithData:dict options:kNilOptions error:&errorJson];
        NSLog(@"%@",responseDict);
        if ([[responseDict valueForKey:@"status"] integerValue] == 0) {
            
            NSString *ErrorString = [NSString stringWithFormat:@"%@",[responseDict valueForKey:@"message"]];
            [Helper ISAlertTypeError:@"Error!!" andMessage:ErrorString];
        }
        else{
            
            self.mTitleLabel.text = [NSString stringWithFormat:@"%@",[[responseDict valueForKey:@"Result"]valueForKey:@"page_title"]];
            self.mContentView.text = [NSString stringWithFormat:@"%@",[[responseDict valueForKey:@"Result"]valueForKey:@"content"]];
        }
    }onError:^(NSError * _Nullable Error) {
        NSLog(@"%@",Error);
        NSString *ErrorString = [NSString stringWithFormat:@"%@",Error];
        [Helper ISAlertTypeError:@"Error!!" andMessage:ErrorString];
    }];
    
    
    
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

- (IBAction)BackButtonAction:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
    
}
@end
