//
//  EditLogsVC.m
//  Basic ELD
//
//  Created by Manoj Gadamsetty on 30/08/17.
//  Copyright © 2017 Gaurav Verma. All rights reserved.
//

#import "EditLogsVC.h"
#import "DataManager.h"
#import "EditLogDetailVC.h"
#import "ADDRemarksVC.h"
#import "ChangeCurrentDutyStatusVC.h"


@interface EditLogsVC (){
    BOOL AlertShowCheckBool;
    NSMutableArray * dataArray ;
    
    NSDictionary * driverOneDetails;
    NSDictionary * driverTwoDetails;
    
    UIDatePicker *datePicker ;
    
    NSDate *dateSelected;
    NSDate *tempDate;
    
    NSString * driverId;
    NSString * date;
    
    NSString *refPin ;
    NSString *enterdPin ;
    
    NSString *SelectedDriver;
    NSString *Cirtify_Log_date_String;
}

@end

@implementation EditLogsVC
@synthesize driverOne,driverTwo;


- (void)viewDidLoad {
    [super viewDidLoad];
    SelectedDriver = kSelectedDriverOne;
    self.CFPinView.hidden = YES ;

    driverOne = [[SKUser alloc] init];
    [driverOne setupUser:[Helper mCurrentUser:kCurrentUserOne]];
    driverOneDetails = [[NSDictionary alloc]init];
    driverOneDetails = [Helper mCurrentUser:kCurrentUserOne];
    
    driverTwo = [[SKUser alloc] init];
    [driverTwo setupUser:[Helper mCurrentUser:kCurrentUserTwo]];
    driverTwoDetails = [[NSDictionary alloc]init];
    driverTwoDetails = [Helper mCurrentUser:kCurrentUserTwo];
    
    [self Elements];
    
    if (self.msg) {
        self.mDriversView.hidden = YES ;
        driverId = self.msg ;
        self.msg = nil ;
    }else{
        if([DM.loginType  isEqualToString:kLoginTypeSingle]){
            self.mDriversView.hidden = YES ;
            driverId = [NSString stringWithFormat:@"%@",driverOne.mDriverId];
            self.mEditlogView.hidden = false;
            
            self.driverModell = driverOne;

        }else{
            self.mEditlogView.hidden = true;

           // [self PreselectedDriverOne];
        }
    }
    
    self.mPlusButtonPopUpView.hidden = YES;
    self.mLogRemarkTextView.text = @"Add Daily Log Remarks";
    self.mLogRemarkTextView.textColor = [UIColor whiteColor];
    
    // Do any additional setup after loading the view.
}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    
    [self GetData:[DM dateFormateForServer:tempDate] driverID:driverId];
    
}
-(void)Elements{
    
    [self.mDriverOneButton setImage:[UIImage imageNamed:@"selectedDriver"] forState:UIControlStateSelected];
    [self.mDriverOneButton setImage:[UIImage imageNamed:@"unSelectedDriver"] forState:UIControlStateNormal];
    
    
    [self.mDriverTwoButton setImage:[UIImage imageNamed:@"selectedDriver"] forState:UIControlStateSelected];
    [self.mDriverTwoButton setImage:[UIImage imageNamed:@"unSelectedDriver"] forState:UIControlStateNormal];
    
    [self.mUnidentifiedButton setImage:[UIImage imageNamed:@"selectedDriver"] forState:UIControlStateSelected];
    [self.mUnidentifiedButton setImage:[UIImage imageNamed:@"unSelectedDriver"] forState:UIControlStateNormal];
    
    
    self.mHeaderView.layer.borderWidth = 1;
    self.mHeaderView.layer.borderColor = [[UIColor whiteColor]CGColor];
    self.mLogsTableView.allowsMultipleSelectionDuringEditing = NO;
    
    
    datePicker=[[UIDatePicker alloc]init];
    datePicker.datePickerMode=UIDatePickerModeDate;
    [self.mDateTextField setInputView:datePicker];
    UIToolbar *toolBar=[[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 44)];
    [toolBar setTintColor:[UIColor grayColor]];
    UIBarButtonItem *doneBtn=[[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleBordered target:self action:@selector(ShowSelectedDate)];
    UIBarButtonItem *space=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    [toolBar setItems:[NSArray arrayWithObjects:space,doneBtn, nil]];
    [self.mDateTextField setInputAccessoryView:toolBar];
    
    NSDateFormatter *dateformateOne=[[NSDateFormatter alloc]init];
    [dateformateOne setDateFormat:@"dd-MM-yyyy"];
    NSString *date_String =[dateformateOne stringFromDate:[NSDate date]];
    tempDate = [NSDate date];
    date = date_String ;

    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDate *currentDate = [NSDate date];
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    [comps setDay:0];
    NSDate *maxDate = [calendar dateByAddingComponents:comps toDate:currentDate options:0];
    [comps setDay:-7];
    NSDate *minDate = [calendar dateByAddingComponents:comps toDate:currentDate options:0];
    
    [datePicker setMaximumDate:maxDate];
    [datePicker setMinimumDate:minDate];
    
    NSDateFormatter *dateformatetwo=[[NSDateFormatter alloc]init];
    [dateformatetwo setDateFormat:@"yyyy-MM-dd"];
    Cirtify_Log_date_String =[dateformatetwo stringFromDate:[NSDate date]];
    
    
    
    [self GetData:[DM dateFormateForServer:tempDate] driverID:driverId];
    self.mDateTextField.text = date_String ;

    
}

-(void)ShowSelectedDate
{
    NSDateFormatter *formatter=[[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"dd-MM-YYYY"];
    self.mDateTextField.text=[NSString stringWithFormat:@"%@",[formatter stringFromDate:datePicker.date]];
    tempDate = datePicker.date;
    date = [NSString stringWithFormat:@"%@",[formatter stringFromDate:datePicker.date]];
    
    NSDateFormatter *dateformatetwo=[[NSDateFormatter alloc]init];
    [dateformatetwo setDateFormat:@"yyyy-MM-dd"];
    Cirtify_Log_date_String =[NSString stringWithFormat:@"%@",[dateformatetwo stringFromDate:datePicker.date]];

    
    [self GetData:[DM dateFormateForServer:tempDate] driverID:driverId];
    [self.mDateTextField resignFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    static NSString *MyIdentifier = @"editCell";
    
    EditCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
    
    if (cell == nil)
    {
        cell = [[EditCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:MyIdentifier] ;
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

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        //add code here for when you hit delete
    }
}


-(NSArray *)tableView:(UITableView* )tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
        UITableViewRowAction *button = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"Delete" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath)
                                       {
                                         //  idxPath = indexPath;
                                          //
                                          // [self PasswordView1];
                                           
                                           
                                           NSLog(@"Delete Button Pressed");
                                       }];
        button.backgroundColor = [UIColor redColor]; //arbitrary color
        UITableViewRowAction *button2 = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"  Edit  " handler:^(UITableViewRowAction *action, NSIndexPath *indexPath)
                        {
                            NSLog(@"Edit Button Pressed");
                            
                        EditLogDetailVC * vc = [self.storyboard instantiateViewControllerWithIdentifier:@"EditLogDetailVC"];
                            NSDictionary *dctobj =  [Helper formatJSONDict:[dataArray objectAtIndex:indexPath.row]];
                            vc.mDataDict = dctobj;
                            vc.driverId = driverId ;
                            vc.driverModel =  self.driverModell;
                            vc.flowMsg = kEditLogs ;
                            [self.navigationController pushViewController:vc animated:YES];
                            
                        }];
       // button2.backgroundColor = [UIColor colorWithRed:67/255. green:173/255. blue:50/255. alpha:1.]; //arbitrary color
        button2.backgroundColor = [UIColor clearColor]; //arbitrary color
        return @[button2]; //array with all the buttons you want. 1,2,3, etc...
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    if ([textView.text isEqualToString:@"Add Daily Log Remarks"]) {
        textView.text = @"";
        textView.textColor = [UIColor whiteColor]; //optional
    }
    [textView becomeFirstResponder];
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    if ([textView.text isEqualToString:@""]) {
        textView.text = @"Add Daily Log Remarks";
        textView.textColor = [UIColor whiteColor];
    }
    [textView resignFirstResponder];
}

