//
//  QuerySoupTestViewController.m
//  SmartStore_Test
//
//  Created by 楊野 勇智 on 2013/08/15.
//  Copyright (c) 2013年 salesforce.com. All rights reserved.
//

#import "QuerySoupTestViewController.h"

@interface QuerySoupTestViewController ()

@end

@implementation QuerySoupTestViewController

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
    [self checkSmartStoreToShow];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.records ? self.records.count : 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"cell2";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    NSDictionary *record = [self.records objectAtIndex:indexPath.row];
    cell.textLabel.text = [[record objectForKey:@"Name"] isKindOfClass:[NSString class]] ? [record objectForKey:@"Name"] : @"";
    
    NSMutableString *address = [[NSMutableString alloc] init];
    if ([[record objectForKey:@"BillingState"] isKindOfClass:[NSString class]]) {
        [address appendFormat:@"%@ ", [record objectForKey:@"BillingState"]];
    } else if([[record objectForKey:@"BillingCity"] isKindOfClass:[NSString class]]) {
        [address appendFormat:@"%@ ", [record objectForKey:@"BillingCity"]];
    } else if([[record objectForKey:@"BillingStreet"] isKindOfClass:[NSString class]]) {
        [address appendFormat:@"%@ ", [record objectForKey:@"BillingStreet"]];
    }
    cell.detailTextLabel.text = address;
    
    // Configure the cell...
    
    return cell;
}

#pragma mark - private methods

- (void)checkSmartStoreToShow {
    
    SFQuerySpec *qspec = [SFQuerySpec newLikeQuerySpec:@"all" withPath:@"Name" withLikeKey:@"%" withOrder:kSFSoupQuerySortOrderAscending withPageSize:100];
    SFSmartStore *smartstore = [SFSmartStore sharedStoreWithName:@"Account"];
    self.records = [smartstore queryWithQuerySpec:qspec pageIndex:0];
    [self.tableView reloadData];
}

- (void)removeEnties:(NSArray*)entryIds ofSoup:(NSString*)soup inStore:(NSString*)store {
    
    SFSmartStore *smartstore = [SFSmartStore sharedStoreWithName:store];
    [smartstore removeEntries:entryIds fromSoup:soup];
}

#pragma mark - Events
- (IBAction)deleteEntries:(id)sender {
    
    NSArray *indexPaths = [self.tableView indexPathsForSelectedRows];
    NSMutableArray *entryIds = [[NSMutableArray alloc] init];
    for (NSIndexPath *index in indexPaths) {
        NSDictionary *entry = [self.records objectAtIndex:index.row];
        [entryIds addObject:[entry objectForKey:@"_soupEntryId"]];
    }
    
    [self removeEnties:entryIds ofSoup:@"all" inStore:@"Account"];
    [self checkSmartStoreToShow];
}

@end
