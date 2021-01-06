//
//  DVIRVC.m
//  Basic ELD
//
//  Created by Deepak  on 19/08/17.
//  Copyright © 2017 Gaurav Verma. All rights reserved.
//

#import "DVIRVC.h"
#import "SKUser.h"
#import "AppDelegate.h"



@interface DVIRVC (){
    
    UITextField * textFieldOne;
    UITextField * textFieldTwo;
    
    UIButton * sectionOneButton;
    UIButton * sectionTwoButton;
    
    NSDictionary*logdictarray;
    
    
    NSString*driverIssue_send;
    NSString*driverIssue_get;
    NSString *Strpowerid;
    
    NSString*chkunitstr;
    
    NSString*lat;
    NSString*Long;
    
    
    NSMutableArray * sectionOneArray;
    NSMutableArray * trailerOneArray;
    NSMutableArray * trailerTwoArray;
    NSMutableArray * trailerThreeArray;
    NSMutableArray * trailerFourArray;
    NSMutableArray * powerunitvalue;
    NSMutableArray * powerunitidarray;
    
    
    __weak IBOutlet UIButton *signsubmit;
    NSMutableArray * Trailerarr;
    
    NSMutableArray*trailfinalarr;
    
    
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
    NSString *SelectedDriver;
    
    NSMutableArray*PowerunitArray;
    
}

@end

@implementation DVIRVC
@synthesize driverTwo,driverOne;

- (void)viewDidLoad {
    [super viewDidLoad];
    
   
    
     _mNextDayButton.enabled = false;
    
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
    
    
    datePicker = [[UIDatePicker alloc]init];
    datePicker.datePickerMode=UIDatePickerModeDate;
    [self.mDateTextField setInputView:datePicker];
    UIToolbar *toolBar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 44)];
    [toolBar setTintColor:[UIColor grayColor]];
    UIBarButtonItem *doneBtn = [[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleBordered target:self action:@selector(ShowSelectedDate)];
    UIBarButtonItem *space = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    [toolBar setItems:[NSArray arrayWithObjects:space,doneBtn, nil]];
    [self.mDateTextField setInputAccessoryView:toolBar];
    
    NSDateFormatter *dateformate = [[NSDateFormatter alloc]init];
    [dateformate setDateFormat:@"MMM dd, yyyy"];
    NSString *date_String =[dateformate stringFromDate:[NSDate date]];
    tempDate = [NSDate date];
    self.mDateTextField.text = date_String ;
    
    standerd =[[NSDateFormatter alloc]init];
    [standerd setDateFormat:@"yyyy-MM-dd"];
    NSString *dateString =[standerd stringFromDate:[NSDate date]];
    
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDate *currentDate = [NSDate date];
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    [comps setDay:0];
    NSDate *maxDate = [calendar dateByAddingComponents:comps toDate:currentDate options:0];
    [comps setDay:-7];
    NSDate *minDate = [calendar dateByAddingComponents:comps toDate:currentDate options:0];
    
    [datePicker setMaximumDate:maxDate];
    [datePicker setMinimumDate:minDate];

    
    [self GetData:driverOne.mDriverId date:dateString];
    
    if ([DM.loginType isEqualToString:kLoginTypeSingle]) {
        [self GetData:driverOne.mDriverId date:dateString];
        
        self.mDVIRLogView.hidden = false;
        
    }
    else{
        self.mDVIRLogView.hidden = true;
    }
    
    
  
    
}

