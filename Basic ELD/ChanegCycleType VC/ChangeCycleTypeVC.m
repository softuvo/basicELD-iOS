//
//  ChangeCycleTypeVC.m
//  Basic ELD
//
//  Created by Manoj Gadamsetty on 18/09/17.
//  Copyright © 2017 Gaurav Verma. All rights reserved.
//

#import "ChangeCycleTypeVC.h"

@interface ChangeCycleTypeVC (){
    // Not Used
    NSMutableArray * TitalArray ;
    NSMutableArray * cycleRule ;
    NSMutableArray * cargoType ;
    NSMutableArray * restartType ;
    NSMutableArray * wellSiteType ;
    NSMutableArray * shortHaulType ;
    
    NSString * cycleRuleSelected ;
    NSString * cargoTypeSelected ;
    // Not Used

    
    
    
    NSString *mCycleRuleSelectedID;
    
    NSString *mCycleRuleSelected;
    NSString *mCargoTypeSelected;
    NSString *mRestartTypeSelected;
    NSString *mCwellSiteTypeSelected;
    NSString *mShortHaulTypeSelected;
    NSString *mFarmSchoolBusExceptioneSelected;
    NSString *mRestBreakSelected;

    NSMutableDictionary*Selecteddct;
    
  
    
}

@end

@implementation ChangeCycleTypeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    Selecteddct = [[NSMutableDictionary alloc] init];

    [self HideAllView];
    self.mContentView.frame = kContentViewframe2;

    [self.mScrollView layoutIfNeeded];
    self.mScrollView.contentSize = self.mContentView.bounds.size;


    TitalArray = [[NSMutableArray alloc]initWithObjects:@"Cycle",@"Options", nil];
    cycleRule = [[NSMutableArray alloc]initWithObjects:@"USA 70 hours /8 days",@"USA 60 hours /7 days",@"California 80 hours /8 days",@"Texas 70 hours / 7 days",@"Alaska 70 hours /7 days",@"Alaska 80 hours /8 days",@"Canada South 70 hours / 7 days",@"Canada South 120 hours / 14 days",@"Canada South Oil &amp; Gas",@"Canada North 80 hours / 7 days",@"Canada North 120 hours /  14 days",@"Others", nil];
    cargoType = [[NSMutableArray alloc]initWithObjects:@"Property",@"Passenger",@"Oil And Gas", nil];
    restartType = [[NSMutableArray alloc]initWithObjects:@"34 Hour Restart",@"24 Hour Restart",nil];
    wellSiteType = [[NSMutableArray alloc]initWithObjects:@"Waiting Time on 5th Line",@"No Waiting Time Exception",nil];
    shortHaulType = [[NSMutableArray alloc]initWithObjects:@"No Exception",@"16 Hour Short Exception",nil];
    // Do any additional setup after loading the view.
    
    
    NSLog(@"%@",self.mWebCycleRuleSelectedID);
    NSLog(@"%@",self.mWebCycleRuleSelected);
    NSLog(@"%@",self.mWebCargoTypeSelected);
    NSLog(@"%@",self.mWebRestartTypeSelected);
    NSLog(@"%@",self.mWebCwellSiteTypeSelected);
    NSLog(@"%@",self.mWebFarmSchoolBusExceptioneSelected);
    NSLog(@"%@",self.mWebShortHaulTypeSelected);
    NSLog(@"%@",self.mWebRestBreakSelected);

    
    mCycleRuleSelectedID = self.mWebCycleRuleSelectedID;
  
#pragma mark############################mCycleRuleSelected#################################
    if (self.mWebCycleRuleSelected == nil || [self.mWebCycleRuleSelected isKindOfClass:[NSNull class]]) {
        mCycleRuleSelected =  kCycleRuleOne;

    }
    else{
        mCycleRuleSelected =  self.mWebCycleRuleSelected;

    }
    [self CycleRuleAction];

#pragma mark############################mCargoTypeSelected#################################

    if (self.mWebCargoTypeSelected == nil || [self.mWebCargoTypeSelected isKindOfClass:[NSNull class]]) {
        mCargoTypeSelected = @"";
    }
    else{
        mCargoTypeSelected =  self.mWebCargoTypeSelected;
        [self CargoTypeAction];

    }
    
