//
//  PinPopUpVC.h
//  Basic ELD
//
//  Created by Manoj Gadamsetty on 16/09/17.
//  Copyright © 2017 Gaurav Verma. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataManager.h"

@interface PinPopUpVC : UIViewController



@property (strong, nonatomic) IBOutlet UITextField *pin1TF;
@property (strong, nonatomic) IBOutlet UITextField *pin2TF;
@property (strong, nonatomic) IBOutlet UITextField *pin3TF;
@property (strong, nonatomic) IBOutlet UITextField *pin4TF;

@property (strong, nonatomic)  NSString * pin;

- (IBAction)CFPinCloseButtonAction:(id)sender;


@end
