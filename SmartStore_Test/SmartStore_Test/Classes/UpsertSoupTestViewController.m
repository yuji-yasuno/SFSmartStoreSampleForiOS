//
//  UpsertSoupTestViewController.m
//  SmartStore_Test
//
//  Created by 楊野 勇智 on 2013/08/15.
//  Copyright (c) 2013年 salesforce.com. All rights reserved.
//

#import "UpsertSoupTestViewController.h"

@interface UpsertSoupTestViewController ()

@end

@implementation UpsertSoupTestViewController

static NSString *BASE_QUERY = @"SELECT BillingCity,BillingCountry,BillingPostalCode,BillingState,BillingStreet,Id,Name FROM Account ORDER BY Name ASC NULLS LAST";
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
    [self sendQuery:BASE_QUERY];
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
    static NSString *CellIdentifier = @"cell1";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    NSMutableString *name = [[NSMutableString alloc] init];
    NSMutableString *address = [[NSMutableString alloc] init];
    
    NSDictionary *record = [self.records objectAtIndex:indexPath.row];
    if ([[record objectForKey:@"Name"] isKindOfClass:[NSString class]]) {
        [name appendFormat:@"%@", [record objectForKey:@"Name"]];
    }
    if ([[record objectForKey:@"BillingPostalCode"] isKindOfClass:[NSString class]]) {
        [address appendFormat:@"%@ ", [record objectForKey:@"BillingCity"]];
    }
    if ([[record objectForKey:@"BillingState"] isKindOfClass:[NSString class]]) {
        [address appendFormat:@"%@ ", [record objectForKey:@"BillingState"]];
    }
    if ([[record objectForKey:@"BillingCity"] isKindOfClass:[NSString class]]) {
        [address appendFormat:@"%@ ", [record objectForKey:@"BillingCity"]];
    }
    if ([[record objectForKey:@"BillingStreet"] isKindOfClass:[NSString class]]) {
        [address appendFormat:@"%@ ", [record objectForKey:@"BillingStreet"]];
    }
    
    cell.textLabel.text = name;
    cell.detailTextLabel.text = address;
    
    return cell;
}

#pragma mark - SFRestDelegate implements

- (void)request:(SFRestRequest *)request didLoadResponse:(id)dataResponse {
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    self.records = [dataResponse objectForKey:@"records"];
    [self.tableView reloadData];
}

- (void)request:(SFRestRequest *)request didFailLoadWithError:(NSError *)error {
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    [DebugMessage show:[[NSString alloc] initWithFormat:@"ERROR : %@", error.description]];
}

- (void)requestDidCancelLoad:(SFRestRequest *)request {
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    [DebugMessage show:@"Canceled to load the request."];
}

- (void)requestDidTimeout:(SFRestRequest *)request {
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    [DebugMessage show:@"Time out."];
}

#pragma mark - private methods

- (void)sendQuery:(NSString*)query {
    
    SFRestAPI *api = [SFRestAPI sharedInstance];
    SFRestRequest *request = [api requestForQuery:query];
    [api send:request delegate:self];
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
}

- (NSArray*)saveRecords:(NSArray*)items toSoup:(NSString*)soup inStore:(NSString*)store {
    
    NSArray *recordsInSoup = nil;
    SFSmartStore *smartstore = [SFSmartStore sharedStoreWithName:store];
    
    if ([smartstore soupExists:soup]) {
        [smartstore removeSoup:soup];
    }
    
    NSMutableDictionary *index1 = [[NSMutableDictionary alloc] init];
    [index1 setValue:@"Id" forKey:@"path"];
    [index1 setValue:@"string" forKey:@"type"];
    
    NSMutableDictionary *index2 = [[NSMutableDictionary alloc] init];
    [index2 setValue:@"Name" forKey:@"path"];
    [index2 setValue:@"string" forKey:@"type"];
    
    NSArray *indices = [[NSArray alloc] initWithObjects:index1, index2, nil];
    if([smartstore registerSoup:soup withIndexSpecs:indices]) {
        recordsInSoup = [smartstore upsertEntries:self.records toSoup:soup];
    }
    
    return recordsInSoup;
}

#pragma mark - Events

- (IBAction)saveToSoup:(id)sender {
    if (self.records && self.records.count > 0) {
        NSArray *results = nil;
        results = [self saveRecords:self.records toSoup:@"all" inStore:@"Account"];
        NSLog(@"results.count = %d", results.count);
    }
}

@end