- (IBAction)BackButtonAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];

}

- (IBAction)ConfirmAndSignButtonAction:(id)sender {
    UIAlertView *alrt ;
    if (AlertShowCheckBool == TRUE) {
        alrt = [[UIAlertView alloc] initWithTitle:@"Alert!!" message:@"I hereby certify that my data entries and my record of duty status for this 24-hour period are true and correct." delegate:self cancelButtonTitle:@"Not Ready" otherButtonTitles:@"Agree",nil];
        alrt.tag = 1012;
        [alrt show];
    }
    else{
        alrt = [[UIAlertView alloc] initWithTitle:@"Alert!!" message:@"I hereby recertify that my data entries and my record of duty status for this 24-hour period are true and correct." delegate:self cancelButtonTitle:@"Not Ready" otherButtonTitles:@"Agree",nil];
        alrt.tag = 1012;
        [alrt show];
        
      //  [self CertifyLog:driverId date:Cirtify_Log_date_String];

    }
    
    
   
    
    

}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
   if (alertView.tag == 1012){
        if (buttonIndex == 0) {
           
            
        }
        else if (buttonIndex == 1) {
           
            [self CertifyLog:driverId date:Cirtify_Log_date_String];

            
        }
       
    }
    
}

-(void)CertifyLog:(NSString*)driverID date:(NSString*)date{
    [Helper hideLoaderSVProgressHUD];

    
    CLLocationCoordinate2D coordinate = [DM getLocation];
    NSString *latLong = [NSString stringWithFormat:@"%f,%f", coordinate.latitude,coordinate.longitude];
    
    NSString * path = [NSString stringWithFormat:@"%@addLogRemark",kServiceBaseURL];
    
    NSMutableDictionary * parameter = [[NSMutableDictionary alloc]init];
    [parameter setValue:driverID forKey:@"driver_id"];
    [parameter setValue:date forKey:@"date"];
    [parameter setValue:self.mLogRemarkTextView.text forKey:@"remark"];
    [parameter setValue:latLong forKey:@"lat_long"];

    
    [DM PostRequest:path parameter:parameter onCompletion:^(id  _Nullable dict) {
        
        NSError *errorJson=nil;
        NSDictionary* responseDict = [NSJSONSerialization JSONObjectWithData:dict options:kNilOptions error:&errorJson];
        NSLog(@"%@",responseDict);
        if ([[responseDict valueForKey:@"status"] integerValue] == 0) {
            [Helper hideLoaderSVProgressHUD];

            NSString *ErrorString = [NSString stringWithFormat:@"%@",[responseDict valueForKey:@"message"]];
            //[Helper ISAlertTypeError:@"Error!!" andMessage:ErrorString];
           
        }
        else{
            NSLog(@"%@",responseDict);
            [Helper hideLoaderSVProgressHUD];
            if (AlertShowCheckBool == TRUE) {
                [Helper ISAlertTypeSuccess:@"Certify Logs" andMessage:[NSString stringWithFormat:@"%@",[responseDict valueForKey:@"message"]]];

            }
            else{
                [Helper ISAlertTypeSuccess:@"Recertify Logs" andMessage:[NSString stringWithFormat:@"%@",[responseDict valueForKey:@"message"]]];

            }

            [self GetData:[DM dateFormateForServer:tempDate] driverID:driverId];

        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            self.mLogRemarkTextView.text = nil;
         //   self.mCertifyLogsButton.enabled = false;
        });
        
    } onError:^(NSError * _Nullable Error) {
        NSLog(@"%@",Error);
        NSString *ErrorString = [NSString stringWithFormat:@"%@",Error];
    }];
    
}






