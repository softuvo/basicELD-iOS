//
//  ViewController.m
//  Basic ELD
//
//  Created by Gaurav Verma on 04/05/17.
//  Copyright © 2017 Gaurav Verma. All rights reserved.
//

#import "ViewController.h"
#import "ChangeStatusVC.h"
#import "DocsVC.h"
#import "EditLogsVC.h"
#import "DashBoardPressedVC.h"
#import "AppDelegate.h"
#import "SOMotionDetector.h"
#import "SOStepDetector.h"


@interface ViewController (){
    
    NSString * teamStatusRef;
    
    NSString * driverOneStatus ;
    NSString * driverTwoStatus ;
    
    NSString * popUpRef;
    NSString * popUpRefPersonalUse;
    NSString * popUpRefYardMove;

    NSString * popUpRefDriverTwo;

    NSDictionary * driverOneDetails;
    NSDictionary * driverTwoDetails;
    
    CLLocationManager * locationManager;
    UIAlertView * personalUseAlert ;
    
    NSString * checkOne ;
    
    
    CGFloat ScreenHeight;
    CGFloat ScreenWidth;
    
    
    NSString *refPin ;
    NSString *enterdPin ;
    NSString *SelectedDriver;
    
    UIAlertView *iscertifiedAlert ;
    UIAlertView *UncertifiedDvirAlert;


}

@end

@implementation ViewController
@synthesize driverOne,driverTwo;

//

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
   ScreenHeight = self.view.bounds.size.height;
  ScreenWidth = self.view.bounds.size.width;
//    [self.ScrollView layoutIfNeeded];
//    self.ScrollView.contentSize = self.ContentView.bounds.size;

   [self portrait];
    
    self.CFPinView.hidden = YES ;
    
    self.StatusTitleLabel.hidden = YES ;
    DM.loginType = nil ;
    DM.loginType = [[NSUserDefaults standardUserDefaults] stringForKey:kUserLoggedInType];
    
 
    
  //  [self GetStatus];
    [self addmap];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(SelectedRelation:) name:KDutyStatusPopupNotification object:nil];
    
    personalUseAlert = [[UIAlertView alloc]
                        initWithTitle:nil message:@"Are you still in Personal Use mode?" delegate:self cancelButtonTitle:@"Yes" otherButtonTitles:@"No", nil];
    personalUseAlert.tag = 1027;
    
}


- (void)timerLabel:(MZTimerLabel*)timerLabel finshedCountDownTimerWithTime:(NSTimeInterval)countTime{
    
    NSString *msg = [NSString stringWithFormat:@"%i seconds",(int)countTime];

    if (timerLabel == self.mTimeRemainingLabel) {
        self.mTimeRemainingLabel.timeLabel.textColor = [UIColor redColor];
        self.mTimeRemainingLabel.timerType = MZTimerLabelTypeStopWatch;
        [self.mTimeRemainingLabel pause];
        [self.mTimeRemainingLabel start];


    }
    else if (timerLabel == self.mTimeTillBreakLabel) {
        self.mTimeTillBreakLabel.timeLabel.textColor = [UIColor redColor];
        self.mTimeTillBreakLabel.timerType = MZTimerLabelTypeStopWatch;
        [self.mTimeTillBreakLabel pause];
        [self.mTimeTillBreakLabel start];
        
    }
}


-(void)ResetTimer:(NSString *)left_driving_time left_time_for_break:(NSString *)left_time_for_break break_elapsed_time:(NSString *)break_elapsed_time driving_elapsed_timing:(NSString *)driving_elapsed_timing {
    
    if ([left_driving_time isEqualToString:@"00:00:00"]) {

        self.mTimeRemainingLabel.timeLabel.textColor = [UIColor redColor];
        [self.mTimeRemainingLabel pause];
        self.mTimeRemainingLabel.text = driving_elapsed_timing;
        
    }else{
        
        self.mTimeRemainingLabel.timeLabel.textColor = [UIColor grayColor];
        [self.mTimeRemainingLabel pause];
        self.mTimeRemainingLabel.text = left_driving_time;
    }
    if ([left_time_for_break isEqualToString:@"00:00:00"]) {
        
        self.mTimeTillBreakLabel.timeLabel.textColor = [UIColor redColor];
        [self.mTimeTillBreakLabel pause];
        self.mTimeTillBreakLabel.text = break_elapsed_time;

    }else{
        
        self.mTimeTillBreakLabel.timeLabel.textColor = [UIColor grayColor];
        [self.mTimeTillBreakLabel pause];
        self.mTimeTillBreakLabel.text = left_time_for_break;

    }

}

- (NSNumber *)secondsForTimeString:(NSString *)string {
    
    NSArray *components = [string componentsSeparatedByString:@":"];
    
    NSInteger hours   = [[components objectAtIndex:0] integerValue];
    NSInteger minutes = [[components objectAtIndex:1] integerValue];
    NSInteger seconds = [[components objectAtIndex:2] integerValue];
    
    return [NSNumber numberWithInteger:(hours * 60 * 60) + (minutes * 60) + seconds];
}

-(void)TimerStartAndUpdate:(NSTimeInterval )left_driving_time left_time_for_break:(NSTimeInterval)left_time_for_break break_elapsed_time:(NSTimeInterval)break_elapsed_time driving_elapsed_timing:(NSTimeInterval)driving_elapsed_timing {
   
    if (left_driving_time > 0) {
        NSLog(@"%f",left_driving_time);

        [self.mTimeRemainingLabel reset];
        self.mTimeRemainingLabel.timerType = MZTimerLabelTypeTimer;
        [self.mTimeRemainingLabel setCountDownTime:left_driving_time];
        self.mTimeRemainingLabel.resetTimerAfterFinish = NO;
        self.mTimeRemainingLabel.delegate = self;
        self.mTimeRemainingLabel.timeLabel.textColor = [UIColor grayColor];
        [self.mTimeRemainingLabel reset];
        [self.mTimeRemainingLabel start];
        
        /*
         if(![self.mTimeRemainingLabel counting]){
         [self.mTimeRemainingLabel start];
         }
         */
    }
    else {
        NSLog(@"%f",driving_elapsed_timing);
        
        self.mTimeRemainingLabel.timeLabel.textColor = [UIColor redColor];
        self.mTimeRemainingLabel.timerType = MZTimerLabelTypeStopWatch;
        [self.mTimeRemainingLabel reset];
        [self.mTimeRemainingLabel start];
        [self.mTimeRemainingLabel addTimeCountedByTime:driving_elapsed_timing];
        
        
    }
    
    if (left_time_for_break > 0) {
        NSLog(@"%f",left_time_for_break);

        [self.mTimeTillBreakLabel  reset];
        self.mTimeTillBreakLabel.timerType = MZTimerLabelTypeTimer;
        [self.mTimeTillBreakLabel setCountDownTime:left_time_for_break];
        self.mTimeTillBreakLabel.resetTimerAfterFinish = NO;
        self.mTimeTillBreakLabel.delegate = self;
        self.mTimeTillBreakLabel.timeLabel.textColor = [UIColor blackColor];
        [self.mTimeTillBreakLabel  reset];
        [self.mTimeTillBreakLabel  start];
        
        /*
         if(![self.mTimeTillBreakLabel counting]){
         [self.mTimeTillBreakLabel  start];
         }
         */
        
    }
    else {
        NSLog(@"%f",break_elapsed_time);
        self.mTimeTillBreakLabel.timeLabel.textColor = [UIColor redColor];
        self.mTimeTillBreakLabel.timerType = MZTimerLabelTypeStopWatch;
        [self.mTimeTillBreakLabel reset];
        [self.mTimeTillBreakLabel start];
        [self.mTimeTillBreakLabel addTimeCountedByTime:break_elapsed_time];

    }
    
    

}

- (void)deviceDidRotate:(NSNotification *)notification
{
    
    if (UIDeviceOrientationIsLandscape([UIDevice currentDevice].orientation))
    {
        NSLog(@"%@",@"viewcontroller landscap ");
        
        ScreenHeight = self.view.bounds.size.height;
        ScreenWidth = self.view.bounds.size.width;
            self.ScrollView.frame = CGRectMake(ScreenWidth*0.0, ScreenHeight*0.0, ScreenWidth, ScreenHeight);
            self.ContentView.frame = CGRectMake(ScreenWidth*0.0, ScreenHeight*0.0, ScreenWidth, ScreenHeight);
            [self.ScrollView layoutIfNeeded];
            self.ScrollView.contentSize = self.ContentView.bounds.size;
        
                [self landscap];
        
        

    }
    else if (UIDeviceOrientationIsPortrait([UIDevice currentDevice].orientation))
    {
        ScreenHeight = self.view.bounds.size.height;
        ScreenWidth = self.view.bounds.size.width;
        NSLog(@"%@",@"viewcontroller protrait");
        
        self.ScrollView.frame = CGRectMake(ScreenWidth*0.0, ScreenHeight*0.0, ScreenWidth, ScreenHeight);
        self.ContentView.frame = CGRectMake(ScreenWidth*0.0, ScreenHeight*0.0, ScreenWidth, ScreenHeight);

             [self.ScrollView layoutIfNeeded];
            self.ScrollView.contentSize = self.ContentView.bounds.size;
        
           [self portrait];
        
    }
    
}



