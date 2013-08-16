//
//  MasterViewController.m
//  SmartStore_Test
//
//  Created by 楊野 勇智 on 2013/08/15.
//  Copyright (c) 2013年 salesforce.com. All rights reserved.
//

#import "MasterViewController.h"

@interface MasterViewController ()

@end

@implementation MasterViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    UINavigationController *detailNavi = [self.splitViewController.viewControllers lastObject];
    self.detailVC = [detailNavi.viewControllers objectAtIndex:0];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIViewController *nextVC = nil;
    switch (indexPath.row) {
        case 0:
            nextVC = [self.storyboard instantiateViewControllerWithIdentifier:@"create_store_test"];
            break;
            
        case 1:
            nextVC = [self.storyboard instantiateViewControllerWithIdentifier:@"register_soup_test"];
            break;
            
        case 2:
            nextVC = [self.storyboard instantiateViewControllerWithIdentifier:@"upsert_soup_test"];
            break;
            
        case 3:
            nextVC = [self.storyboard instantiateViewControllerWithIdentifier:@"query_soup_test"];
            break;
            
        case 4:
            nextVC = [self.storyboard instantiateViewControllerWithIdentifier:@"retrieve_entry_test"];
            break;
            
        default:
            break;
    }
    if (nextVC) {
        [self.detailVC.navigationController popToRootViewControllerAnimated:NO];
        [self.detailVC.navigationController pushViewController:nextVC animated:YES];
    }
}

@end