-(void)GetData:(NSString *)requestDate driverID:(NSString*)requestDriverId
{
    
    
    NSString * path = [NSString stringWithFormat:@"%@getLogs",kServiceBaseURL];
    
    NSMutableDictionary * parameter = [[NSMutableDictionary alloc]init];
    [parameter setValue:requestDriverId forKey:@"driverid"];
    [parameter setValue:requestDate forKey:@"date"];

    [DM PostRequest:path parameter:parameter onCompletion:^(id  _Nullable dict) {
        
        NSError *errorJson=nil;
        NSDictionary* responseDict = [NSJSONSerialization JSONObjectWithData:dict options:kNilOptions error:&errorJson];
        NSLog(@"%@",responseDict);
        if ([[responseDict valueForKey:@"status"] integerValue] == 0) {
           // NSString *ErrorString = [NSString stringWithFormat:@"%@",[responseDict valueForKey:@"message"]];
            //[Helper ISAlertTypeError:@"Error!!" andMessage:ErrorString];
        }
        else{
            NSLog(@"%@",responseDict);
            dataArray = [[NSMutableArray alloc]init];
            dataArray = [responseDict valueForKey:@"Result"];
            dispatch_async(dispatch_get_main_queue(), ^{
              
                if (([[[dataArray objectAtIndex:0] valueForKey:kisCertified] isEqualToString:kfalse]) && ([[[dataArray objectAtIndex:0] valueForKey:kisrecertified] isEqualToString:kfalse])) {
                    NSLog(@"%@",[[dataArray objectAtIndex:0] valueForKey:kisCertified]);
                    
                    [self.mCertifyLogsButton setTitle:@"CERTIFY LOGS" forState:UIControlStateNormal];
                    [self.mCertifyLogsButton setEnabled:YES];
                    AlertShowCheckBool = TRUE;
                }
                else if (([[[dataArray objectAtIndex:0] valueForKey:kisCertified] isEqualToString:ktrue]) && ([[[dataArray objectAtIndex:0] valueForKey:kisrecertified] isEqualToString:kfalse])) {
                    NSLog(@"%@",[[dataArray objectAtIndex:0] valueForKey:kisCertified]);
                    [self.mCertifyLogsButton setTitle:@"RECERTIFY LOGS" forState:UIControlStateNormal];
                    [self.mCertifyLogsButton setEnabled:YES];
                    AlertShowCheckBool = FALSE;

                    
                }
                else if (([[[dataArray objectAtIndex:0] valueForKey:kisCertified] isEqualToString:ktrue]) && ([[[dataArray objectAtIndex:0] valueForKey:kisrecertified] isEqualToString:ktrue])) {
                    NSLog(@"%@",[[dataArray objectAtIndex:0] valueForKey:kisCertified]);
                    
                    [self.mCertifyLogsButton setTitle:@"CERTIFY LOGS" forState:UIControlStateNormal];
                    [self.mCertifyLogsButton setEnabled:NO];
                    AlertShowCheckBool = FALSE;

                    
                }
               
                
               
                
               
                
                [self.mLogsTableView reloadData];
            });
        }
        
    } onError:^(NSError * _Nullable Error) {
        NSLog(@"%@",Error);
        NSString *ErrorString = [NSString stringWithFormat:@"%@",Error];
      //  [Helper ISAlertTypeError:@"Error!!" andMessage:ErrorString];
    }];
    
    
}
- (IBAction)DriverOneButtonTap:(id)sender {
    
    [self PreselectedDriverOne];
}