-(void)portrait{
    // NavigationView
    
    self.CustomNavigationView.frame = CGRectMake(ScreenWidth*0.0,ScreenHeight*0.0, ScreenWidth, ScreenHeight*0.10);
    
    self.BasicEldNavigationlable.frame = CGRectMake( (self.CustomNavigationView.frame.size.width)*0.30, (self.CustomNavigationView.frame.size.height)*0.0,(self.CustomNavigationView.frame.size.width)*0.40, (self.CustomNavigationView.frame.size.height)*0.90);
    
    //self.BasicEldNavigationlable.backgroundColor = [UIColor greenColor];
    // self.BasicEldNavigationlable.frame = CGRectMake(200,0,200, 70);
    
    self.SideBarButton.frame = CGRectMake((self.CustomNavigationView.frame.size.width)*0.85, (self.CustomNavigationView.frame.size.height)*0.0, (self.CustomNavigationView.frame.size.width)*0.15, (self.CustomNavigationView.frame.size.height)*0.90);
    
    self.BothDriverView.frame = CGRectMake(ScreenWidth*0.0, ScreenHeight*0.10, ScreenWidth, ScreenHeight*0.50);
    
    self.BothDriverView.backgroundColor = [UIColor yellowColor];
    
    self.DashboardImage.frame = CGRectMake(ScreenWidth*0.0, ScreenHeight*0.00, ScreenWidth, ScreenHeight*0.50);
    
   // self.DashboardImage.backgroundColor = [UIColor greenColor];
    
    self.GraphView.frame = CGRectMake(ScreenWidth*0.0, ScreenHeight*0.40, self.DashboardImage.frame.size.width, ScreenHeight*0.10);
    
    self.StaticGrafImage.frame = CGRectMake(ScreenWidth*0.0, ScreenHeight*0.50, ScreenWidth, ScreenHeight*0.15);
    
    self.mInspectLogButton.frame = CGRectMake( (self.GraphView.frame.size.width)*0.02,(self.GraphView.frame.size.height)*0.15,(self.GraphView.frame.size.width)*0.30,(self.GraphView.frame.size.height)*0.70);
    
    self.mEditLogButton.frame = CGRectMake( (self.GraphView.frame.size.width)*0.35,(self.GraphView.frame.size.height)*0.15,(self.GraphView.frame.size.width)*0.30,(self.GraphView.frame.size.height)*0.70);
    
    self.mDocumentsButton.frame = CGRectMake( (self.GraphView.frame.size.width)*0.68,(self.GraphView.frame.size.height)*0.15,(self.GraphView.frame.size.width)*0.30,(self.GraphView.frame.size.height)*0.70);
    
    self.DriversView.frame =  CGRectMake( (self.BothDriverView.frame.size.width)*0.00,(self.BothDriverView.frame.size.height)*0.00,(self.BothDriverView.frame.size.width),(self.BothDriverView.frame.size.height));
    
   // self.DriversView.backgroundColor = [UIColor greenColor];
    
    self.DashBoardButton.frame = CGRectMake( (self.DriversView.frame.size.width)*0.20,(self.DriversView.frame.size.height)*0.10,(self.DriversView.frame.size.width)*0.60,(self.DriversView.frame.size.height)*0.60);
    
    self.Driver1View.frame = CGRectMake( (self.DriversView.frame.size.width)*0.00,(self.DriversView.frame.size.height)*0.05,(self.DriversView.frame.size.width)*0.20,(self.DriversView.frame.size.height)*0.40);
    
    self.Driver2View.frame = CGRectMake( (self.DriversView.frame.size.width)*0.80,(self.DriversView.frame.size.height)*0.05,(self.DriversView.frame.size.width)*0.20,(self.DriversView.frame.size.height)*0.40);
    
    self.Driver1Button.frame = CGRectMake( (self.Driver1View.frame.size.width)*0.00,(self.Driver1View.frame.size.height)*0.00,(self.Driver1View.frame.size.width),(self.Driver1View.frame.size.width));
    
    self.Driver2Button.frame = CGRectMake( (self.Driver2View.frame.size.width)*0.00,(self.Driver2View.frame.size.height)*0.00,(self.Driver2View.frame.size.width),(self.Driver2View.frame.size.width));
    
    self.mDriverOneStatusIV.frame = CGRectMake( (self.Driver1Button.frame.size.width)*0.20,(self.Driver1Button.frame.size.height)*0.20,(self.Driver1Button.frame.size.width)*0.60,(self.Driver1Button.frame.size.width)*0.60);
    
    self.mDriverTwoStatusIV.frame = CGRectMake( (self.Driver2Button.frame.size.width)*0.20,(self.Driver2Button.frame.size.height)*0.20,(self.Driver2Button.frame.size.width)*0.60,(self.Driver2Button.frame.size.width)*0.60);
    
    self.mDriverOneName.frame = CGRectMake( (self.Driver1View.frame.size.width)*0.00,(self.Driver1View.frame.size.height)*0.60,(self.Driver1View.frame.size.width),(self.Driver1View.frame.size.width)*0.40);
    //    self.mDriverOneName.numberOfLines = 0;
    //
    //    [self.mDriverOneName sizeToFit];
    //
    //
    //    self.mDriverOneName .textAlignment = NSTextAlignmentCenter;
    //
    self.mDriverTwoName.frame = CGRectMake( (self.Driver2View.frame.size.width)*0.00,(self.Driver2View.frame.size.height)*0.60,(self.Driver2View.frame.size.width),(self.Driver2View.frame.size.height)*0.40);
    
    self.mTimeRemainingLabel.frame = CGRectMake( (self.DriversView.frame.size.width)*0.30,(self.DriversView.frame.size.height)*0.25,(self.DriversView.frame.size.width)*0.40,(self.DriversView.frame.size.height)*0.20);
    
    self.ErosBoxes.frame = CGRectMake( (self.DriversView.frame.size.width)*0.33,(self.DriversView.frame.size.height)*0.12,(self.DriversView.frame.size.width)*0.34,(self.DriversView.frame.size.height)*0.10);
    
    self.Erros_Title.frame = CGRectMake( (self.DriversView.frame.size.width)*0.36,(self.DriversView.frame.size.height)*0.13,(self.DriversView.frame.size.width)*0.18,(self.DriversView.frame.size.height)*0.07);
    
    self.mErrorsLabel.frame = CGRectMake( (self.DriversView.frame.size.width)*0.54,(self.DriversView.frame.size.height)*0.13,(self.DriversView.frame.size.width)*0.18,(self.DriversView.frame.size.height)*0.07);
    
    self.TimeRemaimngLable.frame = CGRectMake( (self.DriversView.frame.size.width)*0.28,(self.DriversView.frame.size.height)*0.25,(self.DriversView.frame.size.width)*0.44,(self.DriversView.frame.size.height)*0.07);
    
    self.mProgressiveBar.frame = CGRectMake( (self.DriversView.frame.size.width)*0.30,(self.DriversView.frame.size.height)*0.50,(self.DriversView.frame.size.width)*0.40,(self.DriversView.frame.size.height)*0.07);
    
    self.MilesDrivenLable.frame = CGRectMake( (self.DriversView.frame.size.width)*0.28,(self.DriversView.frame.size.height)*0.53,(self.DriversView.frame.size.width)*0.34,(self.DriversView.frame.size.height)*0.07);
    [self.MilesDrivenLable setFont:[UIFont systemFontOfSize:10]];
    
    self.mMilesDrivenLabel.frame = CGRectMake( (self.DriversView.frame.size.width)*0.62,(self.DriversView.frame.size.height)*0.53,(self.DriversView.frame.size.width)*0.20,(self.DriversView.frame.size.height)*0.07);
    [self.mMilesDrivenLabel setFont:[UIFont systemFontOfSize:10]];
    
    self.TimetillBreak.frame = CGRectMake( (self.DriversView.frame.size.width)*0.29,(self.DriversView.frame.size.height)*0.60,(self.DriversView.frame.size.width)*0.25,(self.DriversView.frame.size.height)*0.07);
    
    [self.TimetillBreak setFont:[UIFont systemFontOfSize:7]];
    
    self.mTimeTillBreakLabel.frame = CGRectMake( (self.DriversView.frame.size.width)*0.49,(self.DriversView.frame.size.height)*0.60,(self.DriversView.frame.size.width)*0.25,(self.DriversView.frame.size.height)*0.07);
    
    [self.mTimeTillBreakLabel setFont:[UIFont systemFontOfSize:7]];
    
    self.StatusTitleLabel.frame = CGRectMake( (self.DriversView.frame.size.width)*0.40,(self.DriversView.frame.size.height)*0.02,(self.DriversView.frame.size.width)*0.30,(self.DriversView.frame.size.height)*0.07);
    
    self.mDriverOneTitleLabel.frame = CGRectMake( (self.DriversView.frame.size.width)*0.05,(self.DriversView.frame.size.height)*0.02,(self.DriversView.frame.size.width)*0.30,(self.DriversView.frame.size.height)*0.07);
    
    self.mMapView.frame = CGRectMake( ScreenWidth*0.00,ScreenHeight*0.70,ScreenWidth,ScreenHeight*0.30);

    self.mapButton.frame = CGRectMake( ScreenWidth*0.00,ScreenHeight*0.70,ScreenWidth,ScreenHeight*0.30);
    
    //     [self.mDriverTwoName sizeToFit];
    //
    //
    //
    //    self.mDriverTwoName.numberOfLines = 0;
    
    
    
//         self.Driver2Button.backgroundColor = [UIColor yellowColor];
//
//        self.Driver1Button.backgroundColor = [UIColor yellowColor];
//         self.Driver1View.backgroundColor = [UIColor redColor];
//        self.Driver2View.backgroundColor = [UIColor redColor];
//
//        self.StaticGrafImage.backgroundColor = [UIColor redColor];
//
//        self.CustomNavigationView.backgroundColor = [UIColor redColor];
//
}





