//
//  InspectionLogVC.m
//  Basic ELD
//
//  Created by Gaurav Verma on 09/10/17.
//  Copyright © 2017 Gaurav Verma. All rights reserved.
//

#import "InspectionLogVC.h"
#import "InspectionCell.h"


@interface InspectionLogVC (){
    
    NSMutableArray * driverOneData ;
    NSMutableArray * driverTwoData ;
    
    NSMutableArray *dataArray;
    
    NSString * driverId ;
    
    NSDate *dateSelected;
    NSDate *tempDate;
    UIDatePicker *datePicker;
    
    NSDateFormatter * standerd;
    
    NSString *refPin ;
    NSString *enterdPin ;
    NSString *TodaydateString;
    
    NSString *SelectedDriver;

}

@end

@implementation InspectionLogVC
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
        self.mInspectionlogView.frame = CGRectMake(0, 95, 320, 431);
        driverId = driverOne.mDriverId;
    }else{
        self.mDriversSelectionView.hidden = NO ;
        self.mDriverOneButton.selected = YES ;
        driverId = driverOne.mDriverId;
        //self.mDriverOneButton.selected = YES ;
    }
    
    datePicker=[[UIDatePicker alloc]init];
    datePicker.datePickerMode=UIDatePickerModeDate;
    [self.mDateTextField setInputView:datePicker];
    UIToolbar *toolBar=[[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 44)];
    [toolBar setTintColor:[UIColor grayColor]];
    UIBarButtonItem *doneBtn=[[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleBordered target:self action:@selector(ShowSelectedDate)];
    UIBarButtonItem *space=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    [toolBar setItems:[NSArray arrayWithObjects:space,doneBtn, nil]];
    [self.mDateTextField setInputAccessoryView:toolBar];
    
    NSDateFormatter *dateformate=[[NSDateFormatter alloc]init];
    [dateformate setDateFormat:@"dd-MM-yyyy"];
    NSString *date_String =[dateformate stringFromDate:[NSDate date]];
    tempDate = [NSDate date];
    self.mDateTextField.text = date_String ;
    
   // TodaydateString = date_String ;
    
    standerd =[[NSDateFormatter alloc]init];
    [standerd setDateFormat:@"yyyy-MM-dd"];
    TodaydateString =[standerd stringFromDate:[NSDate date]];
    
    self.mInspectionlogView.hidden = true;
    
    if ([DM.loginType isEqualToString:kLoginTypeSingle]) {
        
        [self GetInspectionPDF:driverOne.mDriverId date:TodaydateString];
      //  [self GetData:driverOne.mDriverId date:TodaydateString];
      //  self.mInspectionlogView.hidden = false;

    }
    else{
     //   self.mInspectionlogView.hidden = true;
    }
    
    
    
}


-(void)ShowSelectedDate
{   NSDateFormatter *formatter=[[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"dd-MM-YYYY"];
    self.mDateTextField.text=[NSString stringWithFormat:@"%@",[formatter stringFromDate:datePicker.date]];
    NSString *dateString =[standerd stringFromDate:datePicker.date];
    
    if ([DM.loginType isEqualToString:kLoginTypeSingle]) {
        [self GetData:driverOne.mDriverId date:dateString];
    }
    else{
        if ([SelectedDriver isEqualToString:kSelectedDriverOne]) {
            [self GetData:driverOne.mDriverId date:dateString];
        }
        else if ([SelectedDriver isEqualToString:kSelectedDrivertwo]){
            [self GetData:driverTwo.mDriverId date:dateString];
        }
    }
    
    
    
   
    [self.mDateTextField resignFirstResponder];
    
}



-(void)viewWillAppear:(BOOL)animated{
    self.mDriverOneButton.selected = YES ;
    self.mDriverTwoButton.selected = NO ;
    
    driverId = driverOne.mDriverId;
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
    driverId = driverTwo.mDriverId ;
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)BackButtonAction:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}



