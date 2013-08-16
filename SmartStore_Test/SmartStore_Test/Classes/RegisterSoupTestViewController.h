//
//  RegisterSoupTestViewController.h
//  SmartStore_Test
//
//  Created by 楊野 勇智 on 2013/08/15.
//  Copyright (c) 2013年 salesforce.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RegisterSoupTestViewController : UIViewController

@property (strong, nonatomic) IBOutlet UITextField *storeName;
@property (strong, nonatomic) IBOutlet UITextField *soupName;

- (IBAction)checkSoupExists:(id)sender;
- (IBAction)registerSoup:(id)sender;
- (IBAction)removeSoup:(id)sender;
- (IBAction)removeAllSoup:(id)sender;

@end