-(void)PreselectedDriverOne{
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
    self.mDriverTwoButton.selected = NO ;
    self.mUnidentifiedButton.selected = NO ;
    self.mDriverOneButton.selected = YES ;
    
    self.driverModell = driverOne;
    
    driverId = [NSString stringWithFormat:@"%@",driverOne.mDriverId];
    [self GetData:[DM dateFormateForServer:tempDate] driverID:driverId];
}

- (IBAction)UnidentifiedButtonTap:(id)sender {
    
        self.mDriverOneButton.selected = NO ;
        self.mDriverTwoButton.selected = NO ;
        self.mUnidentifiedButton.selected = YES ;
}
- (IBAction)DriverTwoButtonTap:(id)sender {
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
        self.mUnidentifiedButton.selected = NO ;
        self.mDriverTwoButton.selected = YES ;
        self.driverModell = driverTwo;

        driverId = [NSString stringWithFormat:@"%@",driverTwo.mDriverId];
        [self GetData:[DM dateFormateForServer:tempDate] driverID:driverId];
}
- (IBAction)AddRemarkTap:(id)sender {
    [self PopUpViewHidden];
    ADDRemarksVC * vc = [self.storyboard instantiateViewControllerWithIdentifier:@"ADDRemarksVC"];
    vc.driverId = driverId ;
    vc.selectedDate = [DM dateFormateForServer:tempDate]  ;
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)CloseButtonAction:(id)sender {
    [self ButtonRotate];

    NSString * string1 = [DM dateFormateForServer:tempDate];
    NSString * string2 = [DM dateFormateForServer:[NSDate date]];

    if ([string1 isEqualToString:string2]) {
        self.insertLogPopUpViewOne.frame = CGRectMake(92, 348, 228, 99);
        self.changeCurrentDutyStatusView.hidden = NO ;
        
    }else{
        self.insertLogPopUpViewOne.frame = CGRectMake(92, 398, 228, 99);
        self.changeCurrentDutyStatusView.hidden = YES ;
    }
    self.mPlusButtonPopUpView.hidden =! self.mPlusButtonPopUpView.hidden ;
}

