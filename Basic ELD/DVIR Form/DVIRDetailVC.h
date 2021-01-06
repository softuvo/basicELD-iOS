//
//  DVIRDetailVC.h
//  Basic ELD
//
//  Created by Manoj Gadamsetty on 23/08/17.
//  Copyright © 2017 Gaurav Verma. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataManager.h"

@interface DVIRDetailVC : UIViewController





@property (weak, nonatomic) IBOutlet UITableView *mTableView;

@property (strong , nonatomic) NSMutableArray * mDataArray ;
@property (strong , nonatomic) NSMutableArray * selectedArray ;
@property (strong , nonatomic) NSString * refString ;

- (IBAction)DoneButtonAction:(id)sender;
- (IBAction)infoButtonAction:(id)sender;


@end
