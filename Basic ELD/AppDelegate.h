//
//  AppDelegate.h
//  Basic ELD
//
//  Created by Gaurav Verma on 04/05/17.
//  Copyright © 2017 Gaurav Verma. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Helper.h"
#import "DataManager.h"
#import "JASidePanelController.h"
#import "SKUser.h"
#import "ARSPContainerController.h"
#import <Fabric/Fabric.h>
#import <Crashlytics/Crashlytics.h>

@import GooglePlaces;
@import GoogleMaps;


@class SKSliderVC;
@class SKLoginVC;
@class ViewController;
@class DMSlider;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property(nonatomic,retain) JASidePanelController *mSlideVC;
@property(nonatomic,strong) SKSliderVC *mLeftPanelSlider;
@property (strong, nonatomic) ViewController *mDashboard;
@property (nonatomic,strong) SKLoginVC *loginVC;

@property () BOOL restrictRotation;

@property () BOOL checkslide;


@property (nonatomic,strong) UIStoryboard *mainStoryboard;
@property (nonatomic,strong) UINavigationController *mBaseNavigation;




-(void)logout;
-(void)checkLogin;

@end