-(void)landscap{
    // NavigationView
    
     self.CustomNavigationView.frame = CGRectMake(ScreenWidth*0.0,ScreenHeight*0.0, ScreenWidth, ScreenHeight*0.15);
    
    self.BasicEldNavigationlable.frame = CGRectMake( (self.CustomNavigationView.frame.size.width)*0.30, (self.CustomNavigationView.frame.size.height)*0.0, ScreenWidth*0.40, ScreenHeight*0.15);
    
    //self.BasicEldNavigationlable.backgroundColor = [UIColor greenColor];
   // self.BasicEldNavigationlable.frame = CGRectMake(200,0,200, 70);
    self.SideBarButton.frame = CGRectMake(ScreenWidth*0.85, ScreenHeight*0.0, ScreenWidth*0.15, ScreenHeight*0.15);
    
    self.BothDriverView.frame = CGRectMake(ScreenWidth*0.0, ScreenHeight*0.15, ScreenWidth*0.50, ScreenHeight*0.65);
    
   self.BothDriverView.backgroundColor = [UIColor clearColor];
    
    self.DashboardImage.frame = CGRectMake(ScreenWidth*0.0, ScreenHeight*0.0, ScreenWidth*0.50, ScreenHeight*0.65);
 //   self.DashboardImage.backgroundColor = [UIColor greenColor];
    
     self.GraphView.frame = CGRectMake(ScreenWidth*0.0, ScreenHeight*0.50, self.DashboardImage.frame.size.width, ScreenHeight*0.15);
    
    self.StaticGrafImage.frame = CGRectMake(ScreenWidth*0.0, ScreenHeight*0.65, ScreenWidth*0.50, ScreenHeight*0.20);
    
    self.mInspectLogButton.frame = CGRectMake( (self.GraphView.frame.size.width)*0.02,(self.GraphView.frame.size.height)*0.15,(self.GraphView.frame.size.width)*0.30,(self.GraphView.frame.size.height)*0.70);
    
      self.mEditLogButton.frame = CGRectMake( (self.GraphView.frame.size.width)*0.35,(self.GraphView.frame.size.height)*0.15,(self.GraphView.frame.size.width)*0.30,(self.GraphView.frame.size.height)*0.70);
    
     self.mDocumentsButton.frame = CGRectMake( (self.GraphView.frame.size.width)*0.68,(self.GraphView.frame.size.height)*0.15,(self.GraphView.frame.size.width)*0.30,(self.GraphView.frame.size.height)*0.70);
    
    self.DriversView.frame =  CGRectMake( (self.BothDriverView.frame.size.width)*0.00,(self.BothDriverView.frame.size.height)*0.00,(self.BothDriverView.frame.size.width),(self.BothDriverView.frame.size.height));
    
    //self.DriversView.backgroundColor = [UIColor greenColor];
    
    self.DashBoardButton.frame = CGRectMake( (self.DriversView.frame.size.width)*0.20,(self.DriversView.frame.size.height)*0.10,(self.DriversView.frame.size.width)*0.60,(self.DriversView.frame.size.height)*0.60);
    
    self.Driver1View.frame = CGRectMake( (self.DriversView.frame.size.width)*0.00,(self.DriversView.frame.size.height)*0.05,(self.DriversView.frame.size.width)*0.20,(self.DriversView.frame.size.height)*0.40);
    
    self.Driver2View.frame = CGRectMake( (self.DriversView.frame.size.width)*0.80,(self.DriversView.frame.size.height)*0.05,(self.DriversView.frame.size.width)*0.20,(self.DriversView.frame.size.height)*0.40);
    
    self.Driver1Button.frame = CGRectMake( (self.Driver1View.frame.size.width)*0.00,(self.Driver1View.frame.size.height)*0.00,(self.Driver1View.frame.size.width),(self.Driver1View.frame.size.width));

    self.Driver2Button.frame = CGRectMake( (self.Driver2View.frame.size.width)*0.00,(self.Driver2View.frame.size.height)*0.00,(self.Driver2View.frame.size.width),(self.Driver2View.frame.size.width));
    
    self.mDriverOneStatusIV.frame = CGRectMake( (self.Driver1Button.frame.size.width)*0.20,(self.Driver1Button.frame.size.height)*0.20,(self.Driver1Button.frame.size.width)*0.60,(self.Driver1Button.frame.size.width)*0.60);
    
    self.mDriverTwoStatusIV.frame = CGRectMake( (self.Driver2Button.frame.size.width)*0.20,(self.Driver2Button.frame.size.height)*0.20,(self.Driver2Button.frame.size.width)*0.60,(self.Driver2Button.frame.size.width)*0.60);
    
    self.mDriverOneName.frame = CGRectMake( (self.Driver1View.frame.size.width)*0.00,(self.Driver1View.frame.size.height)*0.60,(self.Driver1View.frame.size.width),(self.Driver1View.frame.size.width)*0.40);
//    self.mDriverOneName.numberOfLines = 0;
//
//    [self.mDriverOneName sizeToFit];
//
//
//    self.mDriverOneName .textAlignment = NSTextAlignmentCenter;
//
    self.mDriverTwoName.frame = CGRectMake( (self.Driver2View.frame.size.width)*0.00,(self.Driver2View.frame.size.height)*0.60,(self.Driver2View.frame.size.width),(self.Driver2View.frame.size.height)*0.40);
    
    self.mTimeRemainingLabel.frame = CGRectMake( (self.DriversView.frame.size.width)*0.30,(self.DriversView.frame.size.height)*0.25,(self.DriversView.frame.size.width)*0.40,(self.DriversView.frame.size.height)*0.20);
    
    self.ErosBoxes.frame = CGRectMake( (self.DriversView.frame.size.width)*0.33,(self.DriversView.frame.size.height)*0.12,(self.DriversView.frame.size.width)*0.34,(self.DriversView.frame.size.height)*0.10);
    
    self.Erros_Title.frame = CGRectMake( (self.DriversView.frame.size.width)*0.36,(self.DriversView.frame.size.height)*0.13,(self.DriversView.frame.size.width)*0.18,(self.DriversView.frame.size.height)*0.07);
    
    self.mErrorsLabel.frame = CGRectMake( (self.DriversView.frame.size.width)*0.54,(self.DriversView.frame.size.height)*0.13,(self.DriversView.frame.size.width)*0.18,(self.DriversView.frame.size.height)*0.07);
    
    self.TimeRemaimngLable.frame = CGRectMake( (self.DriversView.frame.size.width)*0.28,(self.DriversView.frame.size.height)*0.25,(self.DriversView.frame.size.width)*0.44,(self.DriversView.frame.size.height)*0.07);
    
   self.mProgressiveBar.frame = CGRectMake( (self.DriversView.frame.size.width)*0.30,(self.DriversView.frame.size.height)*0.50,(self.DriversView.frame.size.width)*0.40,(self.DriversView.frame.size.height)*0.07);
    
      self.MilesDrivenLable.frame = CGRectMake( (self.DriversView.frame.size.width)*0.28,(self.DriversView.frame.size.height)*0.53,(self.DriversView.frame.size.width)*0.34,(self.DriversView.frame.size.height)*0.07);
    [self.MilesDrivenLable setFont:[UIFont systemFontOfSize:10]];
    
    self.mMilesDrivenLabel.frame = CGRectMake( (self.DriversView.frame.size.width)*0.62,(self.DriversView.frame.size.height)*0.53,(self.DriversView.frame.size.width)*0.20,(self.DriversView.frame.size.height)*0.07);
    [self.mMilesDrivenLabel setFont:[UIFont systemFontOfSize:10]];
    
     self.TimetillBreak.frame = CGRectMake( (self.DriversView.frame.size.width)*0.29,(self.DriversView.frame.size.height)*0.60,(self.DriversView.frame.size.width)*0.25,(self.DriversView.frame.size.height)*0.07);
    
    [self.TimetillBreak setFont:[UIFont systemFontOfSize:7]];
    
    self.mTimeTillBreakLabel.frame = CGRectMake( (self.DriversView.frame.size.width)*0.49,(self.DriversView.frame.size.height)*0.60,(self.DriversView.frame.size.width)*0.25,(self.DriversView.frame.size.height)*0.07);
    
    [self.mTimeTillBreakLabel setFont:[UIFont systemFontOfSize:7]];
    
     self.StatusTitleLabel.frame = CGRectMake( (self.DriversView.frame.size.width)*0.40,(self.DriversView.frame.size.height)*0.02,(self.DriversView.frame.size.width)*0.30,(self.DriversView.frame.size.height)*0.07);
    
     self.mDriverOneTitleLabel.frame = CGRectMake( (self.DriversView.frame.size.width)*0.05,(self.DriversView.frame.size.height)*0.02,(self.DriversView.frame.size.width)*0.30,(self.DriversView.frame.size.height)*0.07);
    
     self.mMapView.frame = CGRectMake( ScreenWidth*0.50,ScreenHeight*0.15,ScreenWidth*0.50,ScreenHeight);
    
    self.mapButton.frame = CGRectMake( ScreenWidth*0.50,ScreenHeight*0.15,ScreenWidth*0.50,ScreenHeight);
    
//     [self.mDriverTwoName sizeToFit];
//
//
//
//    self.mDriverTwoName.numberOfLines = 0;
    
     //self.mDriverTwoName .textAlignment = NSTextAlignmentCenter;
    
//     self.Driver2Button.backgroundColor = [UIColor yellowColor];
//
//    self.Driver1Button.backgroundColor = [UIColor yellowColor];
//     self.Driver1View.backgroundColor = [UIColor redColor];
//    self.Driver2View.backgroundColor = [UIColor redColor];
//
//    self.StaticGrafImage.backgroundColor = [UIColor redColor];
//
//    self.CustomNavigationView.backgroundColor = [UIColor redColor];
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];

    [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(deviceDidRotate:) name:UIDeviceOrientationDidChangeNotification object:nil];
    
    // Initial device orientation
    self.currentDeviceOrientation = [[UIDevice currentDevice] orientation];
    
    DM.mAppObj.checkslide = NO;
    
    DM.mAppObj.restrictRotation = NO;
    
    driverOne = [[SKUser alloc] init];
    [driverOne setupUser:[Helper mCurrentUser:kCurrentUserOne]];
    driverOneDetails = [[NSDictionary alloc]init];
    driverOneDetails = [Helper mCurrentUser:kCurrentUserOne];
    
    driverTwo = [[SKUser alloc] init];
    [driverTwo setupUser:[Helper mCurrentUser:kCurrentUserTwo]];
    driverTwoDetails = [[NSDictionary alloc]init];
    driverTwoDetails = [Helper mCurrentUser:kCurrentUserTwo];
    
    NSLog(@"Driver One   %@",driverOneDetails);
    NSLog(@"Driver Two   %@",driverTwoDetails);
    
    if ([driverOne.mExemptDriver isEqualToString:@"Yes"]) {
        
        self.Driver2View.hidden = YES ;
        self.mEditLogButton.hidden = YES ;
        self.mDriverOneTitleLabel.hidden = NO ;
        
    }
    if ([driverOne.mDriverType isEqualToString:kExempt_Driver]) {
        
        self.Driver2View.hidden = YES ;
        self.mEditLogButton.hidden = YES ;
        self.mDriverOneTitleLabel.hidden = NO ;
        
    }
    
    if ([DM.loginType isEqualToString:kLoginTypeSingle]) {
        
        self.mDriverOneTitleLabel.hidden = YES ;
        self.Driver2View.hidden = YES ;
        self.mDriverOneName.text = driverOne.mFirstName ;
        
        NSLog(@"%@=======%@",driverOne.mDriverType,kExempt_Driver);
        NSLog(@"%@=======%@",driverOne.mDriverType,kNon_Driver);

        if ([driverOne.mDriverType isEqualToString:kExempt_Driver]||[driverOne.mDriverType isEqualToString:kNon_Driver])
        {
            self.mEditLogButton.hidden = YES;
        }
        else{
            self.mEditLogButton.hidden = NO;
        }
        if ([driverOne.mDriverType isEqualToString:kExempt_Driver])
        {
            self.mDriverOneTitleLabel.hidden = NO;
        }
    }else{
        
        self.mDriverOneTitleLabel.hidden = YES ;
        self.Driver2View.hidden = NO ;
        self.mDriverOneName.text = driverOne.mFirstName ;
        NSLog(@"Driver One   %@",driverOne.mFirstName);
        self.mDriverTwoName.text = driverTwo.mFirstName ;
        NSLog(@"Driver Two   %@",driverTwo.mFirstName);
    }
    
    [self GetStatus];
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
}
-(void)SelectedRelation:(NSNotification *)notif{
    
    NSDictionary *dct = [notif userInfo];
    NSLog(@"%@",dct);
    NSLog(@"%@",[dct valueForKey:@"val"]);
    NSString * refString = [dct valueForKey:@"val"];
    [self PostDashBoardData:refString left_driving_time:@"0" left_time_for_break:@"0" break_elapsed_time:@"0" driving_elapsed_timing:@"0"];
    
}

