//
//  Records.h
//  DatabaseDB
//
//  Created by Gaurav Verma on 07/12/15.
//  Copyright © 2015 Gaurav Verma. All rights reserved.
//

#import <Foundation/Foundation.h>
//----------Web Table-----------//
@interface Records : NSObject
@property(nonatomic,copy)NSString *record_id;
@property(nonatomic,copy)NSString *partner_id;
@property(nonatomic,copy)NSString *user_name;
@property(nonatomic,copy)NSString *user_uniq_id;
@property(nonatomic,copy)NSString *user_dob;
@property(nonatomic,copy)NSString *user_image;
@property(nonatomic,copy)NSString *check_devid;
@property(nonatomic,copy)NSString *user_desc;
@property(nonatomic,copy)NSString *orderid;
@property(nonatomic,copy)NSString *date_time;
@property(nonatomic,copy)NSString *order_id;

@property(nonatomic,copy)NSString *user_deleted;
@property(nonatomic,copy)NSString *first_name;
@property(nonatomic,copy)NSString *last_name;
@property(nonatomic,copy)NSString *order_status;

@property(nonatomic,copy)NSString *SearchString;







@end
