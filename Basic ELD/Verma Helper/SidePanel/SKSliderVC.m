//
//  SKSliderVC.m
//  SHKUN
//
//  Created by Gaurav Verma on 21/12/16.
//  Copyright © 2016 Gaurav Verma. All rights reserved.
//

#import "SKSliderVC.h"
#import "EditLogsVC.h"


@interface SKSliderVC (){
    NSMutableArray *mSliderImageTableArray;
    NSString *mGoOffDuty;
    UIAlertView *LogoutAlrt;
}

@end

@implementation SKSliderVC
@synthesize mSliderTableArray,mSliderTableView,driverOne,driverTwo;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    driverOne = [[SKUser alloc] init];
    [driverOne setupUser:[Helper mCurrentUser:kCurrentUserOne]];
    
    driverTwo = [[SKUser alloc] init];
    [driverTwo setupUser:[Helper mCurrentUser:kCurrentUserTwo]];
    // Do any additional setup after loading the view.
}


-(void)initializeSliderData{
    
    mSliderTableArray = [[NSMutableArray alloc]init];
    mSliderImageTableArray = [[NSMutableArray alloc]init];

    dct = [[NSMutableDictionary alloc] init];
    
    mSliderTableArray  = [[NSMutableArray alloc]initWithObjects:@"Profile",@"Inspect log",@"Docs",@"DVIR"/*,@"Change Cycle Type"*/,@"Share This App",@"Support/Contact us",@"FAQ",@"Terms And Conditions",@"Logout", nil];
    
    mSliderImageTableArray  = [[NSMutableArray alloc]initWithObjects:@"Profile_Icoon",@"inspectLog_icon",@"docs_icon",@"dvir_icon",/*@"changeCycleType_icon",*/@"shareThisApp_icon",@"supportContactUs_icon",@"faq_icon",@"termsAndConditions_icon",@"logOut_icon",nil];
    
    CALayer *imageLayera = self.mLogoImageView.layer;
    [imageLayera setCornerRadius:self.mLogoImageView.frame.size.width/2];
    [imageLayera setBorderColor:[[UIColor whiteColor]CGColor]];
    [imageLayera setBorderWidth:1];
    [imageLayera setMasksToBounds:YES];
    
    [self CurrentUser];
    [mSliderTableView reloadData];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    
    [self initializeSliderData];
    
    NSIndexPath *tableSelection = [self.mSliderTableView indexPathForSelectedRow];
    [self.mSliderTableView deselectRowAtIndexPath:tableSelection animated:NO];
    self.mSliderTableView.separatorColor = [UIColor clearColor];
    
}


-(void)CurrentUser{
    SKUser *CurrentUser = [[SKUser alloc] init];
    [CurrentUser setupUser:[Helper mCurrentUser]];
    
    self.mNameLbl.text = CurrentUser.mFirstName;
    self.mLocationLbl.text = CurrentUser.mEmail;
    
//    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@",CurrentUser.mUserImage]];
//    [self.mLogoImageView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"user_icon.jpg"]];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 45;
}