- (IBAction)ChangeCurrentDutyStatusTap:(id)sender {
    [self PopUpViewHidden];
//    ChangeCurrentDutyStatusVC * vc = [self.storyboard instantiateViewControllerWithIdentifier:@"ChangeCurrentDutyStatusVC"];
//    vc.driverId = driverId ;
//    [self.navigationController pushViewController:vc animated:YES];
    
    EditLogDetailVC * vc = [self.storyboard instantiateViewControllerWithIdentifier:@"EditLogDetailVC"];
    vc.driverId = driverId ;
    vc.driverModel =  self.driverModell;
    vc.flowMsg = kCurrentDutyLogs ;
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)InsertPastDutyStatus:(id)sender {
    [self PopUpViewHidden];
    EditLogDetailVC * vc = [self.storyboard instantiateViewControllerWithIdentifier:@"EditLogDetailVC"];
    vc.driverId = driverId ;
    vc.driverModel =  self.driverModell;
    vc.mSelectedDate = [DM dateFormateForServer:tempDate];
    
    vc.flowMsg = kInsertLogs ;
    [self.navigationController pushViewController:vc animated:YES];
    
}

- (IBAction)OverlaybackgroundTap:(id)sender {
    [self PopUpViewHidden];
}



-(void)ButtonRotate{
    
    if (self.mPlusButtonPopUpView.hidden) {
        [UIView animateWithDuration:0.3f delay:0.1 options:UIViewAnimationOptionCurveEaseOut animations:^{
            self.view.autoresizesSubviews = NO;
            [self.mPopUpCloseButton setTransform:CGAffineTransformMakeRotation(M_PI/4)];
        } completion:nil];
    }else{
        [UIView animateWithDuration:0.3f delay:0.1 options:UIViewAnimationOptionCurveEaseOut animations:^{
            self.view.autoresizesSubviews = NO;
            [self.mPopUpCloseButton setTransform:CGAffineTransformIdentity];
        } completion:nil];
    }
    
}

-(void)PopUpViewHidden{

    [self ButtonRotate];
    [UIView animateWithDuration:0.5 animations:^{
        self.mPlusButtonPopUpView.hidden = YES;
    }];
 
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
    self.mEditlogView.hidden = false;

    
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

@end
