//
//  EditCell.h
//  Basic ELD
//
//  Created by Manoj Gadamsetty on 01/09/17.
//  Copyright © 2017 Gaurav Verma. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EditCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *mSnoLabel;
@property (weak, nonatomic) IBOutlet UILabel *mStatusLabel;
@property (weak, nonatomic) IBOutlet UILabel *mStartTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *mDurationLabel;
@property (weak, nonatomic) IBOutlet UILabel *mLocationLabel;



@end