-(void)GetData:(NSString*)driverID date:(NSString*)date{
    
    NSString * path = [NSString stringWithFormat:@"%@getLogs",kServiceBaseURL];
    
    NSMutableDictionary * parameter = [[NSMutableDictionary alloc]init];
    [parameter setValue:driverID forKey:@"driverid"];
    [parameter setValue:date forKey:@"date"];
    
    [DM PostRequest:path parameter:parameter onCompletion:^(id  _Nullable dict) {
        
        NSError *errorJson=nil;
        NSDictionary* responseDict = [NSJSONSerialization JSONObjectWithData:dict options:kNilOptions error:&errorJson];
        NSLog(@"%@",responseDict);
        if ([[responseDict valueForKey:@"status"] integerValue] == 0) {
            NSString *ErrorString = [NSString stringWithFormat:@"%@",[responseDict valueForKey:@"message"]];
            //[Helper ISAlertTypeError:@"Error!!" andMessage:ErrorString];
            [dataArray removeAllObjects];
        }
        else{
            NSLog(@"%@",responseDict);
           
            [dataArray removeAllObjects];
            [dataArray addObjectsFromArray:[responseDict valueForKey:@"Result"]];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.mTableView reloadData];
        });
        
    } onError:^(NSError * _Nullable Error) {
        NSLog(@"%@",Error);
        NSString *ErrorString = [NSString stringWithFormat:@"%@",Error];
        // [Helper ISAlertTypeError:@"Error!!" andMessage:ErrorString];
    }];
    
}



-(void)GetInspectionPDF:(NSString*)driverID date:(NSString*)date{
    [Helper showLoaderVProgressHUD];
    NSString * path = [NSString stringWithFormat:@"%@displayLogsPdf",kServiceBaseURL];
   // path = [path stringByReplacingOccurrencesOfString:@"/app/" withString:@"/AppTest/"];
    
    NSMutableDictionary * parameter = [[NSMutableDictionary alloc]init];
    [parameter setValue:driverID forKey:@"driver_id"];
    //[parameter setValue:date forKey:@"date"];
    
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
            
        }
        dispatch_async(dispatch_get_main_queue(), ^{

            [self CallWebview:[responseDict valueForKey:@"url"]];

        
        });
        
        [Helper hideLoaderSVProgressHUD];

    } onError:^(NSError * _Nullable Error) {
        NSLog(@"%@",Error);
        NSString *ErrorString = [NSString stringWithFormat:@"%@",Error];
        // [Helper ISAlertTypeError:@"Error!!" andMessage:ErrorString];
    }];
    
}





- (IBAction)PreviousDayTap:(id)sender {
    NSDate *now;
    if (tempDate == nil) {
        now = [NSDate date];
    }else{
        now = tempDate;
    }
    
    NSDate *sevenDaysAgo = [now dateByAddingTimeInterval:-1*24*60*60];
    NSDateFormatter *dateformate=[[NSDateFormatter alloc]init];
    [dateformate setDateFormat:@"dd-MM-yyyy"];
    tempDate = sevenDaysAgo;
    NSString *date_String =[dateformate stringFromDate:sevenDaysAgo];
    self.mDateTextField.text = date_String ;
    NSString *dateString =[standerd stringFromDate:sevenDaysAgo];
    
    if ([DM.loginType isEqualToString:kLoginTypeSingle]) {
        [self GetData:driverOne.mDriverId date:dateString];
    }
    else{
        if ([SelectedDriver isEqualToString:kSelectedDriverOne]) {
            [self GetData:driverOne.mDriverId date:dateString];
        }
        else if ([SelectedDriver isEqualToString:kSelectedDrivertwo]){
            [self GetData:driverTwo.mDriverId date:dateString];
        }
    }
    
}