#pragma mark############################mRestartTypeSelected#################################
    
    if (self.mWebRestartTypeSelected == nil || [self.mWebRestartTypeSelected isKindOfClass:[NSNull class]]) {
        mRestartTypeSelected = @"";
    }
    else{
        mRestartTypeSelected =  self.mWebRestartTypeSelected;
        
    }
    
#pragma mark############################mCwellSiteTypeSelected#################################
    
    if (self.mWebCwellSiteTypeSelected == nil || [self.mWebCwellSiteTypeSelected isKindOfClass:[NSNull class]]) {
        mCwellSiteTypeSelected = @"";
    }
    else{
        mCwellSiteTypeSelected =  self.mWebCwellSiteTypeSelected;
        
    }
    
#pragma mark############################mShortHaulTypeSelected#################################
    
    if (self.mWebShortHaulTypeSelected == nil || [self.mWebShortHaulTypeSelected isKindOfClass:[NSNull class]]) {
        mShortHaulTypeSelected = @"";
    }
    else{
        mShortHaulTypeSelected =  self.mWebShortHaulTypeSelected;
        
    }
    
#pragma mark######################mFarmSchoolBusExceptioneSelected##############################
    
    if (self.mWebFarmSchoolBusExceptioneSelected == nil || [self.mWebFarmSchoolBusExceptioneSelected isKindOfClass:[NSNull class]]) {
        mFarmSchoolBusExceptioneSelected = @"";
    }
    else{
        mFarmSchoolBusExceptioneSelected =  self.mWebFarmSchoolBusExceptioneSelected;
        
    }
#pragma mark############################mRestBreakSelected#################################
    
    if (self.mWebRestBreakSelected == nil || [self.mWebRestBreakSelected isKindOfClass:[NSNull class]]) {
        mRestBreakSelected = @"";
    }
    else{
        mRestBreakSelected =  self.mWebRestBreakSelected;
        
    }
    
    
    

    
    /*
    mCycleRuleSelectedID = kCycleRuleOneID;
    mCycleRuleSelected =  kCycleRuleOne;
    [self CycleRuleAction];
    mCargoTypeSelected =  @"Property";

    [self CargoTypeAction];
    
    mRestartTypeSelected =  @"";
    mCwellSiteTypeSelected =  @"";
    mShortHaulTypeSelected =  @"";
    mFarmSchoolBusExceptioneSelected = @"";
    mRestBreakSelected= @"";
     */

}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    

}
-(void)HideAllView{
    self.mCargoTypeView.hidden = true;
    self.mRestartTypeView.hidden = true;
    self.mCwellSiteTypeView.hidden = true;
    self.mShortHaulTypeView.hidden = true;
    self.mFarmSchoolBusExceptionTypeView.hidden = true;
    self.mRestBreakView.hidden = true;
    self.mOptionView.hidden = false;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSString *sectionName;
    sectionName = [NSString stringWithFormat: @"%@", [TitalArray objectAtIndex:section]];
    return sectionName;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *HeaderView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 25)];
    [HeaderView setBackgroundColor: [UIColor clearColor]];
    UILabel *LblObj=[[UILabel alloc]initWithFrame:CGRectMake(0, 3, 300, 24)];
    LblObj.text = [TitalArray objectAtIndex:section];
    LblObj.textColor = [UIColor whiteColor];
    LblObj.backgroundColor = [UIColor clearColor];
    LblObj.font =[UIFont fontWithName:@"Roboto-Bold" size:15.0];
    [HeaderView addSubview:LblObj];
    return HeaderView;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
     if ([cycleRuleSelected isEqualToString:[cycleRule objectAtIndex:0]] && [cargoTypeSelected isEqualToString:[cargoType objectAtIndex:0]]){
        return 2 ;
     }
     else if([cycleRuleSelected isEqualToString:[cycleRule objectAtIndex:0]] && [cargoTypeSelected isEqualToString:[cargoType objectAtIndex:1]]){
         return 2 ;
     }
     else if([cycleRuleSelected isEqualToString:[cycleRule objectAtIndex:0]]){
        return 1 ;
     }
    
    
    
    return TitalArray.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    if([cycleRuleSelected isEqualToString:[cycleRule objectAtIndex:0]]){
        if([cycleRuleSelected isEqualToString:[cycleRule objectAtIndex:0]] && [cargoTypeSelected isEqualToString:[cargoType objectAtIndex:1]]){
            return 1 ;
        }
        if (section == 0) {
            return 2 ;
        }
        if (section == 1) {
            return 4 ;
        }
    }
    
    
    
    
    
    
    return 1 ;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}

 

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"CycleTableCell";
    CycleTableCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    NSArray * xibReff = [[NSBundle mainBundle]loadNibNamed:@"CycleTableCell" owner:self options:nil];
    if (cell == nil) {
        cell = [xibReff objectAtIndex:0];
    }
    
    cell.mTitleLabel.text = @"" ;
    cell.mTextField.tag = indexPath.row ;
    cell.mTextField.delegate = self ;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;{
    
}


