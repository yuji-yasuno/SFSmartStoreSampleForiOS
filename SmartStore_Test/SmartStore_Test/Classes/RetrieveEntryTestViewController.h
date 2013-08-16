//
//  RetrieveEntryTestViewController.h
//  SmartStore_Test
//
//  Created by 楊野 勇智 on 2013/08/16.
//  Copyright (c) 2013年 salesforce.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RetrieveEntryTestViewController : UIViewController<UIPickerViewDataSource, UIPickerViewDelegate, UIActionSheetDelegate, SFRestDelegate>

@property (strong, nonatomic) IBOutlet UITextField *name;
@property (strong, nonatomic) IBOutlet UITextField *billingpostalcode;
@property (strong, nonatomic) IBOutlet UITextField *billingcountry;
@property (strong, nonatomic) IBOutlet UITextField *billingstate;
@property (strong, nonatomic) IBOutlet UITextField *billingcity;
@property (strong, nonatomic) IBOutlet UITextField *billingstreet;
@property (strong, nonatomic) IBOutlet UIPickerView *entryIdPicker;
@property (strong, nonatomic) NSArray *entries;

- (IBAction)selectAction:(id)sender;

@end
