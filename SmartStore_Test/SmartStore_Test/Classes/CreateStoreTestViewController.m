//
//  CreateStoreTestViewController.m
//  SmartStore_Test
//
//  Created by 楊野 勇智 on 2013/08/15.
//  Copyright (c) 2013年 salesforce.com. All rights reserved.
//

#import "CreateStoreTestViewController.h"

@interface CreateStoreTestViewController ()

@end

@implementation CreateStoreTestViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Events
- (IBAction)checkExist:(id)sender {
    
    if ([self.storeName.text compare:@""] == 0) {
        [DebugMessage show:@"Please fill out the store name."];
        return;
    }
    
    if ([SFSmartStore persistentStoreExists:self.storeName.text]) {
        [DebugMessage show:[[NSString alloc] initWithFormat:@"%@ is already existed.", self.storeName.text]];
    } else {
        [DebugMessage show:[[NSString alloc] initWithFormat:@"There is no store named %@.", self.storeName.text]];
    }
}

- (IBAction)createNewOne:(id)sender {
    
    if ([self.storeName.text compare:@""] == 0) {
        [DebugMessage show:@"Please fill out the store name."];
        return;
    }
    
    if ([SFSmartStore persistentStoreExists:self.storeName.text]) {
        [DebugMessage show:[[NSString alloc] initWithFormat:@"%@ is already existed.", self.storeName.text]];
    } else {
        SFSmartStore *store = [SFSmartStore sharedStoreWithName:self.storeName.text];
        if (store) {
            [DebugMessage show:@"Success to create."];
        }
    }
}

- (IBAction)deleteOne:(id)sender {
    
    if ([self.storeName.text compare:@""] == 0) {
        [DebugMessage show:@"Please fill out the store name."];
        return;
    }
    
    if ([SFSmartStore persistentStoreExists:self.storeName.text]) {
        [SFSmartStore removeSharedStoreWithName:self.storeName.text];
        if (![SFSmartStore persistentStoreExists:self.storeName.text]) {
            [DebugMessage show:@"Success to delete."];
        }
    } else {
        [DebugMessage show:[[NSString alloc] initWithFormat:@"%@ does not exist.", self.storeName.text]];
    }

}

@end