*/


- (IBAction)BackButtonAction:(id)sender{
    
    
    [Selecteddct setObject:mCycleRuleSelectedID forKey:@"cycle_type_id"];
    [Selecteddct setObject:mCycleRuleSelected forKey:@"cycle_type"];
    [Selecteddct setObject:mCargoTypeSelected forKey:@"cargo_type"];
    [Selecteddct setObject:mRestartTypeSelected forKey:@"restart"];
    [Selecteddct setObject:mRestBreakSelected forKey:@"rest_break"];
    [Selecteddct setObject:mShortHaulTypeSelected forKey:@"short_hand_exception"];
    [Selecteddct setObject:mCwellSiteTypeSelected forKey:@"well_site"];
    [Selecteddct setObject:mFarmSchoolBusExceptioneSelected forKey:@"farm_school_exception"];


    [[NSNotificationCenter defaultCenter] postNotificationName:kNOTIFICATION_UpdateCycleRules object:nil userInfo:Selecteddct];
    

    [self.navigationController popViewControllerAnimated:YES];
    
}





- (IBAction)CycleRuleActionSheetButtonPressed:(id)sender {
    
    UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:nil message:@"Cycle Rule" preferredStyle:UIAlertControllerStyleActionSheet];
    
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        // Cancel button tappped do nothing.
    }]];
    
#pragma mark #1 USA 70 hours /8 days
    [actionSheet addAction:[UIAlertAction actionWithTitle:kCycleRuleOne style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        NSLog(@"USA 70 hours /8 days");
        
        mCycleRuleSelectedID = kCycleRuleOneID;
        mCycleRuleSelected = kCycleRuleOne;
        
        [self CycleRuleAction];

        
    }]];
#pragma mark #2 USA 60 hours /7 days
    [actionSheet addAction:[UIAlertAction actionWithTitle:kCycleRuleTwo style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        NSLog(@"USA 60 hours /7 days");
        
        mCycleRuleSelected =  kCycleRuleTwo;
        mCycleRuleSelectedID = kCycleRuleTwoID;
        [self CycleRuleAction];
        
        
    }]];
#pragma mark #3 California 80 hours /8 days
    [actionSheet addAction:[UIAlertAction actionWithTitle:kCycleRuleThree style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        NSLog(@"California 80 hours /8 days");
        mCycleRuleSelected =  kCycleRuleThree;
        mCycleRuleSelectedID = kCycleRuleThreeID;

        [self CycleRuleAction];
        
        
    }]];
#pragma mark #4 Texas 70 hours /7 days
    [actionSheet addAction:[UIAlertAction actionWithTitle:kCycleRuleFour style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        NSLog(@"Texas 70 hours / 7 days");
        mCycleRuleSelected =  kCycleRuleFour;
        mCycleRuleSelectedID = kCycleRuleFourID;

        [self CycleRuleAction];
        
        
    }]];
#pragma mark #5 Alaska 70 hours /7 days
    [actionSheet addAction:[UIAlertAction actionWithTitle:kCycleRuleFive style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        NSLog(@"Alaska 70 hours /7 days");
        mCycleRuleSelected =  kCycleRuleFive;
        mCycleRuleSelectedID = kCycleRuleFiveID;

        [self CycleRuleAction];
        
        
    }]];
#pragma mark #6 Alaska 80 hours /8 days
    [actionSheet addAction:[UIAlertAction actionWithTitle:kCycleRuleSix style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        NSLog(@"Alaska 80 hours /8 days");
        mCycleRuleSelected =  kCycleRuleSix;
        mCycleRuleSelectedID = kCycleRuleSixID;

        [self CycleRuleAction];
        
        
    }]];
#pragma mark #7 Canada South 70 hours /7 days
    [actionSheet addAction:[UIAlertAction actionWithTitle:kCycleRuleSeven style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        NSLog(@"Canada South 70 hours / 7 days");
        mCycleRuleSelected =  kCycleRuleSeven;
        mCycleRuleSelectedID = kCycleRuleSevenID;

        [self CycleRuleAction];
        
        
    }]];
