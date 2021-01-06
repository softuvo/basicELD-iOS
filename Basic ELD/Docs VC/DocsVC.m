//
//  DocsVC.m
//  Basic ELD
//
//  Created by Manoj Gadamsetty on 30/08/17.
//  Copyright © 2017 Gaurav Verma. All rights reserved.
//

#import "DocsVC.h"
#import "AppDelegate.h"



@interface DocsVC (){
    
    NSString * driverSelectionRef ;

    NSString * driverId ;
    NSMutableArray * mDataArray ;
    NSMutableArray * refArray ;
    
    NSMutableArray * docNameArray ;
    
    
    NSMutableArray * driverOneData ;
    NSMutableArray * driverTwoData ;
    
    NSString *refPin ;
    NSString *enterdPin ;
    NSString *SelectedDriver;
}

@end

@implementation DocsVC
@synthesize driverOne,driverTwo;

- (void)viewDidLoad {
    [super viewDidLoad];
    SelectedDriver = kSelectedDriverOne;
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
        self.mDocsTableView.frame = CGRectMake(16, 100, 288, 440);
        driverId = driverOne.mDriverId;
    }else{
        self.mDriversSelectionView.hidden = NO ;
        self.mDriverOneButton.selected = YES ;
        driverId = driverOne.mDriverId;
        //self.mDriverOneButton.selected = YES ;
    }
    
    mDataArray = [[NSMutableArray alloc]init];
    self.mHeaderView.layer.borderWidth = 1;
    self.mHeaderView.layer.borderColor = [[UIColor whiteColor]CGColor];
    
    [self GetData];
    if ([DM.loginType isEqualToString:kLoginTypeSingle]) {
        
    }
    else{
        self.mDocsTableView.hidden = true;
    }
    
    
    
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated{
    
  
        
       

    self.mDriverOneButton.selected = YES ;
    self.mDriverTwoButton.selected = NO ;

    driverId = driverOne.mDriverId;
    
    [self GetData];
    
    if ([DM.loginType isEqualToString:kLoginTypeSingle]) {
        
    }
    [super viewWillAppear:YES];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;    //count of section
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
   return refArray.count;
    //return 3;//count number of row from counting array hear cataGorry is An Array
}



- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *MyIdentifier = @"docs";
    
    DocsCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
    
    // Configure the cell...
    if (cell == nil) {
        cell = [[DocsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:MyIdentifier];
    }
    [cell.mDocButton setTitle:[NSString stringWithFormat:@"%@",[[refArray objectAtIndex:indexPath.row]valueForKey:@"documentName"]] forState:UIControlStateNormal];
     cell.mDocButton.tag = indexPath.row ;
    [cell.mDocButton addTarget:self action:@selector(SelectedDoc:) forControlEvents:UIControlEventTouchUpInside];

    return cell;
}

-(void)SelectedDoc:(UIButton*)sender{
    NSInteger * tag = sender.tag;
    NSLog(@"%@",refArray);
    DocumentVC * vc = [self.storyboard instantiateViewControllerWithIdentifier:@"DocumentVC"];
    vc.mDataDict = [refArray objectAtIndex:sender.tag];
    vc.driverID = driverId ;
    [self.navigationController pushViewController:vc animated:YES];
    NSLog(@"%ld",(long)tag);
    
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
    self.mDocsTableView.hidden = false;
    
    self.mDriverOneButton.selected = YES ;
    self.mDriverTwoButton.selected = NO ;
    driverId = driverOne.mDriverId ;
    refArray = driverOneData ;
    [self.mDocsTableView reloadData];
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
    
    self.mDocsTableView.hidden = false;
    
    self.mDriverOneButton.selected = NO ;
    self.mDriverTwoButton.selected = YES ;
    driverId = driverTwo.mDriverId ;
    refArray = driverTwoData ;
    [self.mDocsTableView reloadData];
}

- (IBAction)BackButtonAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (IBAction)AddDocsButtonAction:(id)sender {
    
    docNameArray = [[NSMutableArray alloc]init];
    
    if (refArray.count != 0 ) {
        for (NSDictionary *MatchObj in refArray) {
            [docNameArray addObject:[MatchObj valueForKey:@"documentName"]];
        }
    }
    DocumentVC * vc = [self.storyboard instantiateViewControllerWithIdentifier:@"DocumentVC"];
    vc.driverID = driverId ;
    vc.refArray = docNameArray ;
    [self.navigationController pushViewController:vc animated:YES];
    
}

-(void)GetData{
    // get_docs
    NSString *path = [NSString stringWithFormat:@"%@get_docs",kServiceBaseURL];
    
    NSMutableDictionary * perameters = [[NSMutableDictionary alloc]init];
    [perameters setObject:DM.loginType forKey:@"loginType"];
    [perameters setObject:driverOne.mDriverId forKey:@"driverId1"];
    [perameters setObject:driverTwo.mDriverId forKey:@"driverId2"];

    [DM PostRequest:path parameter:perameters onCompletion:^(id  _Nullable dict) {
        NSError *errorJson=nil;
        NSDictionary* responseDict = [NSJSONSerialization JSONObjectWithData:dict options:kNilOptions error:&errorJson];
        NSLog(@"%@",responseDict);
        refArray = [[NSMutableArray alloc]init];
        if ([[responseDict valueForKey:@"status"] integerValue] == 0) {
            NSString *ErrorString = [NSString stringWithFormat:@"%@",[responseDict valueForKey:@"message"]];
            [Helper ISAlertTypeError:@"Error!!" andMessage:ErrorString];
        }
        else{
            NSMutableArray * array = [[NSMutableArray alloc]init];
            array = [responseDict valueForKey:@"Result"];
            
            if (array.count !=0) {
            if ([DM.loginType isEqualToString:kLoginTypeSingle]) {
                
                driverOneData = [[NSMutableArray alloc]init];
                driverOneData = [[responseDict valueForKey:@"Result"]objectAtIndex:0];
                refArray = driverOneData ;
                
            }else{
                driverOneData = [[NSMutableArray alloc]init];
                driverOneData = [[responseDict valueForKey:@"Result"]objectAtIndex:0];
                refArray = driverOneData ;
                
                driverTwoData = [[NSMutableArray alloc]init];
                driverTwoData = [[responseDict valueForKey:@"Result"]objectAtIndex:1];
            }
            }else{
            
            }
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [_mDocsTableView reloadData];
        });
    }onError:^(NSError * _Nullable Error) {
        NSLog(@"%@",Error);
        NSString *ErrorString = [NSString stringWithFormat:@"%@",Error];
        [Helper ISAlertTypeError:@"Error!!" andMessage:ErrorString];
    }];
    

}

-(void)dataReload{
    
    
    
    
    
}
//Passcode Start

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
    
    
    if ([DM.loginType isEqualToString:kLoginTypeSingle]) {
        SelectedDriver = kSelectedDriverOne;
        [self Driver1Status];
    }
    else{
        if ([SelectedDriver isEqualToString:kSelectedDriverOne]) {
            [self Driver1Status];
            
        }
        else if ([SelectedDriver isEqualToString:kSelectedDrivertwo]){
            [self Driver2Status];
            
        }
    }
}


//Passcode END

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