-(void)PostDashBoardData:(NSString*)ref left_driving_time:(NSString *)left_driving_time left_time_for_break:(NSString *)left_time_for_break break_elapsed_time:(NSString *)break_elapsed_time driving_elapsed_timing:(NSString *)driving_elapsed_timing {
    
    self.StatusTitleLabel.hidden = YES;
//    left_driving_time = @"00:00:00";
//    driving_elapsed_timing = @"01:50:00";
//    
//    left_time_for_break = @"00:00:00";
//    break_elapsed_time = @"00:10:00";
    
    if ([teamStatusRef isEqualToString:kLoginTypeSingle]) {
       
        if ([ref isEqualToString:kStatusTypeDriving]) {
                self.StatusTitleLabel.hidden = YES;
                [self.mDriverOneStatusIV setImage:[UIImage imageNamed:@"drivingIcon"]];
                driverOneStatus = ref ;
                popUpRef = @"" ;
            
            [self TimerStartAndUpdate:[[self secondsForTimeString:left_driving_time]doubleValue] left_time_for_break:[[self secondsForTimeString:left_time_for_break]doubleValue] break_elapsed_time:[[self secondsForTimeString:break_elapsed_time]doubleValue] driving_elapsed_timing:[[self secondsForTimeString:driving_elapsed_timing]doubleValue]];
            
        }else if ([ref isEqualToString:kStatusTypeSleeper]){
                self.StatusTitleLabel.hidden = YES;
                [self.mDriverOneStatusIV setImage:[UIImage imageNamed:@"sleeperIcon"]];
                driverOneStatus = ref ;
                popUpRef = @"" ;
            
            
            [self ResetTimer:left_driving_time left_time_for_break:left_time_for_break break_elapsed_time:break_elapsed_time driving_elapsed_timing:driving_elapsed_timing];

        }else if ([ref isEqualToString:kStatusTypeOnDuty]){
                self.StatusTitleLabel.hidden = YES;
                [self.mDriverOneStatusIV setImage:[UIImage imageNamed:@"onDutyIcon"]];
                driverOneStatus = ref ;
            
            [self ResetTimer:left_driving_time left_time_for_break:left_time_for_break break_elapsed_time:break_elapsed_time driving_elapsed_timing:driving_elapsed_timing];

        }else if ([ref isEqualToString:kStatusTypeOffDuty]){
                self.StatusTitleLabel.hidden = YES;
                [self.mDriverOneStatusIV setImage:[UIImage imageNamed:@"offDutyIcon"]];
                driverOneStatus = ref ;
            
            [self ResetTimer:left_driving_time left_time_for_break:left_time_for_break break_elapsed_time:break_elapsed_time driving_elapsed_timing:driving_elapsed_timing];

        }else if ([ref isEqualToString:kStatusTypeEditLog]){
            [self ResetTimer:left_driving_time left_time_for_break:left_time_for_break break_elapsed_time:break_elapsed_time driving_elapsed_timing:driving_elapsed_timing];
                [self EditlogsButtonPush:driverOne.mDriverId];
            
        }
        
        if ([popUpRefPersonalUse isEqualToString:kOne]) {
            popUpRef = kStatusTypePersonalUse ;
            self.StatusTitleLabel.text = kStatusTypePersonalUse ;
            self.StatusTitleLabel.hidden = NO ;
            
            [self.mDriverOneStatusIV setImage:[UIImage imageNamed:@"offDutyIcon"]];
            driverOneStatus = ref ;

        }else if ([popUpRefYardMove isEqualToString:kOne]) {
            popUpRef = kStatusTypeYardMove ;
            self.StatusTitleLabel.text = kStatusTypeYardMove ;
            self.StatusTitleLabel.hidden = NO ;
            
            [self.mDriverOneStatusIV setImage:[UIImage imageNamed:@"onDutyIcon"]];
            driverOneStatus = ref ;

        }else{
            
            self.StatusTitleLabel.hidden = YES ;
            
        }
    }
    else{
        
        self.StatusTitleLabel.hidden = YES;
        if ([ref isEqualToString:kStatusTypeDriving]) {
            
                [self.mDriverTwoStatusIV setImage:[UIImage imageNamed:@"drivingIcon"]];
                driverTwoStatus = ref;

            [self TimerStartAndUpdate:[[self secondsForTimeString:left_driving_time]doubleValue] left_time_for_break:[[self secondsForTimeString:left_time_for_break]doubleValue] break_elapsed_time:[[self secondsForTimeString:break_elapsed_time]doubleValue] driving_elapsed_timing:[[self secondsForTimeString:driving_elapsed_timing]doubleValue]];


            
        }else if ([ref isEqualToString:kStatusTypeOnDuty]){
            
                [self.mDriverTwoStatusIV setImage:[UIImage imageNamed:@"onDutyIcon"]];
                driverTwoStatus = ref;

            [self ResetTimer:left_driving_time left_time_for_break:left_time_for_break break_elapsed_time:break_elapsed_time driving_elapsed_timing:driving_elapsed_timing];

            
        }else if ([ref isEqualToString:kStatusTypeOffDuty]){
            
                [self.mDriverTwoStatusIV setImage:[UIImage imageNamed:@"offDutyIcon"]];
                driverTwoStatus = ref;
            
            [self ResetTimer:left_driving_time left_time_for_break:left_time_for_break break_elapsed_time:break_elapsed_time driving_elapsed_timing:driving_elapsed_timing];

        }else if ([ref isEqualToString:kStatusTypeSleeper]){
            
                [self.mDriverTwoStatusIV setImage:[UIImage imageNamed:@"sleeperIcon"]];
                driverTwoStatus = ref;
            
            [self ResetTimer:left_driving_time left_time_for_break:left_time_for_break break_elapsed_time:break_elapsed_time driving_elapsed_timing:driving_elapsed_timing];

            
        }else if ([ref isEqualToString:kStatusTypeEditLog]){
            [self ResetTimer:left_driving_time left_time_for_break:left_time_for_break break_elapsed_time:break_elapsed_time driving_elapsed_timing:driving_elapsed_timing];
                [self EditlogsButtonPush:driverTwo.mDriverId];
        }
    }
}


