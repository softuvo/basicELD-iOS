//
//  DVIRVC.m
//  Basic ELD
//
//  Created by Deepak  on 19/08/17.
//  Copyright © 2017 Gaurav Verma. All rights reserved.
//

#import "DVIRVC.h"
#import "SKUser.h"


@interface DVIRVC (){
    UITextField * textFieldOne;
    UITextField * textFieldTwo;
    
    UIButton * sectionOneButton;
    UIButton * sectionTwoButton;
    
    NSMutableArray * sectionOneArray;
    NSMutableArray * trailerOneArray;
    NSMutableArray * trailerTwoArray;
    NSMutableArray * trailerThreeArray;
    NSMutableArray * trailerFourArray;

    
    NSMutableArray * detailArray;
    NSMutableArray * trailerDetailArray;
    
    NSMutableDictionary * trailerDict;
    
    NSDate *dateSelected;
    NSDate *tempDate;
    UIDatePicker *datePicker;
    
    NSDateFormatter * standerd;
    
    UIImage * signatureImage;
    BOOL * isSigned;
    
    int refCount ;
    
    NSString * driverId ;

    NSString *refPin ;
    NSString *enterdPin ;
    NSString *SelectedDriver;;

}

@end

@implementation DVIRVC
@synthesize driverTwo,driverOne;

- (void)viewDidLoad {
    [super viewDidLoad];
     refCount = 4 ;
     trailerDict = [[NSMutableDictionary alloc]init];
    IQKeyboardManager.sharedManager.enable = true;

    [self.mScrollView layoutIfNeeded];
    self.mScrollView.contentSize = self.mContentView.bounds.size;

    IQKeyboardManager.sharedManager.enable = true;

    
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
        self.mDVIRLogView.frame = CGRectMake(0, 95, 320, 434);
        driverId = driverOne.mDriverId;
    }else{
        self.mDriversSelectionView.hidden = NO ;
        self.mDriverOneButton.selected = YES ;
        driverId = driverOne.mDriverId;
        //self.mDriverOneButton.selected = YES ;
    }
    
    

    self.mHeaderView.layer.borderWidth = 1;
    self.mHeaderView.layer.borderColor = [[UIColor whiteColor]CGColor];

    self.mSignaturePopUpView.hidden = YES ;
    
    _mSignaturePopUpView.layer.cornerRadius = 5;
    _mSignaturePopUpView.layer.masksToBounds = true;
    self.mPopUPVIew.layer.cornerRadius = 5 ;
    self.mPopUPVIew.layer.masksToBounds = true ;

    
    [_remarksTextView1.layer setBorderColor:[[[UIColor blackColor] colorWithAlphaComponent:0.5] CGColor]];
    [_remarksTextView1.layer setBorderWidth:2.0];
    _remarksTextView1.layer.cornerRadius = 5;
    _remarksTextView1.clipsToBounds = YES;
    
        
    detailArray = [[NSMutableArray alloc]initWithObjects:@"Air Composer", @"Air Lines", @"Battery", @"Belts & hoses", @"Body", @"Brake Accessories", @"Brakes Parking", @"Brakes Services",@"Clutch", @"Coupling Devices", @"Defroster/Heater", @"Drive Line", @"Engine", @"Exhaust", @"Fifth Wheel", @"Fluid Levels", @"Frame & Assembly",@"Front Axle",@"Fuel Tanks", @"Horns", @"Lights Head-Stop Tail-Dash Turn-Indicators", @"Mirrors",@"Mufflers", @"Oil Pressure", @"Radiator", @"Rear End", @"Reflectors", @"Safety Equipment",@"Starter", @"Steering", @"Suspension System", @"Tire Chains", @"Tires", @"Transmissions", @"Trip Recorder", @"Wheels & Rims", @"Windows", @"WindSheild Wipers", @"Others", nil];
    trailerDetailArray = [[NSMutableArray alloc]initWithObjects:@"Brake Connections", @"Brake", @"Coupling Devices", @"Coupling (King) Pin", @"Doors", @"Hitch", @"Landing Gear", @"Lights - All",@"Reflectors/Reflective Tape", @"Roof", @"Suspension", @"Tarpaulin", @"Tires", @"Wheels & Rims", @"Others", nil];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(receiveTestNotification:)
                                                 name:@"DVIRNotification"
                                               object:nil];

    [self.mConditionsCheckMarkButton setImage:[UIImage imageNamed:@"check_icon"] forState:UIControlStateSelected];
    [self.mConditionsCheckMarkButton setImage:[UIImage imageNamed:@"unCheck_icon"] forState:UIControlStateNormal];


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
    
    
    standerd =[[NSDateFormatter alloc]init];
    [standerd setDateFormat:@"yyyy-MM-dd"];
    NSString *dateString =[standerd stringFromDate:[NSDate date]];
    [self GetData:driverOne.mId date:dateString];
    
    if ([DM.loginType isEqualToString:kLoginTypeSingle]) {
        [self GetData:driverOne.mId date:dateString];
        self.mDVIRLogView.hidden = false;
        
    }
    else{
        self.mDVIRLogView.hidden = true;
    }
    
    
}

