//
//  MasterViewController.h
//  SmartStore_Test
//
//  Created by 楊野 勇智 on 2013/08/15.
//  Copyright (c) 2013年 salesforce.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DetailViewController.h"

@class DetailViewController;
@interface MasterViewController : UITableViewController

@property (strong, nonatomic) DetailViewController *detailVC;

@end