#pragma mark #8 Canada South 120 hours /14 days
    [actionSheet addAction:[UIAlertAction actionWithTitle:kCycleRuleEight style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        NSLog(@"Canada South 120 hours / 14 days");
        mCycleRuleSelected =  kCycleRuleEight;
        mCycleRuleSelectedID = kCycleRuleEightID;

        [self CycleRuleAction];
        
        
    }]];
#pragma mark #9 Canada South Oil & amp Gas
    [actionSheet addAction:[UIAlertAction actionWithTitle:kCycleRuleNine style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        NSLog(@"Canada South Oil and Gas");
        mCycleRuleSelected =  kCycleRuleNine;
        mCycleRuleSelectedID = kCycleRuleNineID;

        [self CycleRuleAction];
        
        
    }]];
#pragma mark #10 Canada North 80 hours /7 days
    [actionSheet addAction:[UIAlertAction actionWithTitle:kCycleRuleTen style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        NSLog(@"Canada North 80 hours / 7 days");
        mCycleRuleSelected =  kCycleRuleTen;
        mCycleRuleSelectedID = kCycleRuleTenID;

        [self CycleRuleAction];
        
        
    }]];
#pragma mark #11 Canada North 120 hours /14 days
    [actionSheet addAction:[UIAlertAction actionWithTitle:kCycleRuleElaven style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        NSLog(@"Canada North 120 hours /  14 days");
        mCycleRuleSelected =  kCycleRuleElaven;
        mCycleRuleSelectedID = kCycleRuleElavenID;

        [self CycleRuleAction];
        
        
        
    }]];
       /*
#pragma mark #12 Others
    [actionSheet addAction:[UIAlertAction actionWithTitle:kCycleRuleTwelav style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        NSLog(@"Others");
        mCycleRuleSelected =  kCycleRuleTwelav;
        mCycleRuleSelectedID = kCycleRuleTwelavID;

        [self CycleRuleAction];
        
        
    }]];
 
#pragma mark #12
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"Others" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
        // Distructive Others button tapped.
    }]];
    */
    [self presentViewController:actionSheet animated:YES completion:nil];
    
}

