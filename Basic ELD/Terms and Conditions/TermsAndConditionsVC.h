//
//  TermsAndConditionsVC.h
//  Basic ELD
//
//  Created by Manoj Gadamsetty on 28/08/17.
//  Copyright © 2017 Gaurav Verma. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TermsAndConditionsVC : UIViewController
@property (weak, nonatomic) IBOutlet UIView *mHeaderView;
@property (weak, nonatomic) IBOutlet UILabel *mDriverNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *mVehicalNumberLabel;
@property (weak, nonatomic) IBOutlet UIProgressView *mProgressiveBar;
@property (weak, nonatomic) IBOutlet UILabel *mErrorTypeLabel;

@property (weak , nonatomic) NSString * msg ;

@property (weak, nonatomic) IBOutlet UILabel *mTitleLabel;
@property (weak, nonatomic) IBOutlet UITextView *mContentView;
- (IBAction)BackButtonAction:(id)sender;
@end