- (IBAction)NextDayTap:(id)sender {
    NSDate *now;
    if (tempDate == nil) {
        now = [NSDate date];
    }else{
        now = tempDate;
    }
    
    NSDate *sevenDaysAgo = [now dateByAddingTimeInterval:+1*24*60*60];
    NSDateFormatter *dateformate=[[NSDateFormatter alloc]init];
    [dateformate setDateFormat:@"dd-MM-yyyy"];
    tempDate = sevenDaysAgo;
    NSString *date_String =[dateformate stringFromDate:sevenDaysAgo];
    self.mDateTextField.text = date_String ;
    NSString *dateString =[standerd stringFromDate:sevenDaysAgo];
    if ([DM.loginType isEqualToString:kLoginTypeSingle]) {
        [self GetData:driverOne.mDriverId date:dateString];
    }
    else{
        if ([SelectedDriver isEqualToString:kSelectedDriverOne]) {
            [self GetData:driverOne.mDriverId date:dateString];
        }
        else if ([SelectedDriver isEqualToString:kSelectedDrivertwo]){
            [self GetData:driverTwo.mDriverId date:dateString];
        }
    }
    
}












- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;    //count of section
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return dataArray.count;    //count number of row from counting array hear cataGorry is An Array
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 23.0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *MyIdentifier = @"InspectionCell";
    
    InspectionCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
    
    if (cell == nil)
    {
        cell = [[InspectionCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:MyIdentifier] ;
    }
    
    NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
    dict = [dataArray objectAtIndex:indexPath.row];
    
    cell.mSnoLabel.text = [NSString stringWithFormat:@"%ld",(long)indexPath.row + 1];
    cell.mStatusLabel.text = [NSString stringWithFormat:@"%@",[dict valueForKey:@"mode"]];
    cell.mStartTimeLabel.text = [NSString stringWithFormat:@"%@",[dict valueForKey:@"start_time"]];
    cell.mDurationLabel.text = [NSString stringWithFormat:@"%@",[dict valueForKey:@"duration"]];
    cell.mLocationLabel.text = [NSString stringWithFormat:@"%@",[dict valueForKey:@"address"]];
    
    
    UIView *bgColorView = [[UIView alloc] init];
    [bgColorView setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.3]];
    [cell setSelectedBackgroundView:bgColorView];
    
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return YES if you want the specified item to be editable.
    return YES;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
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
    
  //  self.mInspectionlogView.hidden = false;
    
    self.mDateTextField.text = TodaydateString;
    
    if ([DM.loginType isEqualToString:kLoginTypeSingle]) {
        [self Driver1Status];
        [self GetInspectionPDF:driverOne.mDriverId date:TodaydateString];

      //  [self GetData:driverOne.mDriverId date:TodaydateString];
    }
    else{
        if ([SelectedDriver isEqualToString:kSelectedDriverOne]) {
            [self Driver1Status];
            [self GetInspectionPDF:driverOne.mDriverId date:TodaydateString];

          //  [self GetData:driverOne.mDriverId date:TodaydateString];

        }
        else if ([SelectedDriver isEqualToString:kSelectedDrivertwo]){
            [self Driver2Status];
            [self GetInspectionPDF:driverTwo.mDriverId date:TodaydateString];

          //  [self GetData:driverTwo.mDriverId date:TodaydateString];

        }
    }
}




-(void)CallWebview:(NSString *)URLString{
    NSURL *URL = [NSURL URLWithString:URLString];
    
    DZNWebViewController *WVC = [[DZNWebViewController alloc] initWithURL:URL];
    UINavigationController *NC = [[UINavigationController alloc] initWithRootViewController:WVC];
    
    WVC.supportedWebNavigationTools = DZNWebNavigationToolAll;
    WVC.supportedWebActions = DZNWebActionNone;
    WVC.showLoadingProgress = YES;
    WVC.allowHistory = NO;
    WVC.hideBarsWithGestures = NO;
    
    [self presentViewController:NC animated:YES completion:NULL];
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
