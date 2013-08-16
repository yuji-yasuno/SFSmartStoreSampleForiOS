//
//  UpsertSoupTestViewController.h
//  SmartStore_Test
//
//  Created by 楊野 勇智 on 2013/08/15.
//  Copyright (c) 2013年 salesforce.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UpsertSoupTestViewController : UITableViewController<SFRestDelegate>

@property (strong, nonatomic) NSArray *records;
- (IBAction)saveToSoup:(id)sender;

@end
