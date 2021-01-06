//
//  EditLogsVC.m
//  Basic ELD
//
//  Created by Manoj Gadamsetty on 30/08/17.
//  Copyright © 2017 Gaurav Verma. All rights reserved.
//

#import "EditLogsVC.h"
#import "DataManager.h"

@interface EditLogsVC (){
    
    NSMutableArray * dataArray ;
    
    NSDictionary * driverOneDetails;
    NSDictionary * driverTwoDetails;
    
    UIDatePicker *datePicker ;
}

@end

@implementation EditLogsVC
@synthesize driverOne,driverTwo;


- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    driverOne = [[SKUser alloc] init];
    [driverOne setupUser:[Helper mCurrentUser:kCurrentUserOne]];
    driverOneDetails = [[NSDictionary alloc]init];
    driverOneDetails = [Helper mCurrentUser:kCurrentUserOne];
    
    driverTwo = [[SKUser alloc] init];
    [driverTwo setupUser:[Helper mCurrentUser:kCurrentUserTwo]];
    driverTwoDetails = [[NSDictionary alloc]init];
    driverTwoDetails = [Helper mCurrentUser:kCurrentUserTwo];
    
    
    self.mHeaderView.layer.borderWidth = 1;
    self.mHeaderView.layer.borderColor = [[UIColor whiteColor]CGColor];
    
    self.mLogsTableView.allowsMultipleSelectionDuringEditing = NO;
    
    

    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;    //count of section
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 3;    //count number of row from counting array hear cataGorry is An Array
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
   
    return 23.0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *MyIdentifier = @"editCell";
    
    EditCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
    
    if (cell == nil)
    {
        cell = [[EditCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:MyIdentifier] ;
    }
    
    cell.mSnoLabel.text = [NSString stringWithFormat:@"%ld",(long)indexPath.row];
    cell.mStatusLabel.text = [NSString stringWithFormat:@"%ld",(long)indexPath.row];
    cell.mStartTimeLabel.text = [NSString stringWithFormat:@"%ld",(long)indexPath.row];
    cell.mDurationLabel.text = [NSString stringWithFormat:@"%ld",(long)indexPath.row];
    cell.mLocationLabel.text = [NSString stringWithFormat:@"%ld",(long)indexPath.row];

    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return YES if you want the specified item to be editable.
    return YES;
}


- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        //add code here for when you hit delete
    }
}


-(NSArray *)tableView:(UITableView* )tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
        UITableViewRowAction *button = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"Delete" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath)
                                       {
                                         //  idxPath = indexPath;
                                          //
                                          // [self PasswordView1];
                                           
                                           
                                           NSLog(@"Delete Button Pressed");
                                       }];
        button.backgroundColor = [UIColor redColor]; //arbitrary color
        UITableViewRowAction *button2 = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"  Edit  " handler:^(UITableViewRowAction *action, NSIndexPath *indexPath)
                        {
                            NSLog(@"Edit Button Pressed");
                            // mNewMeeting = [self.mMeetingDataArray objectAtIndex:indexPath.row];
                            
                                            
                        }];
       // button2.backgroundColor = [UIColor colorWithRed:67/255. green:173/255. blue:50/255. alpha:1.]; //arbitrary color
        button2.backgroundColor = [UIColor clearColor]; //arbitrary color
        return @[button2]; //array with all the buttons you want. 1,2,3, etc...
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)DateButtonAction:(id)sender {
    datePicker=[[UIDatePicker alloc]init];
    [datePicker setFrame:CGRectMake(0, 117, 320, 383)];
    datePicker.datePickerMode=UIDatePickerModeDateAndTime;
    datePicker.timeZone = [NSTimeZone localTimeZone];
    [datePicker addTarget:self action:@selector(done) forControlEvents:UIControlEventValueChanged];
    
}

-(void)done
{
    NSString *dateStri=[NSDateFormatter stringFromDate:datePicker.date];
    [timingTextField setText:[NSString stringWithFormat:@"%@",dateStri]];
}

- (IBAction)BackButtonAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];

}

- (IBAction)ConfirmAndSignButtonAction:(id)sender {
}


-(void)GetData{
    
    
    NSString * path = [NSString stringWithFormat:@"%@getLogs",kServiceBaseURL];
    
    NSMutableDictionary * parameter = [[NSMutableDictionary alloc]init];
    [parameter setValue:@"" forKey:@"driverid"];
    [parameter setValue:@"" forKey:@"date"];

    
    [DM PostRequest:path parameter:parameter onCompletion:^(id  _Nullable dict) {
        
        NSError *errorJson=nil;
        NSDictionary* responseDict = [NSJSONSerialization JSONObjectWithData:dict options:kNilOptions error:&errorJson];
        NSLog(@"%@",responseDict);
        if ([[responseDict valueForKey:@"responsestatus"] integerValue] == 0) {
            NSString *ErrorString = [NSString stringWithFormat:@"%@",[responseDict valueForKey:@"message"]];
            [Helper ISAlertTypeError:@"Error!!" andMessage:ErrorString];
        }
        else{
            NSLog(@"%@",responseDict);
            dispatch_async(dispatch_get_main_queue(), ^{
               //reload tableview here
            });
        }
        
    } onError:^(NSError * _Nullable Error) {
        NSLog(@"%@",Error);
        NSString *ErrorString = [NSString stringWithFormat:@"%@",Error];
        [Helper ISAlertTypeError:@"Error!!" andMessage:ErrorString];
    }];
    
    
}
@end
