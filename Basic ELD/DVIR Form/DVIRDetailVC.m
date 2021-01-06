//
//  DVIRDetailVC.m
//  Basic ELD
//
//  Created by Manoj Gadamsetty on 23/08/17.
//  Copyright © 2017 Gaurav Verma. All rights reserved.
//

#import "DVIRDetailVC.h"

@interface DVIRDetailVC (){
    
    NSMutableArray * refSelectedArray ;
    
    
}

@end

@implementation DVIRDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    refSelectedArray = [[NSMutableArray alloc]init];
    [refSelectedArray addObjectsFromArray:DM.DVIRSelectedArray];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return self.mDataArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *MyIdentifier = @"MyIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:MyIdentifier];
    }
    
    
    cell.textLabel.text = [self.mDataArray objectAtIndex:indexPath.row];
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.textLabel.minimumFontSize = 10.0 ;
    cell.backgroundColor = [UIColor clearColor];
    
    
    
    if ([refSelectedArray containsObject:[self.mDataArray objectAtIndex:indexPath.row]]) {
        [tableView selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionNone];
        cell.accessoryType = UITableViewCellAccessoryCheckmark;

    }

    if([[tableView indexPathsForSelectedRows] containsObject:indexPath]) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    } else {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    UIView *bgColorView = [[UIView alloc] init];
    [bgColorView setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.3]];
    [cell setSelectedBackgroundView:bgColorView];
    [cell setTintColor:[UIColor whiteColor]];

    return cell;
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    [refSelectedArray addObject:[self.mDataArray objectAtIndex:indexPath.row]];
    NSLog(@"Added Object %@",[self.mDataArray objectAtIndex:indexPath.row]);
    cell.accessoryType = UITableViewCellAccessoryCheckmark;
}
- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell* cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.accessoryType = UITableViewCellAccessoryNone;
    cell.accessoryType = UITableViewCellAccessoryNone;
    [refSelectedArray removeObject:[self.mDataArray objectAtIndex:indexPath.row]];
    NSLog(@"Removed Object %@",[self.mDataArray objectAtIndex:indexPath.row]);
}



- (IBAction)DoneButtonAction:(id)sender {
    
    NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
    [dict setValue:refSelectedArray forKey:self.refString];
    
    NSLog(@"%@ data ",refSelectedArray);
    [[NSNotificationCenter defaultCenter]postNotificationName:@"DVIRNotification"
     object:dict];

    self.selectedArray = [[NSMutableArray alloc]init];
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)infoButtonAction:(id)sender {
    
    
    
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