-(void)viewWillAppear:(BOOL)animated{
    self.mDriverOneButton.selected = YES ;
    self.mDriverTwoButton.selected = NO ;
    
    driverId = driverOne.mDriverId;
    [super viewWillAppear:YES];
}

-(void)ShowSelectedDate
{   NSDateFormatter *formatter=[[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"dd-MM-YYYY"];
    self.mDateTextField.text=[NSString stringWithFormat:@"%@",[formatter stringFromDate:datePicker.date]];
    NSString *dateString =[standerd stringFromDate:datePicker.date];
    [self GetData:driverOne.mId date:dateString];
    [self.mDateTextField resignFirstResponder];
    
}




-(IBAction)DriverOneButtonAction:(id)sender
{
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


- (void) receiveTestNotification:(NSNotification *) notification {
    
    NSDictionary *userInfo = notification.object ;
    
    NSMutableArray * refArray = [[NSMutableArray alloc]init];
    refArray = notification.object;
    NSLog(@"%@",userInfo);
    if ([userInfo valueForKey:@"Vehicle"]) {
        sectionOneArray = [[NSMutableArray alloc]init];
        sectionOneArray = [userInfo valueForKey:@"Vehicle"];
        //NSLog(@"");
        [self.mTableView reloadData];
    }
   else if ([userInfo valueForKey:@"1"]) {
       trailerOneArray = [[NSMutableArray alloc]init];
        trailerOneArray = [userInfo valueForKey:@"1"];
        [self.mTableView reloadData];
    }
   else if ([userInfo valueForKey:@"2"]) {
       trailerTwoArray = [[NSMutableArray alloc]init];

       trailerTwoArray = [userInfo valueForKey:@"2"];
       [self.mTableView reloadData];
   }
   else if ([userInfo valueForKey:@"3"]) {
       trailerThreeArray = [[NSMutableArray alloc]init];

       trailerThreeArray = [userInfo valueForKey:@"3"];
       [self.mTableView reloadData];
   }
   else if ([userInfo valueForKey:@"4"]) {
       trailerFourArray = [[NSMutableArray alloc]init];

       trailerFourArray = [userInfo valueForKey:@"4"];
       [self.mTableView reloadData];
   }

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/////////////TableView Delegate Methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return refCount;    //count of section
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section == 0)
    {
       return sectionOneArray.count;
    }
    else if(section == 1)
    {
       return trailerOneArray.count;
    }else if(section == 2)
    {
        return trailerTwoArray.count;
    }else if(section == 3)
    {
        return trailerThreeArray.count;
    }
    else
    {
        return trailerFourArray.count;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *MyIdentifier = @"MyIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:MyIdentifier];
    }
    
    if (indexPath.section == 0) {
        cell.textLabel.text = [sectionOneArray objectAtIndex:indexPath.row];
    }else if (indexPath.section == 1){
        cell.textLabel.text = [trailerOneArray objectAtIndex:indexPath.row];
    }else if (indexPath.section == 2){
        cell.textLabel.text = [trailerTwoArray objectAtIndex:indexPath.row];
    }else if (indexPath.section == 3){
        cell.textLabel.text = [trailerThreeArray objectAtIndex:indexPath.row];
    }else if (indexPath.section == 4){
        cell.textLabel.text = [trailerFourArray objectAtIndex:indexPath.row];
    }
    cell.backgroundColor = [UIColor clearColor];
    cell.textLabel.textColor = [UIColor whiteColor];
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *container = [UIView new];
    container.frame = CGRectMake(0, 0, 320, 57);
    container.backgroundColor = [UIColor clearColor];
    if (section == 0) {
        UILabel *label = [UILabel new];
        label.frame = CGRectMake(8, 4, 150, 21);
        label.textColor = [UIColor whiteColor];
        label.text = [NSString stringWithFormat:@"VEHICLE"];
        textFieldOne = [[UITextField alloc]initWithFrame:CGRectMake(8, 25, 289, 30)];
        textFieldOne.placeholder = @"Truck/Tractor Number";
        textFieldOne.textColor = [UIColor whiteColor];
        textFieldOne.font = [UIFont systemFontOfSize:14.0];
        textFieldOne.backgroundColor = [UIColor clearColor];
        textFieldOne.background = [UIImage imageNamed:@"input-bk.png"];
        textFieldOne.keyboardType = UIKeyboardTypeDefault;
        textFieldOne.clearButtonMode = UITextFieldViewModeWhileEditing;
        textFieldOne.delegate = self;
        [container addSubview:textFieldOne];
        [container addSubview:label];
    }else{
        UILabel *label = [UILabel new];
        label.frame = CGRectMake(8, 4, 150, 21);
        label.textColor = [UIColor whiteColor];
        label.font = [UIFont systemFontOfSize:16.0];
        label.text = [NSString stringWithFormat:@"TRAILERS"];
        textFieldTwo = [[UITextField alloc]initWithFrame:CGRectMake(8, 25, 289, 30)];
        textFieldTwo.placeholder = @"Truck/Tractor Number";
        textFieldTwo.textColor = [UIColor whiteColor];
        textFieldTwo.font = [UIFont systemFontOfSize:14.0];
        textFieldTwo.backgroundColor = [UIColor clearColor];
        textFieldTwo.background = [UIImage imageNamed:@"input-bk.png"];
        textFieldTwo.keyboardType = UIKeyboardTypeDefault;
        textFieldTwo.clearButtonMode = UITextFieldViewModeWhileEditing;
        textFieldTwo.delegate = self;
        [container addSubview:textFieldTwo];
        [container addSubview:label];
    }
    return container;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *container = [UIView new];
    container.frame = CGRectMake(0, 0, 320, 32);
    container.backgroundColor = [UIColor clearColor];

    if (section == 0) {
        sectionOneButton = [[UIButton alloc]initWithFrame:CGRectMake(18, 2, 219, 21)];
        //[sectionOneButton setImage:[UIImage imageNamed:@"add-button-click.png"] forState:UIControlStateNormal];
        [sectionOneButton setTitle:@"+ ADD/Remove Vehicle Defects" forState:UIControlStateNormal];
        [sectionOneButton setTintColor:[UIColor whiteColor]];
        sectionOneButton.titleLabel.minimumScaleFactor = 0.5f;
        sectionOneButton.titleLabel.adjustsFontSizeToFitWidth = YES;
        [sectionOneButton addTarget:self action:@selector(sectionOneButtonAction) forControlEvents:UIControlEventTouchUpInside];
        [container addSubview:sectionOneButton];
    }else{
    
        sectionTwoButton = [[UIButton alloc]initWithFrame:CGRectMake(18, 2, 219, 21)];
        //[sectionTwoButton setImage:[UIImage imageNamed:@"add-button-click.png"] forState:UIControlStateNormal];
        [sectionTwoButton setTitle:@"+ ADD/Remove Trailers Defects" forState:UIControlStateNormal];
        [sectionTwoButton setTintColor:[UIColor whiteColor]];
        sectionTwoButton.titleLabel.minimumScaleFactor = 0.5f;
        sectionTwoButton.titleLabel.adjustsFontSizeToFitWidth = YES;
        [sectionTwoButton addTarget:self action:@selector(sectionTwoButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        sectionTwoButton.tag = section ;
        [container addSubview:sectionTwoButton];
    }
    return container;
}



-(void)sectionOneButtonAction{
    NSLog(@"sectionOneButtonAction");

    DVIRDetailVC *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"DVIRDetailVC"];
    vc.mDataArray = detailArray ;
    DM.DVIRSelectedArray = [[NSMutableArray alloc]init];
    DM.DVIRSelectedArray = sectionOneArray ;
    vc.refString = @"Vehicle";
    [self.navigationController pushViewController:vc animated:YES];
    
}


-(void)sectionTwoButtonAction:(UIButton*)sender
{
    NSLog(@"sectionTwoButtonAction");
    NSLog(@"Tag value of Textfield: %ld",(long)sender.tag);
    DVIRDetailVC *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"DVIRDetailVC"];
    vc.mDataArray = trailerDetailArray ;
    DM.DVIRSelectedArray = [[NSMutableArray alloc]init];
    vc.refString =  [NSString stringWithFormat:@"%ld",(long)sender.tag];

    if (sender.tag == 1) {
       
        DM.DVIRSelectedArray = trailerOneArray ;
       // vc.refString =  [NSString stringWithFormat:@"Trailers %ld",(long)sender.tag];
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if (sender.tag == 2){
        
        DM.DVIRSelectedArray = trailerTwoArray ;
        //vc.refString =  [NSString stringWithFormat:@"Trailers %ld",(long)sender.tag];
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if (sender.tag == 3){
        
        DM.DVIRSelectedArray = trailerTwoArray ;
        //vc.refString =  [NSString stringWithFormat:@"Trailers %ld",(long)sender.tag];
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if (sender.tag == 4){
        
        DM.DVIRSelectedArray = trailerTwoArray ;
       // vc.refString =  [NSString stringWithFormat:@"Trailers %ld",(long)sender.tag];
        [self.navigationController pushViewController:vc animated:YES];
    }
    
}


- (IBAction)BackButtonAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];

}
- (IBAction)SignaturePopUpCLoseButtonTap:(id)sender {
    self.mSignaturePopUpView.hidden = YES ;
    
}

- (IBAction)SubmitButtonTap:(id)sender {
    
    if (![_mConditionsCheckMarkButton isSelected]) {
        [Helper ISAlertTypeError:@"Error" andMessage:@"Please Accept Conditions"];
        return ;
    }
    if ([self.signatureView isSigned] == YES) {
        signatureImage = [self.signatureView signatureImage];
        [self.signatureView clear];
        isSigned = true ;
        [self SubmitButtonAction];
        self.mSignaturePopUpView.hidden = YES ;
    }else{
        [Helper ISAlertTypeError:@"Error" andMessage:@"Please Sign"];
    }
}

- (IBAction)ConditionsButtonTap:(id)sender {
    self.mConditionsCheckMarkButton.selected = !self.mConditionsCheckMarkButton.selected;
}

- (IBAction)SignAndSubmitButtonTap:(id)sender {
   
    if (self.remarksTextView1.text.length < 5 ) {
        [Helper ISAlertTypeError:@"Error" andMessage:@"Please Add Remarks"];
        return ;
    }
    
    if (![_mConditionsCheckMarkButton isSelected]) {
        [Helper ISAlertTypeError:@"Error" andMessage:@"Please Accept Conditions"];
        return ;
    }
//    self.mSignaturePopUpView.hidden = NO ;
//    CGRect frame = CGRectMake(8, 27, 257, 257);
//    id view = [[SignatureView alloc] initWithFrame:frame];
//    [self.mPopUPVIew addSubview:view];
//    self.signatureView = view;
    
    [self SubmitButtonAction];

    
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
    [self GetData:driverOne.mId date:dateString];

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
    [self GetData:driverOne.mDriverId date:dateString];

}



-(void)SubmitButtonAction{
    
    [Helper showLoaderVProgressHUD];
    NSString * path = [NSString stringWithFormat:@"%@dvirForm",kServiceBaseURL];
    
    
    NSDateFormatter *dateformate=[[NSDateFormatter alloc]init];
    [dateformate setDateFormat:@"yyyy-MM-dd"];
    NSString *date_String =[dateformate stringFromDate:tempDate];
    
    NSMutableDictionary * dict = [[NSMutableDictionary alloc]init];
    NSMutableDictionary * logsDict = [[NSMutableDictionary alloc]init];
    
    [logsDict setObject:[sectionOneArray componentsJoinedByString:@","] forKey:@"Truck"];
    if (trailerOneArray.count > 0 ) {
        [logsDict setObject:[trailerOneArray componentsJoinedByString:@","] forKey:@"Trailer1"];
    }
    if (trailerTwoArray.count > 0 ) {
    [logsDict setObject:[trailerTwoArray componentsJoinedByString:@","] forKey:@"Trailer2"];
    }
    if (trailerThreeArray.count > 0 ) {
        [logsDict setObject:[trailerThreeArray componentsJoinedByString:@","] forKey:@"Trailer3"];
    }
    if (trailerFourArray.count > 0 ) {
        [logsDict setObject:[trailerFourArray componentsJoinedByString:@","] forKey:@"Trailer4"];
    }

    [dict setValue:date_String forKey:@"created_date"];
    [dict setValue:[NSString stringWithFormat:@"%@",self.remarksTextView1.text] forKey:@"comments"];
    [dict setValue:[[Helper mCurrentUser:kCurrentUserOne]valueForKey:kDriverId] forKey:@"driver_id"];
    [dict setValue:[NSString stringWithFormat:@"%@",logsDict] forKey:@"logs"];
   // [dict setValue:[Helper base64EncodedStringFromImage:signatureImage] forKey:@"signature"];
   

    [DM PostRequest:path parameter:dict onCompletion:^(id  _Nullable dict) {
        
        NSError *errorJson=nil;
        NSString *myStrinag = [[NSString alloc] initWithData:dict encoding:NSUTF8StringEncoding];
        NSLog(@"%@",myStrinag);
        
        NSDictionary* responseDict = [NSJSONSerialization JSONObjectWithData:dict options:kNilOptions error:&errorJson];
        NSLog(@"%@",responseDict);
        NSString *ErrorString = [NSString stringWithFormat:@"%@",[responseDict valueForKey:@"message"]];
        if ([[responseDict valueForKey:@"status"] integerValue] == 0) {
            
            [Helper ISAlertTypeError:@"Error!!" andMessage:ErrorString];
        }
        else{
            [Helper ISAlertTypeSuccess:@"Success" andMessage:ErrorString];
        }
        [Helper hideLoaderSVProgressHUD];
    } onError:^(NSError * _Nullable Error) {
        NSLog(@"%@",Error);
        NSString *ErrorString = [NSString stringWithFormat:@"%@",Error];
    
        NSLog(@"%@",[Error localizedDescription]);

        [Helper ISAlertTypeError:@"Error!!" andMessage:ErrorString];
        [Helper hideLoaderSVProgressHUD];
    }];
}

-(void)GetData:(NSString*)driverID date:(NSString*)date{
    
    NSString * path = [NSString stringWithFormat:@"%@getDvirForm",kServiceBaseURL];
    
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
        }
        else{
            NSLog(@"%@",responseDict);
            NSMutableDictionary * dict = [[NSMutableDictionary alloc]init];
            dict = [responseDict valueForKey:@"logs"];
            if ([dict valueForKey:@"Truck"]) {
                sectionOneArray = [[NSMutableArray alloc]init];
                sectionOneArray = [responseDict valueForKey:@"Truck"];
            }
            if ([dict valueForKey:@"Trailer1"]) {
                trailerOneArray = [[NSMutableArray alloc]init];
                trailerOneArray = [dict valueForKey:@"Trailer1"];
                
            }
            if ([dict valueForKey:@"Trailer2"]) {
                trailerTwoArray = [[NSMutableArray alloc]init];
                trailerTwoArray = [dict valueForKey:@"Trailer2"];
                
            }
            if ([dict valueForKey:@"Trailer3"]) {
                trailerThreeArray = [[NSMutableArray alloc]init];
                trailerThreeArray = [dict valueForKey:@"Trailer3"];
                
            }
            if ([dict valueForKey:@"Trailer4"]) {
                trailerFourArray = [[NSMutableArray alloc]init];
                trailerFourArray = [dict valueForKey:@"Trailer4"];
                
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.mTableView reloadData];
            });
        }
        
    } onError:^(NSError * _Nullable Error) {
        NSLog(@"%@",Error);
        NSString *ErrorString = [NSString stringWithFormat:@"%@",Error];
       // [Helper ISAlertTypeError:@"Error!!" andMessage:ErrorString];
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
    self.mDVIRLogView.hidden = false;

    
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