-(void)CycleRuleAction{
    self.mCycleRuleTextField.text = mCycleRuleSelected;
    [self HideAllView];
    
    if([mCycleRuleSelectedID integerValue] == 1 || [mCycleRuleSelectedID integerValue] == 2){
        mCargoTypeSelected = kCargoTypeProperty;
        mRestartTypeSelected = kRestartType24HourRestart;
        mRestBreakSelected = kRestBreakThirtyMinuteRestBreakRequired;
        mCwellSiteTypeSelected = @"";
        mShortHaulTypeSelected = kShortHaulNoException;
        mFarmSchoolBusExceptioneSelected = @"";
        
        self.mOptionView.frame = kOptionViewframe1;

        
        self.mCargoTypeView.hidden = false;
        
        self.mRestartTypeView.hidden = false;
        self.mRestBreakView.hidden = false;
        self.mShortHaulTypeView.hidden = false;
        

        
        self.mRestartTypeView.frame = kViewFrame1;
        self.mRestBreakView.frame = kViewFrame2;
        self.mShortHaulTypeView.frame = kViewFrame3;


    }
    if([mCycleRuleSelectedID integerValue] == 3 || [mCycleRuleSelectedID integerValue] == 5 || [mCycleRuleSelectedID integerValue] == 6 ){
        mCargoTypeSelected = kCargoTypeProperty;
        mRestartTypeSelected = kRestartType24HourRestart;
        mRestBreakSelected = @"";
        mCwellSiteTypeSelected = @"";
        mShortHaulTypeSelected = @"";
        mFarmSchoolBusExceptioneSelected = @"";
        
        self.mOptionView.frame = kOptionViewframe1;

        
        self.mCargoTypeView.hidden = false;
        self.mRestartTypeView.hidden = false;
        self.mRestartTypeView.frame = kViewFrame1;
        
        
    }
    else if([mCycleRuleSelectedID integerValue] == 4 ){
        mCargoTypeSelected = @"";
        mRestartTypeSelected = kRestartType24HourRestart;
        mRestBreakSelected = @"";
        mCwellSiteTypeSelected = @"";
        mShortHaulTypeSelected = @"";
        mFarmSchoolBusExceptioneSelected = @"";
        
        self.mOptionView.frame = kOptionViewframe2;
        self.mCargoTypeView.hidden = true;
        
        self.mRestartTypeView.hidden = false;
        self.mRestartTypeView.frame = kViewFrame1;
  
    }
    
    
    
    else if([mCycleRuleSelectedID integerValue] == 9){
        mCargoTypeSelected = @"";
        mRestartTypeSelected = @"";
        mRestBreakSelected = @"";
        mCwellSiteTypeSelected = kWellSiteNoWaitingTimeException;
        mShortHaulTypeSelected = @"";
        mFarmSchoolBusExceptioneSelected = @"";
        
        self.mOptionView.frame = kOptionViewframe2;
        self.mCargoTypeView.hidden = true;
        
        self.mCwellSiteTypeView.hidden = false;
        self.mCwellSiteTypeView.frame = kViewFrame1;
        
        
    }
    
    
    else if([mCycleRuleSelectedID integerValue] == 7 || [mCycleRuleSelectedID integerValue] == 8 || [mCycleRuleSelectedID integerValue] == 10 || [mCycleRuleSelectedID integerValue] == 11 || [mCycleRuleSelectedID integerValue] == 12){
        mCargoTypeSelected = @"";
        mRestartTypeSelected = @"";
        mRestBreakSelected = @"";
        mCwellSiteTypeSelected = @"";
        mShortHaulTypeSelected = @"";
        mFarmSchoolBusExceptioneSelected = @"";
        
        self.mOptionView.hidden = true;
    }
    
    
    
    [self CargoTypeAction];
    [self RestartTypeAction];
    [self RestBreakAction];
    [self CwellSiteTypeAction];
    [self ShortHaulTypeAction];
    [self FarmSchoolBusExceptionAction];

    
    
    switch ([mCycleRuleSelectedID integerValue]) {
        case 1:
            NSLog(kCycleRuleOne);
            break;
        case 2:
            NSLog(kCycleRuleTwo);
            break;
        case 3:
            NSLog(kCycleRuleThree);
            break;
        case 4:
            NSLog(kCycleRuleFour);
            break;
        case 5:
            NSLog(kCycleRuleFive);
            break;
        case 6:
            NSLog(kCycleRuleSix);
            break;
        case 7:
            NSLog(kCycleRuleSeven);
            break;
        case 8:
            NSLog(kCycleRuleEight);
            break;
        case 9:
            NSLog(kCycleRuleNine);
            break;
        case 10:
            NSLog(kCycleRuleTen);
            break;
        case 11:
            NSLog(kCycleRuleElaven);
            break;
        case 12:
            NSLog(kCycleRuleTwelav);
            break;

        default:
            break;
    }
    
    
    
    
    
    
}





- (IBAction)CargoTypeActionSheetButtonPressed:(id)sender{
    UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:nil message:@"Cargo Type" preferredStyle:UIAlertControllerStyleActionSheet];
    
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        // Cancel button tappped do nothing.
    }]];
    
#pragma mark #1 Property
    [actionSheet addAction:[UIAlertAction actionWithTitle:kCargoTypeProperty style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        NSLog(@"Property tapped");
        mCargoTypeSelected = kCargoTypeProperty;
        
        [self CargoTypeAction];
        
        
    }]];
#pragma mark #2 Passenger
    [actionSheet addAction:[UIAlertAction actionWithTitle:kCargoTypePassenger style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        NSLog(@"Passenger tapped");
        mCargoTypeSelected =  kCargoTypePassenger;
        
        [self CargoTypeAction];
        

    }]];
#pragma mark #3 Oil And Gas
    [actionSheet addAction:[UIAlertAction actionWithTitle:kCargoTypeOilAndGas style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        NSLog(@"Oil And Gas tapped");
        mCargoTypeSelected =  kCargoTypeOilAndGas;
        
        [self CargoTypeAction];
        

    }]];
    
    
    [self presentViewController:actionSheet animated:YES completion:nil];

}