-(void)viewWillDisappear:(BOOL)animated{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    if ([[UIDevice currentDevice] isGeneratingDeviceOrientationNotifications]) {
        [[UIDevice currentDevice] endGeneratingDeviceOrientationNotifications];
    }
    
    [super viewWillDisappear:YES];
    
    DM.mAppObj.restrictRotation = YES;
    [[UIDevice currentDevice] setValue:
     [NSNumber numberWithInteger: UIInterfaceOrientationPortrait]
                                forKey:@"orientation"];
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
}


-(IBAction)trayButtonAction:(id)sender {
    
   
    DM.mAppObj.restrictRotation = YES;
            [[UIDevice currentDevice] setValue:
             [NSNumber numberWithInteger: UIInterfaceOrientationPortrait]
                                        forKey:@"orientation"];
    
    
    
    
    [DM.mAppObj.mSlideVC showRightPanelAnimated:YES];
}


-(void)addmap{
    
#pragma mark--------------------------------------------------------------------
#pragma mark MAP Cordinats Settings Start
#pragma mark--------------------------------------------------------------------
   
    self.mMapView.showsUserLocation = YES;
    self.mMapView.mapType = MKMapTypeStandard;
    self.mMapView.delegate = self;
    [self.mMapView setScrollEnabled:NO];
    [self.mMapView setZoomEnabled:NO];
}
- (void)mapView:(MKMapView *)aMapView didUpdateUserLocation:(MKUserLocation *)aUserLocation {
    MKCoordinateRegion region;
    MKCoordinateSpan span;
    span.latitudeDelta = 0.010;
    span.longitudeDelta = 0.010;
    CLLocationCoordinate2D location;
    location.latitude = aUserLocation.coordinate.latitude;
    location.longitude = aUserLocation.coordinate.longitude;
    region.span = span;
    region.center = location;
    [aMapView setRegion:region animated:YES];
}




- (IBAction)Driver1StatusButtonAction:(id)sender {
    
    DM.mAppObj.restrictRotation = YES;
    [[UIDevice currentDevice] setValue:
     [NSNumber numberWithInteger: UIInterfaceOrientationPortrait]
                                forKey:@"orientation"];
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
    
    ChangeStatusVC *ChangeStatusPopUp = [self.storyboard instantiateViewControllerWithIdentifier:@"ChangeStatuView"];
    ChangeStatusPopUp.delegate = self;
    teamStatusRef = nil ;
    teamStatusRef = kLoginTypeSingle ;
    ChangeStatusPopUp.preSelectedRef = driverOneStatus;
    ChangeStatusPopUp.preSelectedStatusRef = kLoginTypeSingle;
    if ([popUpRefPersonalUse isEqualToString:kOne]) {
        ChangeStatusPopUp.preSelectedPopUpRef = kStatusTypePersonalUse ;
    }
    if ([popUpRefYardMove isEqualToString:kOne]) {
        ChangeStatusPopUp.preSelectedPopUpRef = kStatusTypeYardMove ;
    }
    ChangeStatusPopUp.driverId = driverOne.mDriverId ;
    ChangeStatusPopUp.driverPin = driverOne.mPinCode ;
    ChangeStatusPopUp.driverModel = driverOne ;
    ChangeStatusPopUp.driverTwoName = driverTwo.mFirstName ;
    ChangeStatusPopUp.OnutyStatus= driverTwoStatus ;
    
    
    ChangeStatusPopUp.flowRef = kCurrentUserOne;
    ChangeStatusPopUp.enterdPin = refPin;
    DM.driverStatusSelectionRef  = kCurrentUserOne ;
    [self presentPopupViewController:ChangeStatusPopUp animationType:MJPopupViewAnimationFade];
   // self.StatusTitleLabel.hidden = YES;
}

- (IBAction)Driver2StatusButtonAction:(id)sender {
    
    DM.mAppObj.restrictRotation = YES;
    [[UIDevice currentDevice] setValue:
     [NSNumber numberWithInteger: UIInterfaceOrientationPortrait]
                                forKey:@"orientation"];
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
    ChangeStatusVC *ChangeStatusPopUp = [self.storyboard instantiateViewControllerWithIdentifier:@"ChangeStatuView"];
    ChangeStatusPopUp.delegate = self;
    teamStatusRef = nil ;
    teamStatusRef = kLoginTypeTeam ;
    ChangeStatusPopUp.preSelectedRef = driverTwoStatus;
    ChangeStatusPopUp.preSelectedStatusRef = kLoginTypeTeam;
    ChangeStatusPopUp.preSelectedPopUpRef = popUpRefDriverTwo ;
    ChangeStatusPopUp.flowRef = kCurrentUserTwo;
    ChangeStatusPopUp.driverId = driverTwo.mDriverId ;
    ChangeStatusPopUp.driverPin = driverTwo.mPinCode ;
    ChangeStatusPopUp.driverModel = driverTwo ;
    ChangeStatusPopUp.driverTwoName = driverOne.mFirstName ;
    ChangeStatusPopUp.OnutyStatus= driverOneStatus ;

    ChangeStatusPopUp.enterdPin = refPin;
    DM.driverStatusSelectionRef  = kCurrentUserTwo;
    [self presentPopupViewController:ChangeStatusPopUp animationType:MJPopupViewAnimationFade];

}


- (void)ChangeStatuscancelButtonClicked:(ChangeStatusVC*)ChangeStatusViewController{
    [self dismissPopupViewControllerWithanimationType:MJPopupViewAnimationFade];
    [self GetStatus];
    
    DM.mAppObj.restrictRotation = NO;
    [[UIDevice currentDevice] setValue:
     [NSNumber numberWithInteger: UIInterfaceOrientationMaskAll]
                                forKey:@"orientation"];
}










- (IBAction)InspectLogButtonAction:(id)sender {
    [Helper movewithStoryBourdID:DM.mAppObj.mBaseNavigation Id:@"InspectLogVC" animation:NO];

    
}

- (IBAction)EditLogButtonAction:(id)sender {

    [self EditlogsButtonPush:nil];
}

-(void)EditlogsButtonPush:(NSString *)driverID{
    
        EditLogsVC * vc = [self.storyboard instantiateViewControllerWithIdentifier:@"EditLogsVC"];
        vc.msg =driverID;
        [self.navigationController pushViewController:vc animated:YES ];
}

- (IBAction)DocumentsButtonAction:(id)sender {
    DocsVC * vc = [self.storyboard instantiateViewControllerWithIdentifier:@"DocsVC"];
    [self.navigationController pushViewController:vc animated:YES ];
}


