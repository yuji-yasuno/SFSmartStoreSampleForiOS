//
//  CreateStoreTestViewController.h
//  SmartStore_Test
//
//  Created by 楊野 勇智 on 2013/08/15.
//  Copyright (c) 2013年 salesforce.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CreateStoreTestViewController : UIViewController

@property (strong, nonatomic) IBOutlet UITextField *storeName;

- (IBAction)checkExist:(id)sender;
- (IBAction)createNewOne:(id)sender;
- (IBAction)deleteOne:(id)sender;

@end
