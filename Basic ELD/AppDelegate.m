//
//  AppDelegate.m
//  Basic ELD
//
//  Created by Gaurav Verma on 04/05/17.
//  Copyright © 2017 Gaurav Verma. All rights reserved.
//

#import "AppDelegate.h"
#import "SKSliderVC.h"
@interface AppDelegate (){
    SKSliderVC *SliverVC;
}

@end

@implementation AppDelegate
@synthesize mSlideVC,mainStoryboard,mBaseNavigation,loginVC,mDashboard,mLeftPanelSlider;


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [GMSPlacesClient provideAPIKey:kGoogleMapAPIKey];
    [GMSServices provideAPIKey:kGoogleMapAPIKey];
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    [Fabric with:@[[Crashlytics class]]];
    
    [DataManager sharedDataManager];
    
    mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
    loginVC = (SKLoginVC *)[mainStoryboard instantiateViewControllerWithIdentifier: @"loginvc"];
    
    mDashboard = (ViewController *)[mainStoryboard instantiateViewControllerWithIdentifier: @"dashboardvc"];
    mBaseNavigation =(UINavigationController *)[mainStoryboard instantiateViewControllerWithIdentifier: @"navigation"];
    mLeftPanelSlider = (SKSliderVC *)[mainStoryboard instantiateViewControllerWithIdentifier: @"sidepanel"];
    //  ContactsView  = (ContactsVC *)[mainStoryboard instantiateViewControllerWithIdentifier: @"contactsview"];
    
    [self checkLogin];
    
    // PUSH NOTIFICATION
    
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 80000
    if ([application respondsToSelector:@selector(registerUserNotificationSettings:)]) {
        UIUserNotificationType userNotificationTypes = (UIUserNotificationTypeAlert |
                                                        UIUserNotificationTypeBadge |
                                                        UIUserNotificationTypeSound);
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:userNotificationTypes
                                                                                 categories:nil];
        [application registerUserNotificationSettings:settings];
        [application registerForRemoteNotifications];
    } else
#endif
    {
        [application registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge |
                                                         UIRemoteNotificationTypeAlert |
                                                         UIRemoteNotificationTypeSound)];
    }
    
   
    
  /*
    NSString *insertStr_web_records_tbl = @"insert into web_records_tbl(partner_id,user_name,user_uniq_id,user_dob,user_image,check_devid,user_desc,orderid,date_time,order_id,user_deleted,first_name,last_name,order_status) values('2','3','4','5','6','7','8','9','10','11','12','13','14','15')";
    
    [DM insertData:insertStr_web_records_tbl];
    
    NSArray *allVideoRecords_web_records_tbl = [DM fetchRecordByID:@"select * from web_records_tbl;"];
    //for getting vaues from record array
    NSLog(@"%lu",(unsigned long)allVideoRecords_web_records_tbl.count);
    
   */
    
    return YES;

}


- (void) logUser {
    SKUser *CurrentUser = [[SKUser alloc] init];
    [CurrentUser setupUser:[Helper mCurrentUser]];
    
    if ([CurrentUser.mDriverId length] != 0) {
        //[CrashlyticsKit setUserIdentifier:CurrentUser.mUsers_Id];
        [CrashlyticsKit setUserEmail:CurrentUser.mEmail];
        [CrashlyticsKit setUserName:CurrentUser.mUserName];
    }
}



#pragma mark- Notification methods

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error{
    /*
     UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Error" message:[error description] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
     [alert show];
     */
    NSLog(@"Failed to recieve token. Error : %@",[error description]);
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    
    NSLog(@"%@",deviceToken);
}




- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
    
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}



- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    
    
}



- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    
    [SliverVC LogOut];
}


-(void)checkLogin {
    
    SKUser *CurrentUser = [[SKUser alloc] init];
    [CurrentUser setupUser:[Helper mCurrentUser:kCurrentUserOne]];
    
    if ([CurrentUser.mDriverId length] != 0) {
        
        
        mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
        loginVC = (SKLoginVC *)[mainStoryboard instantiateViewControllerWithIdentifier: @"loginvc"];
        mDashboard = (ViewController *)[mainStoryboard instantiateViewControllerWithIdentifier: @"dashboardvc"];
        mBaseNavigation =(UINavigationController *)[mainStoryboard instantiateViewControllerWithIdentifier: @"navigation"];
        mLeftPanelSlider = (SKSliderVC *)[mainStoryboard instantiateViewControllerWithIdentifier: @"sidepanel"];
    
        
        mSlideVC = [[JASidePanelController alloc] init];
        mBaseNavigation = [[UINavigationController alloc] initWithRootViewController:mDashboard];
        mSlideVC.centerPanel = mBaseNavigation;
        mSlideVC.rightPanel = mLeftPanelSlider;
        [mSlideVC setLeftFixedWidth:50];
        self.mBaseNavigation.navigationBarHidden = YES;
        self.window.rootViewController = mSlideVC;
    }
    else
    {
        mBaseNavigation = [[UINavigationController alloc] initWithRootViewController:loginVC];
        self.mBaseNavigation.navigationBarHidden = YES;
        self.window.rootViewController = mBaseNavigation;
        
        // No user is signed in.
    }

}


-(void)logout {
    
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:kCurrentUserOne];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:kCurrentUserTwo];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:kCheckForAlerts];
    [[NSUserDefaults standardUserDefaults] synchronize];

    mBaseNavigation = nil;
    
    mBaseNavigation = [[UINavigationController alloc] initWithRootViewController:loginVC];
    self.mBaseNavigation.navigationBarHidden = YES;
    self.window.rootViewController = mBaseNavigation;
}

-(UIInterfaceOrientationMask)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window
{
    if(self.restrictRotation == NO){
         [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationSlide];
        
        
       
        
        return UIInterfaceOrientationMaskAll ;
        
       
     
        
    }
    else
        
        
        return UIInterfaceOrientationMaskPortrait;
}

@end
