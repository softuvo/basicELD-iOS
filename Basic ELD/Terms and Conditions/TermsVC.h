//
//  TermsVC.h
//  Basic ELD
//
//  Created by Manoj Gadamsetty on 19/09/17.
//  Copyright © 2017 Gaurav Verma. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataManager.h"

@interface TermsVC : UIViewController


- (IBAction)BackButtonAction:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *mTitleLabel;
@property (weak, nonatomic) IBOutlet UITextView *mContentView;

@end