-(void)GetStatus{
    
    NSString * path = [NSString stringWithFormat:@"%@getDashboardData",kServiceBaseURL];
   // path = [path stringByReplacingOccurrencesOfString:@"/app/" withString:@"/AppTest/"];

    NSMutableDictionary * parameter = [[NSMutableDictionary alloc]init];
    [parameter setValue:DM.loginType forKey:@"loginType"];
    [parameter setValue:driverOne.mDriverId forKey:@"driverId1"];
    [parameter setValue:driverTwo.mDriverId forKey:@"driverId2"];

    
    [DM PostRequest:path parameter:parameter onCompletion:^(id  _Nullable dict) {
        
        NSError *errorJson=nil;
        NSDictionary* responseDict = [NSJSONSerialization JSONObjectWithData:dict options:kNilOptions error:&errorJson];
        NSLog(@"%@",responseDict);
        if ([DM.loginType isEqualToString:kLoginTypeSingle]) {
                NSMutableDictionary * dictOne = [[NSMutableDictionary alloc]init];
                dictOne = [[responseDict valueForKey:@"driver"]objectAtIndex:0];
                NSString *modeString  = [dictOne valueForKey:@"mode"];
                teamStatusRef = kLoginTypeSingle;
            
             popUpRefPersonalUse = [NSString stringWithFormat:@"%@",[dictOne valueForKey:@"personal_use"]];
             popUpRefYardMove = [NSString stringWithFormat:@"%@",[dictOne valueForKey:@"yard_move"]];
                [self PostDashBoardData:modeString left_driving_time:[dictOne valueForKey:@"left_driving_time"] left_time_for_break:[dictOne valueForKey:@"left_time_for_break"] break_elapsed_time:[dictOne valueForKey:@"break_elapsed_time"] driving_elapsed_timing:[dictOne valueForKey:@"driving_elapsed_timing"]];
            
            NSString * previousPersonalUseAuth = [NSString stringWithFormat:@"%@",[dictOne valueForKey:@"prePersonalUseAuth"]];
            NSString * PersonalUseAuth = [NSString stringWithFormat:@"%@",[dictOne valueForKey:@"personalUseAuth"]];
            NSString * previousYardMoveAuth = [NSString stringWithFormat:@"%@",[dictOne valueForKey:@"preYardMoveAuth"]];
            NSString * yardMoveAuth  = [NSString stringWithFormat:@"%@",[dictOne valueForKey:@"yardMoveAuth"]];
            
            
            NSString *iscertifiedcountAuth  = [NSString stringWithFormat:@"%@",[dictOne valueForKey:@"iscertifiedcount"]];
            NSString *UncertifiedDvirCountAuth  = [NSString stringWithFormat:@"%@",[dictOne valueForKey:@"UncertifiedDvirCount"]];
            
            
            DM.iscertifiedcountAuth1_Global = [NSString stringWithFormat:@"%@",[dictOne valueForKey:@"iscertifiedcount"]];
            DM.iscertifiedUsername1_Global = [NSString stringWithFormat:@"%@",[dictOne valueForKey:@"first_name"]];
            
            
            
            
            
            if ([iscertifiedcountAuth integerValue] > 0 ) {
                if (![DM.checkForAlerts isEqualToString:kYes]) {
                    iscertifiedAlert = [[UIAlertView alloc]                                               initWithTitle:[driverOne.mFirstName uppercaseString] message:[NSString stringWithFormat:@"You have %@ uncertified logs \n Would you like to Certify now?",iscertifiedcountAuth] delegate:self cancelButtonTitle:@"Yes" otherButtonTitles:@"No",nil];
                    iscertifiedAlert.tag = 1025;
                    [iscertifiedAlert show];
                    
                }

            }
            if ([UncertifiedDvirCountAuth integerValue] > 0 ) {
                
                if (![DM.checkForAlerts isEqualToString:kYes]) {
                    UncertifiedDvirAlert = [[UIAlertView alloc]                                               initWithTitle:[driverOne.mFirstName uppercaseString]  message:[NSString stringWithFormat:@"You have uncertified DVIR of %@ Days \n Would you like to Certify now?",UncertifiedDvirCountAuth] delegate:self cancelButtonTitle:@"Yes" otherButtonTitles:@"No",nil];
                    UncertifiedDvirAlert.tag = 1024;
                    [UncertifiedDvirAlert show];
                }
            }
            
            

            
            
            
            
            if ([popUpRefPersonalUse isEqualToString:kOne]) {
                NSLog(@"%@",DM.checkForAlerts);
                

                if (![DM.checkForAlerts isEqualToString:kYes]) {
                    
                    [personalUseAlert show];
                }
            }
            if (![previousPersonalUseAuth isEqualToString:PersonalUseAuth]) {
                
                [[NSUserDefaults standardUserDefaults] removeObjectForKey:kCurrentUserOne];
                SKUser *currentUser = [[SKUser alloc] init];
                [currentUser setupCurrentUser:dictOne driverName:kCurrentUserOne];
                
                if ([PersonalUseAuth isEqualToString:kYes]) {
                    UIAlertView *errorAlert = [[UIAlertView alloc]
                                               initWithTitle:driverOne.mFirstName message:@"You now have the ability to do Personal Use" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                    NSLog(@"%@",DM.checkForAlerts);

                    if ([DM.checkForAlerts isEqualToString:kYes]) {
                        [errorAlert show];
                        [[NSUserDefaults standardUserDefaults] removeObjectForKey:kCurrentUserOne];
                        SKUser *currentUser = [[SKUser alloc] init];
                        [currentUser setupCurrentUser:dictOne driverName:kCurrentUserOne];
                        driverOne = [[SKUser alloc]init];
                        [driverOne setupUser:[Helper mCurrentUser:kCurrentUserOne]];
                    }
                    
                }else{
                    UIAlertView *errorAlert = [[UIAlertView alloc]
                                               initWithTitle:driverOne.mFirstName message:@"You now don’t have the ability to do Personal Use" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                    NSLog(@"%@",DM.checkForAlerts);
                    
                    if ([DM.checkForAlerts isEqualToString:kYes]) {
                        [errorAlert show];
                        [[NSUserDefaults standardUserDefaults] removeObjectForKey:kCurrentUserOne];
                        SKUser *currentUser = [[SKUser alloc] init];
                        [currentUser setupCurrentUser:dictOne driverName:kCurrentUserOne];
                        driverOne = [[SKUser alloc]init];
                        [driverOne setupUser:[Helper mCurrentUser:kCurrentUserOne]];
                    }
                    
                }
            }
            if (![previousYardMoveAuth isEqualToString:yardMoveAuth]) {
                [[NSUserDefaults standardUserDefaults] removeObjectForKey:kCurrentUserOne];
                SKUser *currentUser = [[SKUser alloc] init];
                [currentUser setupCurrentUser:dictOne driverName:kCurrentUserOne];
                
                if ([yardMoveAuth isEqualToString:kYes]) {
                    UIAlertView *errorAlert = [[UIAlertView alloc]
                                               initWithTitle:driverOne.mFirstName message:@"You now have the ability to do Yard Moves" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                    NSLog(@"%@",DM.checkForAlerts);

                    if ([DM.checkForAlerts isEqualToString:kYes]) {
                        [errorAlert show];
                        [[NSUserDefaults standardUserDefaults] removeObjectForKey:kCurrentUserOne];
                        SKUser *currentUser = [[SKUser alloc] init];
                        [currentUser setupCurrentUser:dictOne driverName:kCurrentUserOne];
                        driverOne = [[SKUser alloc]init];
                        [driverOne setupUser:[Helper mCurrentUser:kCurrentUserOne]];
                    }
                    
                }
                else{
                    UIAlertView *errorAlert = [[UIAlertView alloc]
                                               initWithTitle:driverOne.mFirstName message:@"You now don’t have the ability to do Yard Moves" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                    NSLog(@"%@",DM.checkForAlerts);

                    if ([DM.checkForAlerts isEqualToString:kYes]) {
                        [errorAlert show];
                        [[NSUserDefaults standardUserDefaults] removeObjectForKey:kCurrentUserOne];
                        SKUser *currentUser = [[SKUser alloc] init];
                        [currentUser setupCurrentUser:dictOne driverName:kCurrentUserOne];
                        driverOne = [[SKUser alloc]init];
                        [driverOne setupUser:[Helper mCurrentUser:kCurrentUserOne]];
                    }
                    
                    
                }
            }
            
            
            
           

            
            }else{

                NSMutableDictionary * dictOne = [[NSMutableDictionary alloc]init];
                dictOne = [[responseDict valueForKey:@"driver"]objectAtIndex:0];;
                teamStatusRef = kLoginTypeSingle;
                NSString *modeStringOne  = [dictOne valueForKey:@"mode"];
                
                [self PostDashBoardData:modeStringOne left_driving_time:[dictOne valueForKey:@"left_driving_time"] left_time_for_break:[dictOne valueForKey:@"left_time_for_break"] break_elapsed_time:[dictOne valueForKey:@"break_elapsed_time"] driving_elapsed_timing:[dictOne valueForKey:@"driving_elapsed_timing"]];

                NSMutableDictionary * dictTwo = [[NSMutableDictionary alloc]init];
                dictTwo = [[responseDict valueForKey:@"driver"]objectAtIndex:1];;
                teamStatusRef = kLoginTypeTeam;
                NSString *modeStringTwo  = [dictTwo valueForKey:@"mode"];
                
                
                [self PostDashBoardData:modeStringTwo left_driving_time:[dictTwo valueForKey:@"left_driving_time"] left_time_for_break:[dictTwo valueForKey:@"left_time_for_break"] break_elapsed_time:[dictTwo valueForKey:@"break_elapsed_time"] driving_elapsed_timing:[dictTwo valueForKey:@"driving_elapsed_timing"]];

                
                NSString * previousPersonalUseAuth1 = [NSString stringWithFormat:@"%@",[dictOne valueForKey:@"prePersonalUseAuth"]];
                NSString * PersonalUseAuth1 = [NSString stringWithFormat:@"%@",[dictOne valueForKey:@"personalUseAuth"]];
                NSString * previousYardMoveAuth1 = [NSString stringWithFormat:@"%@",[dictOne valueForKey:@"preYardMoveAuth"]];
                NSString * yardMoveAuth1  = [NSString stringWithFormat:@"%@",[dictOne valueForKey:@"yardMoveAuth"]];
                
                NSString *iscertifiedcountAuth  = [NSString stringWithFormat:@"%@",[dictOne valueForKey:@"iscertifiedcount"]];
                NSString *UncertifiedDvirCountAuth  = [NSString stringWithFormat:@"%@",[dictOne valueForKey:@"UncertifiedDvirCount"]];
                
                
                
                DM.iscertifiedcountAuth1_Global = [NSString stringWithFormat:@"%@",[dictOne valueForKey:@"iscertifiedcount"]];
                DM.iscertifiedUsername1_Global = [NSString stringWithFormat:@"%@",[dictOne valueForKey:@"first_name"]];
                
               
                
                

                
                if (![previousPersonalUseAuth1 isEqualToString:PersonalUseAuth1]) {
                    
                    [[NSUserDefaults standardUserDefaults] removeObjectForKey:kCurrentUserOne];
                    SKUser *currentUser = [[SKUser alloc] init];
                    [currentUser setupCurrentUser:dictOne driverName:kCurrentUserOne];
                    
                    if ([PersonalUseAuth1 isEqualToString:kYes]) {
                        UIAlertView *errorAlert = [[UIAlertView alloc]
                                                   initWithTitle:driverOne.mFirstName message:@"You now have the ability to do Personal Use" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                        if ([DM.checkForAlerts isEqualToString:kYes]) {
                            [errorAlert show];
                            [[NSUserDefaults standardUserDefaults] removeObjectForKey:kCurrentUserOne];
                            SKUser *currentUser = [[SKUser alloc] init];
                            [currentUser setupCurrentUser:dictOne driverName:kCurrentUserOne];
                            driverOne = [[SKUser alloc]init];
                            [driverOne setupUser:[Helper mCurrentUser:kCurrentUserOne]];
                        }
                        
                    }else{
                        UIAlertView *errorAlert = [[UIAlertView alloc]
                                                   initWithTitle:driverOne.mFirstName message:@"You now don’t have the ability to do Personal Use" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                        if ([DM.checkForAlerts isEqualToString:kYes]) {
                            [errorAlert show];
                            [[NSUserDefaults standardUserDefaults] removeObjectForKey:kCurrentUserOne];
                            SKUser *currentUser = [[SKUser alloc] init];
                            [currentUser setupCurrentUser:dictOne driverName:kCurrentUserOne];
                            driverOne = [[SKUser alloc]init];
                            [driverOne setupUser:[Helper mCurrentUser:kCurrentUserOne]];
                        }
                        
                    }
                }
                if (![previousYardMoveAuth1 isEqualToString:yardMoveAuth1]) {
                    [[NSUserDefaults standardUserDefaults] removeObjectForKey:kCurrentUserOne];
                    SKUser *currentUser = [[SKUser alloc] init];
                    [currentUser setupCurrentUser:dictOne driverName:kCurrentUserOne];
                    
                    if ([yardMoveAuth1 isEqualToString:kYes]) {
                        UIAlertView *errorAlert = [[UIAlertView alloc]
                                                   initWithTitle:driverOne.mFirstName message:@"You now have the ability to do Yard Moves" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                        if ([DM.checkForAlerts isEqualToString:kYes]) {
                            [errorAlert show];
                            [[NSUserDefaults standardUserDefaults] removeObjectForKey:kCurrentUserOne];
                            SKUser *currentUser = [[SKUser alloc] init];
                            [currentUser setupCurrentUser:dictOne driverName:kCurrentUserOne];
                            driverOne = [[SKUser alloc]init];
                            [driverOne setupUser:[Helper mCurrentUser:kCurrentUserOne]];
                        }
                        
                    }
                    else{
                        UIAlertView *errorAlert = [[UIAlertView alloc]
                                                   initWithTitle:driverOne.mFirstName message:@"You now don’t have the ability to do Yard Moves" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                        if ([DM.checkForAlerts isEqualToString:kYes]) {
                            [errorAlert show];
                            [[NSUserDefaults standardUserDefaults] removeObjectForKey:kCurrentUserOne];
                            SKUser *currentUser = [[SKUser alloc] init];
                            [currentUser setupCurrentUser:dictOne driverName:kCurrentUserOne];
                            driverOne = [[SKUser alloc]init];
                            [driverOne setupUser:[Helper mCurrentUser:kCurrentUserOne]];
                        }
                        
                    }
                }
                
                NSString * previousPersonalUseAuth2 = [NSString stringWithFormat:@"%@",[dictTwo valueForKey:@"prePersonalUseAuth"]];
                NSString * PersonalUseAuth2 = [NSString stringWithFormat:@"%@",[dictTwo valueForKey:@"personalUseAuth"]];
                NSString * previousYardMoveAuth2 = [NSString stringWithFormat:@"%@",[dictTwo valueForKey:@"preYardMoveAuth"]];
                NSString * yardMoveAuth2  = [NSString stringWithFormat:@"%@",[dictTwo valueForKey:@"yardMoveAuth"]];
                
                NSString *iscertifiedcountAuth2  = [NSString stringWithFormat:@"%@",[dictTwo valueForKey:@"iscertifiedcount"]];
                NSString *UncertifiedDvirCountAuth2  = [NSString stringWithFormat:@"%@",[dictTwo valueForKey:@"UncertifiedDvirCount"]];
                
                
                DM.iscertifiedcountAuth2_Global = [NSString stringWithFormat:@"%@",[dictTwo valueForKey:@"iscertifiedcount"]];
                DM.iscertifiedUsername2_Global = [NSString stringWithFormat:@"%@",[dictTwo valueForKey:@"first_name"]];
                
                
                if (![previousPersonalUseAuth2 isEqualToString:PersonalUseAuth2]) {
                    
                    [[NSUserDefaults standardUserDefaults] removeObjectForKey:kCurrentUserTwo];
                    SKUser *currentUser = [[SKUser alloc] init];
                    [currentUser setupCurrentUser:dictTwo driverName:kCurrentUserTwo];
                    
                    if ([PersonalUseAuth2 isEqualToString:kYes]) {
                        UIAlertView *errorAlert = [[UIAlertView alloc]
                                                   initWithTitle:driverTwo.mFirstName message:@"You now have the ability to do Personal Use" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                        if ([DM.checkForAlerts isEqualToString:kYes]) {
                            [errorAlert show];
                            [[NSUserDefaults standardUserDefaults] removeObjectForKey:kCurrentUserTwo];
                            SKUser *currentUser = [[SKUser alloc] init];
                            [currentUser setupCurrentUser:dictTwo driverName:kCurrentUserTwo];
                            driverTwo = [[SKUser alloc]init];
                            [driverTwo setupUser:[Helper mCurrentUser:kCurrentUserTwo]];
                        }
                        
                    }else{
                        UIAlertView *errorAlert = [[UIAlertView alloc]
                                                   initWithTitle:driverTwo.mFirstName message:@"You now don’t have the ability to do Personal Use" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                        if ([DM.checkForAlerts isEqualToString:kYes]) {
                            [errorAlert show];
                            [[NSUserDefaults standardUserDefaults] removeObjectForKey:kCurrentUserTwo];
                            SKUser *currentUser = [[SKUser alloc] init];
                            [currentUser setupCurrentUser:dictTwo driverName:kCurrentUserTwo];
                            driverTwo = [[SKUser alloc]init];
                            [driverTwo setupUser:[Helper mCurrentUser:kCurrentUserTwo]];
                        }
                    }
                }
                if (![previousYardMoveAuth2 isEqualToString:yardMoveAuth2]) {
                    [[NSUserDefaults standardUserDefaults] removeObjectForKey:kCurrentUserTwo];
                    SKUser *currentUser = [[SKUser alloc] init];
                    [currentUser setupCurrentUser:dictTwo driverName:kCurrentUserTwo];
                    
                    if ([yardMoveAuth2 isEqualToString:kYes]) {
                        UIAlertView *errorAlert = [[UIAlertView alloc]
                                                   initWithTitle:driverTwo.mFirstName message:@"You now have the ability to do Yard Moves" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                        if ([DM.checkForAlerts isEqualToString:kYes]) {
                            [errorAlert show];
                            [[NSUserDefaults standardUserDefaults] removeObjectForKey:kCurrentUserTwo];
                            SKUser *currentUser = [[SKUser alloc] init];
                            [currentUser setupCurrentUser:dictTwo driverName:kCurrentUserTwo];
                            driverTwo = [[SKUser alloc]init];
                            [driverTwo setupUser:[Helper mCurrentUser:kCurrentUserTwo]];
                        }
                        
                    }
                    else{
                        UIAlertView *errorAlert = [[UIAlertView alloc]
                                                   initWithTitle:driverTwo.mFirstName message:@"You now don’t have the ability to do Yard Moves" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                        if ([DM.checkForAlerts isEqualToString:kYes]) {
                            [errorAlert show];
                            [[NSUserDefaults standardUserDefaults] removeObjectForKey:kCurrentUserTwo];
                            SKUser *currentUser = [[SKUser alloc] init];
                            [currentUser setupCurrentUser:dictTwo driverName:kCurrentUserTwo];
                            driverTwo = [[SKUser alloc]init];
                            [driverTwo setupUser:[Helper mCurrentUser:kCurrentUserTwo]];
                        }
                    }
                }
                
                
               
                
                if (([iscertifiedcountAuth integerValue] > 0) && ([iscertifiedcountAuth2 integerValue] > 0)) {
                    if (![DM.checkForAlerts isEqualToString:kYes]) {
                        iscertifiedAlert = [[UIAlertView alloc]                                               initWithTitle:@"" message:[NSString stringWithFormat:@"%@:You have %@ uncertified logs \n %@:You have %@ uncertified logs \n \n Would you like to Certify now?",[driverOne.mFirstName uppercaseString],iscertifiedcountAuth,[driverTwo.mFirstName uppercaseString],iscertifiedcountAuth2] delegate:self cancelButtonTitle:@"Yes" otherButtonTitles:@"No",nil];
                        iscertifiedAlert.tag = 1025;
                        [iscertifiedAlert show];
                        
                    }
                    
                }
                else if ([iscertifiedcountAuth integerValue] > 0){
                    
                    if (![DM.checkForAlerts isEqualToString:kYes]) {
                        iscertifiedAlert = [[UIAlertView alloc]                                               initWithTitle:@"" message:[NSString stringWithFormat:@"%@:You have %@ uncertified logs \n \n Would you like to Certify now?",[driverOne.mFirstName uppercaseString],iscertifiedcountAuth] delegate:self cancelButtonTitle:@"Yes" otherButtonTitles:@"No",nil];
                        iscertifiedAlert.tag = 1025;
                        [iscertifiedAlert show];
                        
                    }
                    
                }
                else if ([iscertifiedcountAuth2 integerValue] > 0){
                    
                    if (![DM.checkForAlerts isEqualToString:kYes]) {
                        iscertifiedAlert = [[UIAlertView alloc]                                               initWithTitle:@"" message:[NSString stringWithFormat:@"%@:You have %@ uncertified logs \n \n Would you like to Certify now?",[driverTwo.mFirstName uppercaseString],iscertifiedcountAuth2] delegate:self cancelButtonTitle:@"Yes" otherButtonTitles:@"No",nil];
                        iscertifiedAlert.tag = 1025;
                        [iscertifiedAlert show];
                        
                    }
                    
                }
                
                if (([UncertifiedDvirCountAuth integerValue] > 0) && ([UncertifiedDvirCountAuth2 integerValue] > 0)) {
                    
                    if (![DM.checkForAlerts isEqualToString:kYes]) {
                        UncertifiedDvirAlert = [[UIAlertView alloc]                                               initWithTitle:@"" message:[NSString stringWithFormat:@"%@:You have uncertified DVIR of %@ Days \n %@:You have uncertified DVIR of %@ Days \n  \n Would you like to Certify now?",[driverOne.mFirstName uppercaseString] ,UncertifiedDvirCountAuth,[driverTwo.mFirstName uppercaseString],UncertifiedDvirCountAuth2] delegate:self cancelButtonTitle:@"Yes" otherButtonTitles:@"No",nil];
                        UncertifiedDvirAlert.tag = 1024;
                        [UncertifiedDvirAlert show];
                    }
                }
                else if ([UncertifiedDvirCountAuth integerValue] > 0){
                    if (![DM.checkForAlerts isEqualToString:kYes]) {
                        UncertifiedDvirAlert = [[UIAlertView alloc]                                               initWithTitle:@"" message:[NSString stringWithFormat:@"%@:You have uncertified DVIR of %@ Days \n\n Would you like to Certify now?",[driverOne.mFirstName uppercaseString] ,UncertifiedDvirCountAuth] delegate:self cancelButtonTitle:@"Yes" otherButtonTitles:@"No",nil];
                        UncertifiedDvirAlert.tag = 1024;
                        [UncertifiedDvirAlert show];
                    }
                    
                }
                else if ([UncertifiedDvirCountAuth2 integerValue] > 0){
                    if (![DM.checkForAlerts isEqualToString:kYes]) {
                        UncertifiedDvirAlert = [[UIAlertView alloc]                                               initWithTitle:@"" message:[NSString stringWithFormat:@"%@:You have uncertified DVIR of %@ Days \n\n Would you like to Certify now?",[driverTwo.mFirstName uppercaseString],UncertifiedDvirCountAuth2] delegate:self cancelButtonTitle:@"Yes" otherButtonTitles:@"No",nil];
                        UncertifiedDvirAlert.tag = 1024;
                        [UncertifiedDvirAlert show];
                    }
                    
                }
                
                
                
                
            }
        checkOne = @"yes";
        //DM.checkForAlerts = kYes ;
        
        NSUserDefaults *checkForAlerts = [NSUserDefaults standardUserDefaults];
        [checkForAlerts setObject:kYes forKey:kCheckForAlerts];
        [checkForAlerts synchronize];
        NSLog(@"checkForAlerts kYes");
        DM.checkForAlerts = [[NSUserDefaults standardUserDefaults] valueForKey:kCheckForAlerts];
        
        
    } onError:^(NSError * _Nullable Error) {
        NSLog(@"%@",Error);
        NSString *ErrorString = [NSString stringWithFormat:@"%@",Error];
        //[Helper ISAlertTypeError:@"Error!!" andMessage:ErrorString];
    }];

    
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    if (alertView.tag == 1027) {
        if (buttonIndex == 1) {
            [self Driver1StatusButtonAction:self];
        }
    }
    else if (alertView.tag == 1025) {
        if (buttonIndex == 0) {
            [self EditLogButtonAction:self];
        }
    }
    else if (alertView.tag == 1024) {
        if (buttonIndex == 0) {
            [Helper movewithStoryBourdID:DM.mAppObj.mBaseNavigation Id:@"DVIRVC" animation:NO];
        }
    }

    
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
    
    NSLog(@"%d",DM.mAppObj.restrictRotation);
    
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

- (IBAction)DashBoardPressedButtonAction:(id)sender{
    
    DM.mAppObj.restrictRotation = YES;
    [[UIDevice currentDevice] setValue:
     [NSNumber numberWithInteger: UIInterfaceOrientationPortrait]
                                forKey:@"orientation"];
    
    DashBoardPressedVC *DashBoardPressedUp = [self.storyboard instantiateViewControllerWithIdentifier:@"DashBoardPressedView"];
    DashBoardPressedUp.mDriverId = driverOne.mDriverId;
    DashBoardPressedUp.delegate = self;
    [self presentPopupViewController:DashBoardPressedUp animationType:MJPopupViewAnimationFade];

}
- (void)DashboardPressedCancelButtonClicked:(DashBoardPressedVC*)DashboardViewController{
    
    NSLog(@"%d",DM.mAppObj.restrictRotation);
    
    DM.mAppObj.restrictRotation = NO;
    
    [[UIDevice currentDevice] setValue:
              [NSNumber numberWithInteger: UIInterfaceOrientationMaskAll]
                                         forKey:@"orientation"];
    
    

    
        
    
    [self dismissPopupViewControllerWithanimationType:MJPopupViewAnimationFade];
}

-(IBAction)MapButtonAction:(id)sender{
    CLLocationCoordinate2D center = [DM getLocation];
    CLLocationCoordinate2D northEast = CLLocationCoordinate2DMake(center.latitude + 0.001,
                                                                  center.longitude + 0.001);
    CLLocationCoordinate2D southWest = CLLocationCoordinate2DMake(center.latitude - 0.001,
                                                                  center.longitude - 0.001);
    GMSCoordinateBounds *viewport = [[GMSCoordinateBounds alloc] initWithCoordinate:northEast
                                                                         coordinate:southWest];
    GMSPlacePickerConfig *config = [[GMSPlacePickerConfig alloc] initWithViewport:viewport];
    GMSPlacePickerViewController *placePicker =
    [[GMSPlacePickerViewController alloc] initWithConfig:config];
    placePicker.delegate = self;
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:center.latitude
                                                            longitude:center.longitude
                                                                 zoom:6];
    GMSMapView *goomapView = [GMSMapView mapWithFrame:CGRectZero camera:camera];
    goomapView.mapType = kGMSTypeSatellite;
    [self presentViewController:placePicker animated:YES completion:nil];
}

- (void)placePicker:(GMSPlacePickerViewController *)viewController didPickPlace:(GMSPlace *)place {
    NSLog(@"Place name %@", place.name);
    NSLog(@"Place address %@", place.formattedAddress);
    NSLog(@"Place attributions %@", place.attributions.string);
}

- (void)placePickerDidCancel:(GMSPlacePickerViewController *)viewController {
    [viewController dismissViewControllerAnimated:YES completion:nil];
    NSLog(@"No place selected");
}


@end