-(void)viewWillAppear:(BOOL)animated{
    
//    self.mDriverOneButton.selected = YES ;
//    self.mDriverTwoButton.selected = NO ;
    
  
        
      
    
 

    
    driverId = driverOne.mDriverId;
    
    self.mConditionsCheckMarkButton.selected = !self.mConditionsCheckMarkButton.selected;
    if (self.mConditionsCheckMarkButton.selected == false) {
        NSLog(@"heelo");
        
        
        
        
        
        if (sectionOneArray.count == 0 && trailerOneArray.count == 0 && trailerTwoArray.count == 0 && trailerThreeArray.count == 0)
        {
            
            [self.mConditionsCheckMarkButton setImage:[UIImage imageNamed:@"check_icon"] forState:UIControlStateNormal];
            
        }
        else{
            
            [self.mConditionsCheckMarkButton setImage:[UIImage imageNamed:@"unCheck_icon"] forState:UIControlStateNormal];
            
        }
        
    }
    
    else {
        
        if (sectionOneArray.count == 0 && trailerOneArray.count == 0 && trailerTwoArray.count == 0 && trailerThreeArray.count == 0)
        {
            
            [self.mConditionsCheckMarkButton setImage:[UIImage imageNamed:@"check_icon"] forState:UIControlStateNormal];
            
        }
        else{
            
            // [self.mConditionsCheckMarkButton setImage:[UIImage imageNamed:@"unCheck_icon"] forState:UIControlStateSelected];
            
            [self.mConditionsCheckMarkButton setImage:[UIImage imageNamed:@"unCheck_icon"] forState:UIControlStateNormal];
            
        }
        
        
    }
    [super viewWillAppear:YES];
}