-(void)CargoTypeAction{
    self.mCargoTypeTextField.text = mCargoTypeSelected;
    [self HideAllView];


    
    if(([mCargoTypeSelected isEqualToString:kCargoTypeProperty] && [mCycleRuleSelectedID integerValue] == 1) || ([mCargoTypeSelected isEqualToString:kCargoTypeProperty] && [mCycleRuleSelectedID integerValue] == 2)) {
    
        mCargoTypeSelected = kCargoTypeProperty;

        mRestartTypeSelected = kRestartType24HourRestart;
        mRestBreakSelected = kRestBreakThirtyMinuteRestBreakRequired;
        mCwellSiteTypeSelected = @"";
        mShortHaulTypeSelected = kShortHaulNoException;
        mFarmSchoolBusExceptioneSelected = @"";
        
        self.mOptionView.frame = kOptionViewframe1;
        
        
        self.mCargoTypeView.hidden = false;

        self.mRestartTypeView.hidden = false;
        self.mRestBreakView.hidden = false;
        self.mShortHaulTypeView.hidden = false;
        self.mOptionView.hidden = false;

        
        
        self.mRestartTypeView.frame = kViewFrame1;
        self.mRestBreakView.frame = kViewFrame2;
        self.mShortHaulTypeView.frame = kViewFrame3;
    
    }
    
    else if(([mCargoTypeSelected isEqualToString:kCargoTypeProperty] && [mCycleRuleSelectedID integerValue] == 3) || ([mCargoTypeSelected isEqualToString:kCargoTypeProperty] && [mCycleRuleSelectedID integerValue] == 5) || ([mCargoTypeSelected isEqualToString:kCargoTypeProperty] && [mCycleRuleSelectedID integerValue] == 6) ){
        
        mCargoTypeSelected = kCargoTypeProperty;
        mRestartTypeSelected = kRestartType24HourRestart;
        mRestBreakSelected = @"";
        mCwellSiteTypeSelected = @"";
        mShortHaulTypeSelected = @"";
        mFarmSchoolBusExceptioneSelected = @"";
        
        self.mOptionView.frame = kOptionViewframe1;
        self.mCargoTypeView.hidden = false;
        self.mOptionView.hidden = false;

        
        self.mRestartTypeView.hidden = false;
        self.mRestartTypeView.frame = kViewFrame1;
        
        
    }
    
    
  
    
    
    else if(([mCargoTypeSelected isEqualToString:kCargoTypePassenger] && [mCycleRuleSelectedID integerValue] == 1) || ([mCargoTypeSelected isEqualToString:kCargoTypePassenger] && [mCycleRuleSelectedID integerValue] == 2) || ([mCargoTypeSelected isEqualToString:kCargoTypePassenger] && [mCycleRuleSelectedID integerValue] == 5 )|| ([mCargoTypeSelected isEqualToString:kCargoTypePassenger] && [mCycleRuleSelectedID integerValue] == 6)){
        
        mCargoTypeSelected = kCargoTypePassenger;

        mRestartTypeSelected = @"";
        mRestBreakSelected = @"";
        mCwellSiteTypeSelected = @"";
        mShortHaulTypeSelected = @"";
        mFarmSchoolBusExceptioneSelected = @"";
       // [self HideAllView];

        self.mOptionView.hidden = true;
        self.mCargoTypeView.hidden = false;

        
        self.mOptionView.frame = kOptionViewframe1;

        

    }
    
    else if([mCargoTypeSelected isEqualToString:kCargoTypePassenger] && [mCycleRuleSelectedID integerValue] == 3  ){
        
        mCargoTypeSelected = kCargoTypePassenger;
        mRestartTypeSelected = @"";
        mRestBreakSelected = @"";
        mCwellSiteTypeSelected = @"";
        mShortHaulTypeSelected = @"";
        mFarmSchoolBusExceptioneSelected = kFarmSchoolBusExceptionNoException;
        
        self.mOptionView.frame = kOptionViewframe1;
        self.mCargoTypeView.hidden = false;
        self.mOptionView.hidden = false;

        
        self.mFarmSchoolBusExceptionTypeView.hidden = false;
        self.mFarmSchoolBusExceptionTypeView.frame = kViewFrame1;
        
        
 }
    
    else if(([mCargoTypeSelected isEqualToString:kCargoTypeOilAndGas] && [mCycleRuleSelectedID integerValue] == 1) || ([mCargoTypeSelected isEqualToString:kCargoTypeOilAndGas] && [mCycleRuleSelectedID integerValue] == 2)) {
        
        mCargoTypeSelected = kCargoTypeOilAndGas;
        
        mRestartTypeSelected = kRestartType24HourRestart;
        mRestBreakSelected = kRestBreakThirtyMinuteRestBreakRequired;
        mCwellSiteTypeSelected = kWellSiteWaitingTimeOnFifthLine;
        mShortHaulTypeSelected = kShortHaulNoException;
        mFarmSchoolBusExceptioneSelected = @"";
        
        self.mOptionView.frame = kOptionViewframe1;
        self.mCargoTypeView.hidden = false;
        self.mOptionView.hidden = false;

        self.mRestartTypeView.hidden = false;
        self.mRestartTypeView.frame = kViewFrame1;
        self.mRestBreakView.hidden = false;
        self.mRestBreakView.frame = kViewFrame2;
        self.mCwellSiteTypeView.hidden = false;
        self.mCwellSiteTypeView.frame = kViewFrame3;
        self.mShortHaulTypeView.hidden = false;
        self.mShortHaulTypeView.frame = kViewFrame4;
    
    }
    
    else if(([mCargoTypeSelected isEqualToString:kCargoTypeOilAndGas] && [mCycleRuleSelectedID integerValue] == 3) || ([mCargoTypeSelected isEqualToString:kCargoTypeOilAndGas] && [mCycleRuleSelectedID integerValue] == 5) || ([mCargoTypeSelected isEqualToString:kCargoTypeOilAndGas] && [mCycleRuleSelectedID integerValue] == 6)) {
        
        
        mCargoTypeSelected = kCargoTypeOilAndGas;
        
        mRestartTypeSelected = kRestartType24HourRestart;
        mRestBreakSelected = @"";
        mCwellSiteTypeSelected = kWellSiteWaitingTimeOnFifthLine;
        mShortHaulTypeSelected = @"";
        mFarmSchoolBusExceptioneSelected = @"";
        
        self.mOptionView.frame = kOptionViewframe1;
        self.mCargoTypeView.hidden = false;
        self.mOptionView.hidden = false;

        self.mRestartTypeView.hidden = false;
        self.mRestartTypeView.frame = kViewFrame1;
        self.mCwellSiteTypeView.hidden = false;
        self.mCwellSiteTypeView.frame = kViewFrame2;
        
    }
    else{
       // [self HideAllView];
        if([mCycleRuleSelectedID integerValue] == 4 ){
            self.mRestartTypeView.hidden = false;
        }
        else if([mCycleRuleSelectedID integerValue] == 9 ){
            self.mCwellSiteTypeView.hidden = false;

        }
        
        
        else if([mCycleRuleSelectedID integerValue] == 7 || [mCycleRuleSelectedID integerValue] == 8 || [mCycleRuleSelectedID integerValue] == 10 || [mCycleRuleSelectedID integerValue] == 11 || [mCycleRuleSelectedID integerValue] == 12){
            self.mOptionView.hidden = true;
            
        }
    }
    
    [self RestartTypeAction];
    [self RestBreakAction];
    [self CwellSiteTypeAction];
    [self ShortHaulTypeAction];
    [self FarmSchoolBusExceptionAction];
    
    
  

}






