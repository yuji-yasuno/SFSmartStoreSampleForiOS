//
//  DetailViewController.h
//  SmartStore_Test
//
//  Created by 楊野 勇智 on 2013/08/15.
//  Copyright (c) 2013年 salesforce.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MasterViewController.h"

@class MasterViewController;
@interface DetailViewController : UIViewController

@property (strong, nonatomic) MasterViewController *masterVC;
@end
