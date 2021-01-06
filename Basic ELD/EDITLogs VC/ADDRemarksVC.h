//
//  ADDRemarksVC.h
//  Basic ELD
//
//  Created by Manoj Gadamsetty on 11/09/17.
//  Copyright © 2017 Gaurav Verma. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import "DataManager.h"
#import "IQKeyboardManager.h"


@interface ADDRemarksVC : UIViewController<CLLocationManagerDelegate>


//Header View
@property (weak, nonatomic) IBOutlet UIView *mHeaderView;
@property (weak, nonatomic) IBOutlet UILabel *mDriverName;
@property (weak, nonatomic) IBOutlet UILabel *mVehicleNumber;
@property (weak, nonatomic) IBOutlet UIProgressView *mProgressBar;
@property (weak, nonatomic) IBOutlet UILabel *mErrorsLabel;

@property (strong, nonatomic) NSString  *driverId;
@property (strong, nonatomic) NSString  *selectedDate;

- (IBAction)BackButtonAction:(id)sender;
- (IBAction)CurrentLocationButtonTap:(id)sender;
- (IBAction)CancelBUttonTap:(id)sender;
- (IBAction)SaveButtonTap:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *mCurrentLocationButton;
@property (weak, nonatomic) IBOutlet UITextField *mStartTimeTF;
@property (weak, nonatomic) IBOutlet UITextField *mLocationTF;
@property (weak, nonatomic) IBOutlet UITextField *mNotesTF;




@end
