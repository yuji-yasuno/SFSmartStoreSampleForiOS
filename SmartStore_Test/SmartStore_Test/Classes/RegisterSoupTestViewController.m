//
//  RegisterSoupTestViewController.m
//  SmartStore_Test
//
//  Created by 楊野 勇智 on 2013/08/15.
//  Copyright (c) 2013年 salesforce.com. All rights reserved.
//

#import "RegisterSoupTestViewController.h"

@interface RegisterSoupTestViewController ()

@end

@implementation RegisterSoupTestViewController

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

#pragma mark - private methods

- (BOOL)isSoup:(NSString*)soup inStore:(NSString*)store {
    
    BOOL result = NO;
    if(![SFSmartStore persistentStoreExists:store]) return result;
    SFSmartStore *smartstore = [SFSmartStore sharedStoreWithName:store];
    result = [smartstore soupExists:soup];
    return result;
}

- (NSArray*)createIndexes {
    
    NSMutableDictionary *index1 = [[NSMutableDictionary alloc] init];
    [index1 setValue:@"Id" forKey:@"path"];
    [index1 setValue:@"string" forKey:@"type"];
    
    NSMutableDictionary *index2 = [[NSMutableDictionary alloc] init];
    [index2 setValue:@"Name" forKey:@"path"];
    [index2 setValue:@"string" forKey:@"type"];
    
    return [[NSArray alloc] initWithObjects:index1, index2, nil];
}

#pragma mark - Events

- (IBAction)checkSoupExists:(id)sender {
    
    if ([self.storeName.text compare:@""] == 0 || [self.soupName.text compare:@""] == 0) {
        [DebugMessage show:@"Please fill out store name and soup name."];
        return;
    }
    
    if ([self isSoup:self.soupName.text inStore:self.storeName.text]) {
        [DebugMessage show:[[NSString alloc] initWithFormat:@"The soup %@ is in the store %@.", self.soupName.text, self.storeName.text]];
    } else {
        [DebugMessage show:[[NSString alloc] initWithFormat:@"The soup %@ does not exist in the store %@.", self.soupName.text, self.storeName.text]];
    }
}

- (IBAction)registerSoup:(id)sender {
    
    if ([self.storeName.text compare:@""] == 0 || [self.soupName.text compare:@""] == 0) {
        [DebugMessage show:@"Please fill out store name and soup name."];
        return;
    }
    
    SFSmartStore *smartstore = [SFSmartStore sharedStoreWithName:self.storeName.text];

    if ([self isSoup:self.soupName.text inStore:self.storeName.text]) {
        [DebugMessage show:@"The is already existing."];
    } else {
        NSArray *indexes = [self createIndexes];        
        if([smartstore registerSoup:self.soupName.text withIndexSpecs:indexes]) {
            [DebugMessage show:@"Success to register."];
        } else {
            [DebugMessage show:@"Failed to register."];
        }
    }
}

- (IBAction)removeSoup:(id)sender {
    
    if ([self.storeName.text compare:@""] == 0 || [self.soupName.text compare:@""] == 0) {
        [DebugMessage show:@"Please fill out store name and soup name."];
        return;
    }
    
    SFSmartStore *smartstore = [SFSmartStore sharedStoreWithName:self.storeName.text];
    
    if ([self isSoup:self.soupName.text inStore:self.storeName.text]) {
        [smartstore removeSoup:self.soupName.text];
        if (![self isSoup:self.soupName.text inStore:self.storeName.text]) {
            [DebugMessage show:@"Success to remove."];
        }
    } else {
        [DebugMessage show:@"The soup is not existing."];
    }
}

- (IBAction)removeAllSoup:(id)sender {
    
    if ([self.storeName.text compare:@""] == 0) {
        [DebugMessage show:@"Please fill out the store name that you want to remove soups."];
        return;
    }
    
    SFSmartStore *smartstore = [SFSmartStore sharedStoreWithName:self.storeName.text];
    [smartstore removeAllSoups];
    [DebugMessage show:@"All soups are removed"];
}

@end