- (IBAction)RestartTypeActionSheetButtonPressed:(id)sender{
    UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:nil message:@"Restart" preferredStyle:UIAlertControllerStyleActionSheet];
    
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        // Cancel button tappped do nothing.
    }]];
    
#pragma mark #1 34 Hour Restart
    [actionSheet addAction:[UIAlertAction actionWithTitle:kRestartType34HourRestart style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        NSLog(@"34 Hour Restart");
        mRestartTypeSelected = kRestartType34HourRestart;
        
        [self RestartTypeAction];
        
        
    }]];
#pragma mark #2 24 Hour Restart
    [actionSheet addAction:[UIAlertAction actionWithTitle:kRestartType24HourRestart style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        NSLog(@"24 Hour Restart");
        mRestartTypeSelected =  kRestartType24HourRestart;
        
        [self RestartTypeAction];
        
        
    }]];

    
    [self presentViewController:actionSheet animated:YES completion:nil];
    
}

-(void)RestartTypeAction{
    self.mRestartTypeTextField.text = mRestartTypeSelected;

}



- (IBAction)CwellSiteTypeActionSheetButtonPressed:(id)sender{
    UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:nil message:@"Well Site" preferredStyle:UIAlertControllerStyleActionSheet];
    
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        // Cancel button tappped do nothing.
    }]];
    
