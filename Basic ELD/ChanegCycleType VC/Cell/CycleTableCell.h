//
//  CycleTableCell.h
//  Basic ELD
//
//  Created by Manoj Gadamsetty on 19/09/17.
//  Copyright © 2017 Gaurav Verma. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CycleTableCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *mTitleLabel;
@property (weak, nonatomic) IBOutlet UITextField *mTextField;
@property (weak, nonatomic) IBOutlet UIImageView *mDropDownIV;
@property (weak, nonatomic) IBOutlet UIImageView *mBGIV;

@end
