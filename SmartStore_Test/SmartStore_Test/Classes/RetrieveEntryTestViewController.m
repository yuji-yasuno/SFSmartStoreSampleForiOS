//
//  RetrieveEntryTestViewController.m
//  SmartStore_Test
//
//  Created by 楊野 勇智 on 2013/08/16.
//  Copyright (c) 2013年 salesforce.com. All rights reserved.
//

#import "RetrieveEntryTestViewController.h"

@interface RetrieveEntryTestViewController ()

@end

@implementation RetrieveEntryTestViewController

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
    self.entries = [self findEntryIdOfSoup:@"all" inStore:@"Account"];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [self.entryIdPicker selectRow:0 inComponent:0 animated:NO];
    if (self.entries && self.entries.count > 0) {
        NSString *entryId = [self.entries objectAtIndex:0];
        NSDictionary *record = [self retrieveEntryFromSoup:@"all" inStore:@"Account" byEntryId:entryId];
        if (record) {
            [self updateViewForCurrentSelectedEntry:record];
        }
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - UIPickerViewDataSource delegate
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return self.entries ? self.entries.count : 0;
}

#pragma mark - UIPickerViewDelgate
- (NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return [self.entries objectAtIndex:row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    NSString *entryId = [self.entries objectAtIndex:row];
    NSDictionary *record = [self retrieveEntryFromSoup:@"all" inStore:@"Account" byEntryId:entryId];
    if (record) {
        [self updateViewForCurrentSelectedEntry:record];
    }
}

#pragma mark - UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    NSDictionary *newEntry = nil;
    switch (buttonIndex) {
        case 0:
            [self saveCurrentItemToSoup:@"all" inStore:@"Account"];
            break;
            
        case 1:
            newEntry = [self saveCurrentItemToSoup:@"all" inStore:@"Account"];
            [self saveToServer:newEntry];
            
        case 2:
            // cancel action, nothing to do
            break;
            
        default:
            break;
    }
}

#pragma mark - SFRestDelegate
- (void)request:(SFRestRequest *)request didLoadResponse:(id)dataResponse {
    [DebugMessage show:@"Success save to server"];
}

- (void)request:(SFRestRequest *)request didFailLoadWithError:(NSError *)error {
    [DebugMessage show:[[NSString alloc] initWithFormat:@"Error : %@", error.description]];
}

- (void)requestDidCancelLoad:(SFRestRequest *)request {
    [DebugMessage show:@"Canceled"];
}

- (void)requestDidTimeout:(SFRestRequest *)request {
    [DebugMessage show:@"Timeout"];
}

#pragma mark - private methods
- (NSArray *)findEntryIdOfSoup:(NSString*)soup inStore:(NSString*)store {
    
    SFSmartStore *smartstore = [SFSmartStore sharedStoreWithName:store];
    SFQuerySpec *qspec = [SFQuerySpec newRangeQuerySpec:soup withPath:@"Name" withBeginKey:nil withEndKey:nil withOrder:kSFSoupQuerySortOrderAscending withPageSize:1];
    
    NSInteger count = [smartstore countWithQuerySpec:qspec];
    NSMutableArray *result = [[NSMutableArray alloc] init];
    for (NSInteger ii = 1; ii <= count; ii++) {
        [result addObject:[[NSString alloc] initWithFormat:@"%d", ii]];
    }
    
    return result;
}

- (NSDictionary*)retrieveEntryFromSoup:(NSString*)soup inStore:(NSString*)store byEntryId:(NSString*)entryId {
    
    SFSmartStore *smartstore = [SFSmartStore sharedStoreWithName:store];
    NSArray *results = [smartstore retrieveEntries:[[NSArray alloc] initWithObjects:entryId, nil] fromSoup:soup];
    return results && results.count > 0 ? [results objectAtIndex:0] : nil;
}

