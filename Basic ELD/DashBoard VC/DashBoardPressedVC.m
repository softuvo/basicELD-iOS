//
//  DashBoardPressedVC.m
//  Basic ELD
//
//  Created by Gaurav Verma on 27/10/17.
//  Copyright © 2017 Gaurav Verma. All rights reserved.
//

#import "DashBoardPressedVC.h"

@interface DashBoardPressedVC (){
    NSMutableArray *DashBoarddataArray;
}

@end

@implementation DashBoardPressedVC

- (void)viewDidLoad {
    [super viewDidLoad];
    DashBoarddataArray = [[NSMutableArray alloc] init];
    // Do any additional setup after loading the view.
    
        [self GetData:self.mDriverId];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)GetData:(NSString*)driverID {
    
    NSString * path = [NSString stringWithFormat:@"%@getDriverDetail",kServiceBaseURL];
    
    NSMutableDictionary * parameter = [[NSMutableDictionary alloc]init];
    [parameter setValue:driverID forKey:@"driver_id"];
    
    [DM PostRequest:path parameter:parameter onCompletion:^(id  _Nullable dict) {
        
        NSError *errorJson=nil;
        NSDictionary* responseDict = [NSJSONSerialization JSONObjectWithData:dict options:kNilOptions error:&errorJson];
        NSLog(@"%@",responseDict);
        if ([[responseDict valueForKey:@"status"] integerValue] == 0) {
            NSString *ErrorString = [NSString stringWithFormat:@"%@",[responseDict valueForKey:@"message"]];
            //[Helper ISAlertTypeError:@"Error!!" andMessage:ErrorString];
            [DashBoarddataArray removeAllObjects];
        }
        else{
            NSLog(@"%@",responseDict);
            
            [DashBoarddataArray removeAllObjects];
            [DashBoarddataArray addObjectsFromArray:[responseDict valueForKey:@"Result"]];
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            self.mdriving_time.text = [NSString stringWithFormat:@"%@",[[responseDict valueForKey:@"Result"] valueForKey:@"driving_time"]];
            self.mdriving_time_elapsed.text = [NSString stringWithFormat:@"%@",[[responseDict valueForKey:@"Result"] valueForKey:@"driving_time_elapsed"]];
            self.mdriving_time_remaining.text = [NSString stringWithFormat:@"%@",[[responseDict valueForKey:@"Result"] valueForKey:@"driving_time_remaining"]];
            self.mmiles_driven.text = [NSString stringWithFormat:@"%@",[[responseDict valueForKey:@"Result"] valueForKey:@"miles_driven"]];
            self.moffduty_time.text = [NSString stringWithFormat:@"%@",[[responseDict valueForKey:@"Result"] valueForKey:@"offduty_time"]];
            self.monduty_time.text = [NSString stringWithFormat:@"%@",[[responseDict valueForKey:@"Result"] valueForKey:@"onduty_time"]];
            self.msleeping_time.text = [NSString stringWithFormat:@"%@",[[responseDict valueForKey:@"Result"] valueForKey:@"sleeping_time"]];

        });
        
    } onError:^(NSError * _Nullable Error) {
        NSLog(@"%@",Error);
        NSString *ErrorString = [NSString stringWithFormat:@"%@",Error];
        // [Helper ISAlertTypeError:@"Error!!" andMessage:ErrorString];
    }];
    
}




- (IBAction)closePopup:(id)sender
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(DashboardPressedCancelButtonClicked:)])
    {
        [self.delegate DashboardPressedCancelButtonClicked:self];
        
    }
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