-(void)ShowSelectedDate
{
    
    NSDateFormatter *formatter=[[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"MMM dd, yyyy"];
  
    NSString *dateString =[standerd stringFromDate:datePicker.date];
 
    [self.mDateTextField resignFirstResponder];
    
    NSDate *today = [NSDate date]; // it will give you current date
    NSComparisonResult result;
    result = [today compare:(datePicker.date)];
    // comparing two dates
    
    tempDate = datePicker.date;
    
          self.mDateTextField.text=[NSString stringWithFormat:@"%@",[formatter stringFromDate:datePicker.date]];
    
         NSLog(@"%@",self.mDateTextField.text);
    
        NSLog(@"newDate is less");
        _mNextDayButton.enabled = true;
    
        [self GetData:driverId date:dateString];
    
    
}




-(IBAction)DriverOneButtonAction:(id)sender
{
    
    //      [self.mDriverOneButton setImage:[UIImage imageNamed:@"selectedDriver"] forState:UIControlStateNormal];
    //
    //    [self.mDriverTwoButton setImage:[UIImage imageNamed:@"unSelectedDriver"] forState:UIControlStateNormal];
    
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
    
    standerd =[[NSDateFormatter alloc]init];
    [standerd setDateFormat:@"yyyy-MM-dd"];
    NSString *dateString =[standerd stringFromDate:[NSDate date]];
    
    [self GetData:driverId date:dateString];
    
    
}


- (IBAction)DriverTwoButtonAction:(id)sender {
    
    //    [self.mDriverTwoButton setImage:[UIImage imageNamed:@"selectedDriver"] forState:UIControlStateNormal];
    //
    //    [self.mDriverOneButton setImage:[UIImage imageNamed:@"unSelectedDriver"] forState:UIControlStateNormal];
    
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
    
    standerd =[[NSDateFormatter alloc]init];
    [standerd setDateFormat:@"yyyy-MM-dd"];
    NSString *dateString =[standerd stringFromDate:[NSDate date]];
    
    [self GetData:driverId date:dateString];
    
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
    
    // NSLog(@"%@",trailfinalarr.count);
    
    if (trailfinalarr.count != 0) {
        return trailfinalarr.count+1;
    }
    else{
        
        return 1;
        
    }
    
    //  return refCount;
    //count of section
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
        
        
        if (indexPath.row <= sectionOneArray.count-1 && sectionOneArray.count !=0) {
            
            NSLog(@"%ld",(long)indexPath.row);
            
            cell.textLabel.text = [sectionOneArray objectAtIndex:indexPath.row];
        }
        else
        {
            cell.textLabel.text = @"";
        }
        
        
        
        
    }else if (indexPath.section == 1 ){
        
        if (indexPath.row <= trailerOneArray.count-1 && sectionOneArray.count !=0) {
            
            NSLog(@"%ld",(long)indexPath.row);
            
            cell.textLabel.text = [trailerOneArray objectAtIndex:indexPath.row];
        }
        else
        {
            cell.textLabel.text = @"";
        }
        
        
        
        
    }else if (indexPath.section == 2){
        
        if (indexPath.row <= trailerTwoArray.count-1 && sectionOneArray.count !=0) {
            
            NSLog(@"%ld",(long)indexPath.row);
            
            cell.textLabel.text = [trailerTwoArray objectAtIndex:indexPath.row];
        }
        
    }else if (indexPath.section == 3){
        
        
        if (indexPath.row <= trailerThreeArray.count-1 && sectionOneArray.count !=0) {
            
            NSLog(@"%ld",(long)indexPath.row);
            
            cell.textLabel.text = [trailerThreeArray objectAtIndex:indexPath.row];
        }
        
        
        
    }else if (indexPath.section == 4){
        
        if (indexPath.row <= trailerFourArray.count-1 && sectionOneArray.count !=0) {
            
            NSLog(@"%ld",(long)indexPath.row);
            
            cell.textLabel.text = [trailerFourArray objectAtIndex:indexPath.row];
        }
        
        
        
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
        
        textFieldTwo.userInteractionEnabled = false;
        
        [container addSubview:textFieldTwo];
        
        if (Trailerarr.count == 0) {
            
        }
        else{
            
            textFieldTwo.text = trailfinalarr[section-1];
        }
        
        
        
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
    if (self.mConditionsCheckMarkButton.selected == false) {
        NSLog(@"heelo");
        
       
        [self.mConditionsCheckMarkButton setImage:[UIImage imageNamed:@"unCheck_icon"] forState:UIControlStateNormal];
        
    }
    else{
        
        
         [self.mConditionsCheckMarkButton setImage:[UIImage imageNamed:@"check_icon"] forState:UIControlStateNormal];
        
        if (sectionOneArray.count == 0) {
            
        }
        else{
            [sectionOneArray removeAllObjects];
        }
        
        if (trailerOneArray.count == 0) {
            
        }
        else{
            [trailerOneArray removeAllObjects];
        }
        
        if (trailerTwoArray.count == 0) {
            
        }
        else{
            [trailerTwoArray removeAllObjects];
        }
        
        if (trailerThreeArray.count == 0) {
            
        }
        else{
            [trailerThreeArray removeAllObjects];
        }
    
       
        
        [self.mTableView reloadData];
        
    }
}

- (IBAction)SignAndSubmitButtonTap:(id)sender {
    
    if (self.remarksTextView1.text.length < 5 ) {
        [Helper ISAlertTypeWarning:@"" andMessage:@"Please Add Remarks"];
        return ;
    }
    else if ( [_mVehicleTextField.text isEqualToString:@""])
    {
        
        [Helper ISAlertTypeError:@"Error" andMessage:@"Please Add Vehicle Number"];
        
    }
    else{
        
        [self SubmitButtonAction];
    }
    
    //    if (![_mConditionsCheckMarkButton isSelected]) {
    //        [Helper ISAlertTypeError:@"Error" andMessage:@"Please Accept Conditions"];
    //        return ;
    //    }
    //    self.mSignaturePopUpView.hidden = NO ;
    //    CGRect frame = CGRectMake(8, 27, 257, 257);
    //    id view = [[SignatureView alloc] initWithFrame:frame];
    //    [self.mPopUPVIew addSubview:view];
    //    self.signatureView = view;
    
    
    
    
}

- (IBAction)PreviousDayTap:(id)sender {
    
    NSDate *now;
    if (tempDate == nil) {
        now = [NSDate date];
    }else{
        now = tempDate;
    }
    
    
    
    NSDate *today = [NSDate date]; // it will give you current date
    NSComparisonResult result;
    today = [today dateByAddingTimeInterval:-6*(24*60*60)];
    
    result = [tempDate compare:(today)];
    // comparing two dates
    if(result == NSOrderedAscending)
    {
        
        NSLog(@"today is less");
        _mPreviousDayButton.enabled = false;
        
    }
    else if(result == NSOrderedDescending)
    {
        
        NSLog(@"newDate is less");
        _mPreviousDayButton.enabled = true;
        
    }
    else if (result == NSOrderedSame)
    {
        
        _mPreviousDayButton.enabled = false;
        NSLog(@"Both dates are same");
        
    }
    
    _mNextDayButton.enabled = true;
    NSDate *sevenDaysAgo = [now dateByAddingTimeInterval:-1*24*60*60];
    
    tempDate = sevenDaysAgo;
    
    NSDateFormatter *dateformate = [[NSDateFormatter alloc]init];
    [dateformate setDateFormat:@"MMM dd, yyyy"];
    
     NSString *date_String2 = [dateformate stringFromDate:sevenDaysAgo];
    
      self.mDateTextField.text = date_String2 ;
    
    NSString *dateString = [standerd stringFromDate:sevenDaysAgo];
     // [self checkconditionMethod];
    
    [self GetData:driverId date:dateString];
    
}

- (IBAction)NextDayTap:(id)sender {
    
    
    NSDate *now;
    if (tempDate == nil) {
        now = [NSDate date];
    }else{
        now = tempDate;
    }
    
    _mPreviousDayButton.enabled = true;
    
    NSDate *sevenDaysAgo = [now dateByAddingTimeInterval:+1*24*60*60];
    NSDateFormatter *dateformate=[[NSDateFormatter alloc]init];
    [dateformate setDateFormat:@"MMM dd, yyyy"];
    
   tempDate = [tempDate dateByAddingTimeInterval:+2*(24*60*60)];
    
    NSDate *today = [NSDate date]; // it will give you current date
    NSComparisonResult result;
    result = [today compare:(tempDate)];
    
    // comparing two dates
    
    if(result == NSOrderedAscending)
    {
        NSLog(@"today is less");
        
        _mNextDayButton.enabled = false;
        
    }
    else if(result == NSOrderedDescending)
    {
        
        NSLog(@"newDate is less");
        _mNextDayButton.enabled = true;
        
    }
    else if (result == NSOrderedSame)
    {
        
        _mNextDayButton.enabled = false;
        NSLog(@"Both dates are same");
        
    }
    tempDate = sevenDaysAgo;
    NSString *date_String =[dateformate stringFromDate:sevenDaysAgo];
    self.mDateTextField.text = date_String ;
    NSString *dateString =[standerd stringFromDate:sevenDaysAgo];
    
     // [self checkconditionMethod];
    [self GetData:driverId date:dateString];
    
}



-(void)SubmitButtonAction{
    
    [Helper showLoaderVProgressHUD];
    NSString * path = [NSString stringWithFormat:@"%@dvirForm",kServiceBaseURL];
    
    
    NSDateFormatter *dateformate=[[NSDateFormatter alloc]init];
    [dateformate setDateFormat:@"yyyy-MM-dd"];
    NSString *date_String = [dateformate stringFromDate:tempDate];
    
    NSMutableDictionary * dict = [[NSMutableDictionary alloc]init];
    NSMutableDictionary * logsDict = [[NSMutableDictionary alloc]init];
    
   
    
    if (sectionOneArray.count > 0) {
        
        
        
        [logsDict setObject:[sectionOneArray componentsJoinedByString:@","] forKey:@"Truck"];
        
    }
    else{
        
        [logsDict setObject:@"" forKey:@"Truck"];
    }
    
    
    
    
     if (trailerThreeArray.count > 0)
    
  {
        
        [logsDict setObject:[trailerThreeArray componentsJoinedByString:@","] forKey:@"Trailer2"];
        
    }
     else{
         
           [logsDict setObject:@"" forKey:@"Trailer2"];
     }
    
    if (trailerTwoArray.count > 0) {
        
        [logsDict setObject:[trailerTwoArray componentsJoinedByString:@","] forKey:@"Trailer1"];
        
    }
    
    else{
        
        [logsDict setObject:@"" forKey:@"Trailer1"];
    }
    
    if (trailerOneArray.count > 0) {
        
        
        [logsDict setObject:[trailerOneArray componentsJoinedByString:@","] forKey:@"Trailer0"];
        
    }
    else{
        
        [logsDict setObject:@"" forKey:@"Trailer0"];
    }
    
    
 
    
    
    if (sectionOneArray.count > 0 || trailerOneArray.count > 0  || trailerTwoArray.count > 0 || trailerThreeArray.count > 0   || trailerFourArray.count > 0) {
        
        driverIssue_send = @"true";
        
    }
    else {
        
        driverIssue_send = @"false";
        
    }
    
    
    [dict setValue:date_String forKey:@"created_date"];
    [dict setValue:[NSString stringWithFormat:@"%@",self.remarksTextView1.text] forKey:@"comments"];
    [dict setValue:[[Helper mCurrentUser:kCurrentUserOne]valueForKey:kDriverId] forKey:@"driver_id"];
    [dict setValue:[NSString stringWithFormat:@"%@",logsDict] forKey:@"logs"];
    [dict setValue:[NSString stringWithFormat:@"%@",Strpowerid] forKey:@"power_unit_number"];
    [dict setValue:[NSString stringWithFormat:@"%@",driverIssue_send] forKey:@"dvir_issues"];
    
    // [dict setValue:[Helper base64EncodedStringFromImage:signatureImage] forKey:@"signature"];
    
    
    [DM PostRequest:path parameter:dict onCompletion:^(id  _Nullable dict) {
        
        NSError *errorJson=nil;
        NSString *myStrinag = [[NSString alloc] initWithData:dict encoding:NSUTF8StringEncoding];
        NSLog(@"%@",myStrinag);
        
        NSDictionary*responseDict = [NSJSONSerialization JSONObjectWithData:dict options:kNilOptions error:&errorJson];
        NSLog(@"%@",responseDict);
        
        NSNumber*authFlag = [responseDict valueForKey:@"status"];
        
        if([authFlag boolValue]) {
            
            
            signsubmit.hidden = true;
            
        } else {
            
            signsubmit.hidden = false;
            
        }
        
        
        
        
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
    
    Trailerarr = [[NSMutableArray alloc]init];
    
    powerunitvalue = [[NSMutableArray alloc]init];
    powerunitidarray = [[NSMutableArray alloc]init];
    
    
    NSString * path = [NSString stringWithFormat:@"%@getDvirForm",kServiceBaseURL];
    
    NSMutableDictionary * parameter = [[NSMutableDictionary alloc]init];
    [parameter setValue:driverId forKey:@"driverid"];
    [parameter setValue:date forKey:@"date"];
    
    if ([_mVehicleTextField.text isEqualToString:@""]) {
        
    }
    else {
        
        
        
        [parameter setValue:lat forKey:@"power_unit_number"];
    }
    NSString*latlong = [NSString stringWithFormat:@"%@,%@",lat,Long];
    
    [parameter setValue:latlong forKey:@"lat_long"];
    
    [DM PostRequest:path parameter:parameter onCompletion:^(id  _Nullable dict) {
        
        NSError *errorJson=nil;
        NSDictionary* responseDict = [NSJSONSerialization JSONObjectWithData:dict options:kNilOptions error:&errorJson];
        
        NSLog(@"%@",responseDict);
        
        PowerunitArray = [responseDict valueForKey:@"powerUnit"];
        
        if (PowerunitArray.count == 0) {
            
            _mVehicleTextField.text = @"";
            
        }
        else {
            
            for (int i = 0; i<=PowerunitArray.count-1; i++) {
                
                NSLog(@"%@",PowerunitArray);
                NSLog(@"%d",PowerunitArray.count);
                
                NSString*str = [PowerunitArray[i]valueForKey:@"power_unit"];
                
                NSString*str2 = [PowerunitArray[i]valueForKey:@"id"];
                
                NSLog(@"%@",str);
                
                [powerunitvalue addObject: str];
                
                [powerunitidarray addObject: str2];
                
                if ([chkunitstr isEqualToString:@"a"]) {
                    
                }
                else{
                    
                _mVehicleTextField.text = powerunitvalue[0];
                    
                }
                
               
                
                
                
            }
            
        }
        
        
        
        if (powerunitvalue.count != 0) {
            
            // _mVehicleTextField.text = powerunitvalue[0];
            
        }
        
        else {
            
            
        }
        
        NSNumber *authFlag = [responseDict valueForKey:@"status"];
        
        driverIssue_get = [responseDict valueForKey:@"dvir_issues"];
        
        NSLog(@"%@",driverIssue_get);
        
        logdictarray = [[NSDictionary alloc]init];
        
        if ([driverIssue_get boolValue]) {
            
            
            logdictarray = [responseDict valueForKey:@"logs"];
            
            NSLog(@"%@",logdictarray);
            
            
            [self.mConditionsCheckMarkButton setImage:[UIImage imageNamed:@"unCheck_icon"] forState:UIControlStateNormal];
            
            
        }
        else{
            
            [self.mConditionsCheckMarkButton setImage:[UIImage imageNamed:@"check_icon"] forState:UIControlStateNormal];
            
            if (sectionOneArray.count == 0) {
                
            }
            else {
                //  [sectionOneArray removeAllObjects];
                
                sectionOneArray = [[NSMutableArray alloc]init];
                
                
                
            }
            if (trailerOneArray.count == 0) {
                
            }
            else {
                // [trailerOneArray removeAllObjects];
                trailerOneArray = [[NSMutableArray alloc]init];
                
            }
            if (trailerTwoArray.count == 0) {
                
            }
            else {
                // [trailerTwoArray removeAllObjects];
                
                trailerTwoArray = [[NSMutableArray alloc]init];
                
            }
            if (trailerThreeArray.count == 0) {
                
            }
            else {
                //  [trailerThreeArray removeAllObjects];
                trailerThreeArray = [[NSMutableArray alloc]init];
                
            }
            if (trailerFourArray.count == 0) {
                
            }
            else {
                //  [trailerFourArray removeAllObjects];
                trailerFourArray = [[NSMutableArray alloc]init];
                
            }
            
            
         
            [self.mTableView reloadData];
            
        }
        
        if([authFlag boolValue]) {
            
            signsubmit.hidden = true;
            
            self.mConditionsCheckMarkButton.enabled = false;
            
            
            NSString*comment = [responseDict valueForKey:@"comments"];
            
            self.remarksTextView1.text = comment;
            
            
            
        } else {
            
            signsubmit.hidden = false;
            
            self.mConditionsCheckMarkButton.enabled = true;
            
        }
        
        NSString*Trailer1 = [responseDict valueForKey:@"trailer_number"];
        NSString*Trailer2 = [responseDict valueForKey:@"trailer_number2"];
        NSString*Trailer3 = [responseDict valueForKey:@"trailer_number3"];
        
        if ([Trailer1 isEqualToString:@""]) {
            
        }
        else{
            
            [Trailerarr addObject:Trailer1];
            
        }
        
        if ([Trailer2 isEqualToString:@""]) {
            
            
        }
        else{
            
            
            [Trailerarr addObject:Trailer2];
            
        }
        
        if ([Trailer3 isEqualToString:@""]) {
            
        }
        else{
            
            [Trailerarr addObject:Trailer3];
        }
        
        trailfinalarr = [[NSMutableArray alloc]init];
        
        for(NSString *str in Trailerarr)
        {
            
            if(![trailfinalarr containsObject:str])
            {
                
                [trailfinalarr addObject:str];
                
            }
        }
        
        NSLog(@"%d",trailfinalarr.count);
        
        [self.mTableView reloadData];
        
        NSLog(@"%@",Trailerarr);
        NSLog(@"%@",Trailer2);
        NSLog(@"%@",Trailer3);
        
        PowerunitArray = [responseDict valueForKey:@"powerUnit"];
        
        NSLog(@"%@",PowerunitArray);
        
        if ([[responseDict valueForKey:@"status"] integerValue] == 0) {
            NSString *ErrorString = [NSString stringWithFormat:@"%@",[responseDict valueForKey:@"message"]];
            //  [Helper ISAlertTypeError:@"Error!!" andMessage:ErrorString];
            
           
            
        }
        else{
            NSLog(@"%@",responseDict);
            NSMutableDictionary * dict = [[NSMutableDictionary alloc]init];
            dict = [responseDict valueForKey:@"logs"];
            if ([dict valueForKey:@"Truck"]) {
                sectionOneArray = [[NSMutableArray alloc]init];
                sectionOneArray = [dict valueForKey:@"Truck"];
            }
            else
            {
               sectionOneArray = [[NSMutableArray alloc]init];
            }
            if ([dict valueForKey:@"Trailer0"]) {
                trailerOneArray = [[NSMutableArray alloc]init];
                trailerOneArray = [dict valueForKey:@"Trailer0"];
                
            }
            else
            {
                trailerOneArray = [[NSMutableArray alloc]init];
            }
            if ([dict valueForKey:@"Trailer1"]) {
                trailerTwoArray = [[NSMutableArray alloc]init];
                trailerTwoArray = [dict valueForKey:@"Trailer1"];
                
            }
            
            else
            {
                trailerTwoArray = [[NSMutableArray alloc]init];
            }
            if ([dict valueForKey:@"Trailer2"]) {
                trailerThreeArray = [[NSMutableArray alloc]init];
                trailerThreeArray = [dict valueForKey:@"Trailer2"];
                
            }
            else
            {
                 trailerThreeArray = [[NSMutableArray alloc]init];
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
        
    }
    else{
        
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
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    
    
    
    if (textField ==  _mVehicleTextField) {
        
        [_mVehicleTextField resignFirstResponder];
        
        //  PowerunitArray = [[NSMutableArray alloc] initWithObjects: @"city2", @"city3", @"city4", @"city5", @"city6", @"city16", nil];
        
        
        UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"Title Here"
                                                                 delegate:self
                                                        cancelButtonTitle:nil
                                                   destructiveButtonTitle:nil
                                                        otherButtonTitles:nil];
        
        powerunitvalue = [[NSMutableArray alloc]init];
        
        powerunitidarray = [[NSMutableArray alloc]init];
        
        if (PowerunitArray.count == 0) {
            
        }
        else {
            
            for (int i = 0; i<=PowerunitArray.count-1; i++) {
                
                NSString*str = [PowerunitArray[i]valueForKey:@"power_unit"];
                NSString*str2 = [PowerunitArray[i]valueForKey:@"id"];
                
                NSLog(@"%@",str);
                
                [powerunitvalue addObject: str];
                [powerunitidarray addObject: str2];
                
                
                [actionSheet addButtonWithTitle:str];
                
            }
            
            
        }
        
        
        [actionSheet addButtonWithTitle:@"Cancel"];
        
        [actionSheet showInView:self.view];
        
    }
    else{
        
    }
    
}

-(void) actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    if (buttonIndex == powerunitvalue.count) {
        
        _mVehicleTextField.text = @"";
        
    }
    else{
        
//        standerd =[[NSDateFormatter alloc]init];
//        [standerd setDateFormat:@"yyyy-MM-dd"];
//        NSString *dateString =[standerd stringFromDate:[NSDate date]];
        
        
        chkunitstr = @"a";
        
        _mVehicleTextField.text = powerunitvalue[buttonIndex];
        
        
        Strpowerid = powerunitidarray[buttonIndex];
        
        NSLog(@"%@",Strpowerid);
        
        NSLog(@"%@",tempDate);
        
        NSDateFormatter *dateformate=[[NSDateFormatter alloc]init];
        [dateformate setDateFormat:@"dd-MM-yyyy"];
        
         NSString *date_String = [dateformate stringFromDate:tempDate];
        
        NSString *dateString =[standerd stringFromDate:tempDate];
        
          NSLog(@"%@",dateString);
        
        [self GetData:driverId date:dateString];
        
        
        
    }
    
}

-(void)checkconditionMethod{
    
    
    self.mConditionsCheckMarkButton.selected = !self.mConditionsCheckMarkButton.selected;
    if (self.mConditionsCheckMarkButton.selected == false) {
        NSLog(@"heelo");
        
        
        if (sectionOneArray.count == 0 && trailerOneArray.count == 0 && trailerTwoArray.count == 0 && trailerThreeArray.count == 0)
        {
            
            [self.mConditionsCheckMarkButton setImage:[UIImage imageNamed:@"check_icon"] forState:UIControlStateNormal];
            
        }
        else{
            
            [self.mConditionsCheckMarkButton setImage:[UIImage imageNamed:@"unCheck_icon"] forState:UIControlStateNormal];
            
        }
        
    }
    
    else {
        
        if (sectionOneArray.count == 0 && trailerOneArray.count == 0 && trailerTwoArray.count == 0 && trailerThreeArray.count == 0)
        {
            
            [self.mConditionsCheckMarkButton setImage:[UIImage imageNamed:@"check_icon"] forState:UIControlStateNormal];
            
        }
        else{
            
            // [self.mConditionsCheckMarkButton setImage:[UIImage imageNamed:@"unCheck_icon"] forState:UIControlStateSelected];
            
            [self.mConditionsCheckMarkButton setImage:[UIImage imageNamed:@"unCheck_icon"] forState:UIControlStateNormal];
            
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