/*
 - (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
 {
 NSString *sectionName;
 sectionName = [NSString stringWithFormat: @"MENU"];
 return sectionName;
 }
 
 - (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
 {
 
 UIView *HeaderView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 40)];
 
 [HeaderView setBackgroundColor: [Helper colorWithHexString:@"1F1811"]];
 
 UILabel *LblObj=[[UILabel alloc]initWithFrame:CGRectMake(0, 8, 232, 24)];
 LblObj.text = @"MENU";
 LblObj.textColor = [UIColor whiteColor];
 LblObj.backgroundColor = [UIColor clearColor];
 LblObj.font =[UIFont fontWithName:@"Lato Regular" size:17.0];
 LblObj.textAlignment = NSTextAlignmentCenter ;

 [HeaderView addSubview:LblObj];
 return HeaderView;
 }
 
 - (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
 {
 return 40;
 }
 */
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return mSliderTableArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *CellIdentifier = @"slidercell";
    SKSliderCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    // Configure the cell...
    if (cell == nil) {
        cell = [[SKSliderCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        
    }
    
    
    
    
    UIView *bgColorView = [[UIView alloc] init];
    [bgColorView setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.3]];
    
    [cell setSelectedBackgroundView:bgColorView];
    
    cell.backgroundColor = [UIColor clearColor];
    
    cell.mSliderCellLbl.text = [mSliderTableArray objectAtIndex:indexPath.row];
    
    cell.mLogoImageView.image = [UIImage imageNamed:[mSliderImageTableArray objectAtIndex:indexPath.row]];
    
    NSLog(@"slidbarmenu %ld",(long)indexPath.row);
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;{
    
    NSLog(@"Selected View index=%ld",(long)indexPath.row);
    [mSliderTableView deselectRowAtIndexPath:indexPath animated:NO];
    
    
    if (indexPath.row == 0) {
        
      
        
      
        
        [Helper movewithStoryBourdID:DM.mAppObj.mBaseNavigation Id:@"ProfileVC" animation:NO];
        [DM.mAppObj.mSlideVC showCenterPanelAnimated:YES];
        
       DM.mAppObj.checkslide = YES;

    }
    else if (indexPath.row == 1) {
        
        
        
        [Helper movewithStoryBourdID:DM.mAppObj.mBaseNavigation Id:@"InspectLogVC" animation:NO];
        [DM.mAppObj.mSlideVC showCenterPanelAnimated:YES];
        
        
       DM.mAppObj.checkslide = YES;
        
      
    }
    else if (indexPath.row == 2) {
        
        [Helper movewithStoryBourdID:DM.mAppObj.mBaseNavigation Id:@"DocsVC" animation:NO];
        [DM.mAppObj.mSlideVC showCenterPanelAnimated:YES];
        
        
         DM.mAppObj.checkslide = YES;
   

    }
    else if (indexPath.row == 3) {
        NSLog(@"SettingsView");
        [Helper movewithStoryBourdID:DM.mAppObj.mBaseNavigation Id:@"DVIRVC" animation:NO];
        [DM.mAppObj.mSlideVC showCenterPanelAnimated:YES];
        
        
         DM.mAppObj.checkslide = YES;
       
        
    }
    /*
    else if (indexPath.row == 4) {
        
        [Helper movewithStoryBourdID:DM.mAppObj.mBaseNavigation Id:@"ChangeCycleTypeVC" animation:NO];
        [DM.mAppObj.mSlideVC showCenterPanelAnimated:YES];
        
        
    }
     */
    else if (indexPath.row == 4) {
        
        NSString *string = [NSString stringWithFormat:@"Basic ELD"];
        [self shareText:string andImage:nil andUrl:[NSURL URLWithString:string]];
        
        
       
        
    }
    else if (indexPath.row == 5) {
        
        [Helper movewithStoryBourdID:DM.mAppObj.mBaseNavigation Id:@"ContactUsVC" animation:NO];
        [DM.mAppObj.mSlideVC showCenterPanelAnimated:YES];
        
        DM.mAppObj.checkslide = YES;

    }
    else if (indexPath.row == 6) {
        [Helper movewithStoryBourdID:DM.mAppObj.mBaseNavigation Id:@"FaqVC" animation:NO];
        [DM.mAppObj.mSlideVC showCenterPanelAnimated:YES];
        
        
       DM.mAppObj.checkslide = YES;
        
    }

    else if (indexPath.row == 7) {
        [Helper movewithStoryBourdID:DM.mAppObj.mBaseNavigation Id:@"TermsAndConditionsVC" animation:NO];
        [DM.mAppObj.mSlideVC showCenterPanelAnimated:YES];
        
         DM.mAppObj.checkslide = YES;
        
    }
    else if (indexPath.row == 8) {
        NSLog(@"Logout");
        
       
 
        if ([DM.loginType isEqualToString:kLoginTypeSingle]) {
            
            if ([DM.iscertifiedcountAuth1_Global integerValue] > 0 ) {
                LogoutAlrt = [[UIAlertView alloc] initWithTitle:[DM.iscertifiedUsername1_Global uppercaseString] message:[NSString stringWithFormat:@"You have %@ uncertified logs \n Would you like to Certify now?",DM.iscertifiedcountAuth1_Global] delegate:self cancelButtonTitle:@"Yes" otherButtonTitles:@"No", nil];
                LogoutAlrt.tag = 1001;
                [LogoutAlrt show];
                
            }
            else{
                [self LogOutWarrning];
            }
            
        }
        else{
            
            if (([DM.iscertifiedcountAuth1_Global integerValue] > 0) && ([DM.iscertifiedcountAuth2_Global integerValue] > 0)) {
                
                LogoutAlrt = [[UIAlertView alloc] initWithTitle:@"" message:[NSString stringWithFormat:@"%@:You have %@ uncertified logs \n %@:You have %@ uncertified logs \n \n Would you like to Certify now?",[DM.iscertifiedUsername1_Global uppercaseString],DM.iscertifiedcountAuth1_Global,[DM.iscertifiedUsername2_Global uppercaseString],DM.iscertifiedcountAuth2_Global] delegate:self cancelButtonTitle:@"Yes" otherButtonTitles:@"No", nil];
                LogoutAlrt.tag = 1001;
                [LogoutAlrt show];
                
            }
            else if ([DM.iscertifiedcountAuth1_Global integerValue] > 0 ) {
                
                LogoutAlrt = [[UIAlertView alloc] initWithTitle:[DM.iscertifiedUsername1_Global uppercaseString] message:[NSString stringWithFormat:@"You have %@ uncertified logs \n Would you like to Certify now?",DM.iscertifiedcountAuth1_Global] delegate:self cancelButtonTitle:@"Yes" otherButtonTitles:@"No", nil];
                LogoutAlrt.tag = 1001;
                [LogoutAlrt show];
                
            }
            else if ([DM.iscertifiedcountAuth2_Global integerValue] > 0 ) {
                
                LogoutAlrt = [[UIAlertView alloc] initWithTitle:[DM.iscertifiedUsername2_Global uppercaseString] message:[NSString stringWithFormat:@"You have %@ uncertified logs \n Would you like to Certify now?",DM.iscertifiedcountAuth2_Global] delegate:self cancelButtonTitle:@"Yes" otherButtonTitles:@"No", nil];
                LogoutAlrt.tag = 1001;
                [LogoutAlrt show];
                
            }
            else{
                [self LogOutWarrning];
            }
            
            
            
            
            
        }
        
        

        
        
      
        /*
         UIAlertView *alrt = [[UIAlertView alloc] initWithTitle:@"Alert!!" message:@"Do you Want to Logout" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];
         alrt.tag = 1001;
         [alrt show];
         alrt = nil;
         */
        
        //[DM.mAppObj logout];
    }
  //  [DM.mAppObj.mSlideVC showCenterPanelAnimated:YES];

}

- (void)showLogout
{
    
    SCLAlertView *alert = [[SCLAlertView alloc] init];
    
    UIColor *color = [UIColor colorWithRed:248.0/255.0 green:208.0/255.0 blue:0/255.0 alpha:1.0];
    [alert showCustom:self image:[UIImage imageNamed:@"mini-truck.png"] color:color title:@"Alert!!" subTitle:@"Do you Want to Logout" closeButtonTitle:@"OK" duration:0.0f];
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (alertView.tag == 1001) {
        if (buttonIndex == 0) {
            
           
            
            [Helper movewithStoryBourdID:DM.mAppObj.mBaseNavigation Id:@"EditLogsVC" animation:NO];
            
              DM.mAppObj.checkslide = YES;

            [DM.mAppObj.mSlideVC showCenterPanelAnimated:YES];
        }
        else{
            [self LogOutWarrning];
        }
    }
    else if (alertView.tag == 1002){
        if (buttonIndex == 1) {
            mGoOffDuty = @"0";
            [self LogOut];
           
            

        }
        else if (buttonIndex == 2) {
            mGoOffDuty =  @"1";
            [self LogOut];
            
          
            
        }
        else{
            
        }
        
    }
    
}

-(void)LogOutWarrning{
    UIAlertView *alrt = [[UIAlertView alloc] initWithTitle:@"LOG OUT WARNING" message:@"Do you want to switch Off Duty before logging out" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Just Log Out",@"Go Off Duty" ,nil];
    alrt.tag = 1002;
    [alrt show];
}

-(void)LogOut{
    if (DM.mInternetStatus == false) {
        NSLog(@"No Internet Connection.");
        [Helper ISAlertTypeError:@"Internetr Connection!!" andMessage:kNOInternet];
        return;
    }
    else{
    NSString * path = [NSString stringWithFormat:@"%@logOutDriver",kServiceBaseURL];
    
    NSMutableDictionary * parameter = [[NSMutableDictionary alloc]init];
    [parameter setValue:DM.loginType forKey:@"loginType"];
    [parameter setValue:driverOne.mDriverId forKey:@"driverID1"];
    [parameter setValue:driverTwo.mDriverId forKey:@"driverID2"];
    [parameter setValue:mGoOffDuty forKey:@"go_off_duty"];
    CLLocationCoordinate2D coordinate = [DM getLocation];    NSString *latLong = [NSString stringWithFormat:@"%f,%f", coordinate.latitude,coordinate.longitude];
    [parameter setValue:latLong forKey:@"lat_long"];


    [DM PostRequest:path parameter:parameter onCompletion:^(id  _Nullable dict) {
        
        NSError *errorJson=nil;
        NSDictionary* responseDict = [NSJSONSerialization JSONObjectWithData:dict options:kNilOptions error:&errorJson];
        NSLog(@"%@",responseDict);
        NSString *ErrorString = [NSString stringWithFormat:@"%@",[responseDict valueForKey:@"message"]];
        if ([[responseDict valueForKey:@"status"] integerValue] == 0) {
            [Helper ISAlertTypeError:@"Error!!" andMessage:ErrorString];
        }
        else{
            DM.checkForAlerts = @"No";

            
            [DM.mAppObj logout];
            [Helper ISAlertTypeSuccess:@"Success" andMessage:ErrorString];
            [DM.mAppObj.mSlideVC showCenterPanelAnimated:YES];
        }
    } onError:^(NSError * _Nullable Error) {
        NSLog(@"%@",Error);
        NSString *ErrorString = [NSString stringWithFormat:@"%@",Error];
        [Helper ISAlertTypeError:@"Error!!" andMessage:ErrorString];
    }];
    }
}

- (void)shareText:(NSString *)text andImage:(UIImage *)image andUrl:(NSURL *)url
{
    NSMutableArray *sharingItems = [NSMutableArray new];
    if (text) {
        [sharingItems addObject:text];
    }
    if (image) {
        [sharingItems addObject:image];
    }
    if (url) {
        [sharingItems addObject:url];
    }
    UIActivityViewController *activityController = [[UIActivityViewController alloc] initWithActivityItems:sharingItems applicationActivities:nil];
    [self presentViewController:activityController animated:YES completion:nil];
}

-(IBAction)facebookClicked:(id)sender {
    
    if (DM.mInternetStatus == false) {
        UIAlertView *alrt = [[UIAlertView alloc] initWithTitle:@"Network Error:" message:@"Sorry, your device is not connected to internet." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alrt show];
        alrt = nil;
        return;
    }
    
    NSURL *desiredurl = [NSURL URLWithString:@"fb://profile/1159582604108550"];
    NSString *openStr = [desiredurl absoluteString];
    if([[UIApplication sharedApplication] canOpenURL:desiredurl]) {
        [self openSocialUrl:openStr];
    }
    else {
        NSArray *mTempArr = [openStr componentsSeparatedByString:@"/"];
        if ([mTempArr count]){
            NSString *postFixStr = [mTempArr lastObject];
            [self openSocialUrl:[NSString stringWithFormat:@"%@%@", kfbPrefixStr, postFixStr]];
        }
    }
    
}

-(IBAction)twitterClicked:(id)sender {
    if (DM.mInternetStatus == false) {
        UIAlertView *alrt = [[UIAlertView alloc] initWithTitle:@"Network Error:" message:@"Sorry, your device is not connected to internet." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alrt show];
        alrt = nil;
        return;
    }
    
    NSURL *desiredurl = [NSURL URLWithString:@"twitter://user?screen_name=vermz814"];
    NSString *openStr = [desiredurl absoluteString];
    if([[UIApplication sharedApplication] canOpenURL:desiredurl]) {
        [self openSocialUrl:openStr];
    }
    else {
        NSArray *mTempArr = [openStr componentsSeparatedByString:@"="];
        if ([mTempArr count]){
            NSString *postFixStr = [mTempArr lastObject];
            [self openSocialUrl:[NSString stringWithFormat:@"%@%@", ktwitterPrefixStr, postFixStr]];
        }
    }
}

- (void)openSocialUrl:(NSString *) linkStr {
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:linkStr]];
}


-(IBAction)openWebsiteAction:(id)sender {
    CVBWebsiteVC *webvcObj = [self.storyboard instantiateViewControllerWithIdentifier:@"webvc"];
    webvcObj.webURL = @"https://www.facebook.com/shreesna/";
    webvcObj.titleStr = @"";
    [self presentViewController:webvcObj animated:YES completion:NULL];
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

@end
