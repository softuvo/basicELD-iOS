//
//  ChangeSignViewController.m
//  Basic ELD
//
//  Created by Naveen on 24/05/17.
//  Copyright © 2017 Gaurav Verma. All rights reserved.
//

#import "ChangeSignViewController.h"


@interface ChangeSignViewController ()

@end

@implementation ChangeSignViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)cancelClicked:(id)sender {
    
     [self.navigationController popViewControllerAnimated:YES];
    
    
}


- (IBAction)saveClicked:(id)sender {
    
     [self.navigationController popViewControllerAnimated:YES];
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