#pragma mark #1 Waiting Time on 5th Line
    [actionSheet addAction:[UIAlertAction actionWithTitle:kWellSiteWaitingTimeOnFifthLine style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        NSLog(@"Waiting Time on 5th Line");
        mCwellSiteTypeSelected = kWellSiteWaitingTimeOnFifthLine;
        
        [self CwellSiteTypeAction];
        
        
    }]];
#pragma mark #2 No Waiting Time Exception
    [actionSheet addAction:[UIAlertAction actionWithTitle:kWellSiteNoWaitingTimeException style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        NSLog(@"No Waiting Time Exception");
        mCwellSiteTypeSelected =  kWellSiteNoWaitingTimeException;
        
        [self CwellSiteTypeAction];
        
        
    }]];
    
    
    [self presentViewController:actionSheet animated:YES completion:nil];
}

-(void)CwellSiteTypeAction{
    self.mCwellSiteTypeTextField.text = mCwellSiteTypeSelected;

}



- (IBAction)ShortHaulTypeActionSheetButtonPressed:(id)sender{
    UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:nil message:@"Short Hall Exception" preferredStyle:UIAlertControllerStyleActionSheet];
    
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        // Cancel button tappped do nothing.
    }]];
    
#pragma mark #1 No Exception
    [actionSheet addAction:[UIAlertAction actionWithTitle:kShortHaulNoException style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        NSLog(@"No Exception");
        mShortHaulTypeSelected = kShortHaulNoException;
        
        [self ShortHaulTypeAction];
        
        
    }]];
#pragma mark #2 16 Hour Short Exception
    [actionSheet addAction:[UIAlertAction actionWithTitle:kShortHaulSixteenHourShortException style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        NSLog(@"16 Hour Short Exception");
        mShortHaulTypeSelected =  kShortHaulSixteenHourShortException;
        
        [self ShortHaulTypeAction];
        
        
    }]];
    
    
    [self presentViewController:actionSheet animated:YES completion:nil];
}

-(void)ShortHaulTypeAction{
    self.mShortHaulTypeTextField.text = mShortHaulTypeSelected;

}




- (IBAction)FarmSchoolBusExceptionActionSheetButtonPressed:(id)sender{
    UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:nil message:@"Farm/School Bus Exception" preferredStyle:UIAlertControllerStyleActionSheet];
    
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        // Cancel button tappped do nothing.
    }]];
    
#pragma mark #1 No Exception
    [actionSheet addAction:[UIAlertAction actionWithTitle:kFarmSchoolBusExceptionNoException style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        NSLog(@"No Exception");
        mFarmSchoolBusExceptioneSelected = kFarmSchoolBusExceptionNoException;
        
        [self FarmSchoolBusExceptionAction];
        
        
    }]];
#pragma mark #2 16 Hour Short Exception
    [actionSheet addAction:[UIAlertAction actionWithTitle:kFarmSchoolBusExceptionSixteenHourShortException style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        NSLog(@"16 Hour Short Exception");
        mFarmSchoolBusExceptioneSelected =  kFarmSchoolBusExceptionSixteenHourShortException;
        
        [self FarmSchoolBusExceptionAction];
        
        
    }]];
    
    
    [self presentViewController:actionSheet animated:YES completion:nil];
}

-(void)FarmSchoolBusExceptionAction{
    self.mFarmSchoolBusExceptionTextField.text = mFarmSchoolBusExceptioneSelected;
    
}



- (IBAction)RestBreakActionSheetButtonPressed:(id)sender{
    UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:nil message:@"Rest Break" preferredStyle:UIAlertControllerStyleActionSheet];
    
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        // Cancel button tappped do nothing.
    }]];
    
#pragma mark #1 30 Minute Rest Break Required
    [actionSheet addAction:[UIAlertAction actionWithTitle:kRestBreakThirtyMinuteRestBreakRequired style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        NSLog(@"30 Minute Rest Break Required");
        mRestBreakSelected = kRestBreakThirtyMinuteRestBreakRequired;
        
        [self RestBreakAction];
        
        
    }]];
#pragma mark #2 No Rest Break Required
    [actionSheet addAction:[UIAlertAction actionWithTitle:kRestBreakNoRestBreakRequired style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        NSLog(@"No Rest Break Required");
        mRestBreakSelected =  kRestBreakNoRestBreakRequired;
        
        [self RestBreakAction];
        
        
    }]];
    
    
    [self presentViewController:actionSheet animated:YES completion:nil];
}

-(void)RestBreakAction{
    self.mRestBreakTextField.text = mRestBreakSelected;
    
}

@end
