//
//  MsgPopUpVC.h
//  Basic ELD
//
//  Created by Manoj Gadamsetty on 16/09/17.
//  Copyright © 2017 Gaurav Verma. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MsgPopUpVC : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *MsgLabel;
- (IBAction)CloseButtonTap:(id)sender;
- (IBAction)SubmitButtonTap:(id)sender;
@end
