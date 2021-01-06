//
//  DashBoardPressedVC.h
//  Basic ELD
//
//  Created by Gaurav Verma on 27/10/17.
//  Copyright © 2017 Gaurav Verma. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Constants.h"
#import "Helper.h"
#import "DataManager.h"
#import "AppDelegate.h"

@protocol DashboardPressedPopupDelegate;
@interface DashBoardPressedVC : UIViewController

@property (assign, nonatomic) id <DashboardPressedPopupDelegate>delegate;
@property (strong, nonatomic)  NSString *mDriverId;
@property (strong, nonatomic) IBOutlet UILabel *mdriving_time;
@property (strong, nonatomic) IBOutlet UILabel *mdriving_time_elapsed;
@property (strong, nonatomic) IBOutlet UILabel *mdriving_time_remaining;
@property (strong, nonatomic) IBOutlet UILabel *mmiles_driven;
@property (strong, nonatomic) IBOutlet UILabel *moffduty_time;
@property (strong, nonatomic) IBOutlet UILabel *monduty_time;
@property (strong, nonatomic) IBOutlet UILabel *msleeping_time;


@end
@protocol DashboardPressedPopupDelegate<NSObject>
@optional
- (void)DashboardPressedCancelButtonClicked:(DashBoardPressedVC*)DashboardViewController;

@end




