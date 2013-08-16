//
//  DetailViewController.m
//  SmartStore_Test
//
//  Created by 楊野 勇智 on 2013/08/15.
//  Copyright (c) 2013年 salesforce.com. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()

@end

@implementation DetailViewController

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
    
    UINavigationController *masterNavi = [self.splitViewController.viewControllers objectAtIndex:0];
    self.masterVC = [masterNavi.viewControllers objectAtIndex:0];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
