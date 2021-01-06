//
//  InspectLogVC.h
//  Basic ELD
//
//  Created by Gaurav Verma on 09/10/17.
//  Copyright © 2017 Gaurav Verma. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
@interface InspectLogVC : UIViewController<MFMailComposeViewControllerDelegate>
- (IBAction)BackButtonAction:(id)sender;
- (IBAction)SendEmailButtonAction:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *mHeaderView;
@property (weak, nonatomic) IBOutlet UILabel *mDriverNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *mVehicalNumberLabel;
@property (weak, nonatomic) IBOutlet UIProgressView *mProgressiveBar;
@property (weak, nonatomic) IBOutlet UILabel *mErrorTypeLabel;

@end