- (void)updateViewForCurrentSelectedEntry:(NSDictionary*)record {
    
    if ([[record objectForKey:@"Name"] isKindOfClass:[NSString class]]) {
        self.name.text = [record objectForKey:@"Name"];
    }
    if ([[record objectForKey:@"BillingPostalCode"] isKindOfClass:[NSString class]]) {
        self.billingpostalcode.text = [record objectForKey:@"BillingPostalCode"];
    }
    if ([[record objectForKey:@"BillingCountry"] isKindOfClass:[NSString class]]) {
        self.billingcountry.text = [record objectForKey:@"BillingCountry"];
    }
    if ([[record objectForKey:@"BillingState"] isKindOfClass:[NSString class]]) {
        self.billingstate.text = [record objectForKey:@"BillingState"];
    }
    if ([[record objectForKey:@"BillingCity"] isKindOfClass:[NSString class]]) {
        self.billingcity.text = [record objectForKey:@"BillingCity"];
    }
    if ([[record objectForKey:@"BillingStreet"] isKindOfClass:[NSString class]]) {
        self.billingstreet.text = [record objectForKey:@"BillingStreet"];
    }
}

- (BOOL)checkKeyIsField:(NSString*)key {
    
    BOOL result = YES;
    if ([key compare:@"_soupEntryId"] == 0 || [key compare:@"_soupLastModifiedDate"] == 0 || [key compare:@"attributes"] == 0) {
        result = NO;
    }
    return result;
}

- (NSDictionary*)saveCurrentItemToSoup:(NSString*)soup inStore:(NSString*)store {
    
    NSInteger index = [self.entryIdPicker selectedRowInComponent:0];
    NSString *entryId = [self.entries objectAtIndex:index];
    NSDictionary *entry = [self retrieveEntryFromSoup:@"all" inStore:@"Account" byEntryId:entryId];
    
    NSMutableDictionary *newEntry = [[NSMutableDictionary alloc] init];
    [newEntry setValue:entryId forKey:@"_soupEntryId"];
    [newEntry setValue:[entry objectForKey:@"Id"] forKey:@"Id"];
    [newEntry setValue:self.name.text forKey:@"Name"];
    [newEntry setValue:self.billingpostalcode.text forKey:@"BillingPostalCode"];
    [newEntry setValue:self.billingcountry.text forKey:@"BillingCountry"];
    [newEntry setValue:self.billingstate.text forKey:@"BillingState"];
    [newEntry setValue:self.billingcity.text forKey:@"BillingCity"];
    [newEntry setValue:self.billingstreet.text forKey:@"Billingstreet"];
        
    SFSmartStore *smartstore = [SFSmartStore sharedStoreWithName:store];
    [smartstore upsertEntries:[[NSArray alloc] initWithObjects:newEntry, nil] toSoup:soup];
    
    return newEntry;
}

- (void)saveToServer:(NSDictionary*)record {
    
    if (![[record objectForKey:@"Id"] isKindOfClass:[NSString class]]) {
        [DebugMessage show:@"The object doesn't has a record ID."];
        return;
    }
    
    NSString *recordId = [record objectForKey:@"Id"];
    NSMutableDictionary *fields = [[NSMutableDictionary alloc] init];
    for (id key in record.keyEnumerator) {
        if ([self checkKeyIsField:key]) {
            [fields setValue:[record objectForKey:key] forKey:key];
        }
    }
    [fields removeObjectForKey:@"Id"];
    
    SFRestAPI *api = [SFRestAPI sharedInstance];
    SFRestRequest *request = [api requestForUpdateWithObjectType:@"Account" objectId:recordId fields:fields];
    [api send:request delegate:self];
    
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
}

- (void)showActionSelection {
    
    UIActionSheet *action = [[UIActionSheet alloc] init];
    action.delegate = self;
    [action addButtonWithTitle:@"Save to local"];
    [action addButtonWithTitle:@"Save to local and server"];
    [action addButtonWithTitle:@"Cancel"];
    [action showInView:self.view];
}

#pragma mark - Events
- (IBAction)selectAction:(id)sender {
    [self showActionSelection];
}

@end
