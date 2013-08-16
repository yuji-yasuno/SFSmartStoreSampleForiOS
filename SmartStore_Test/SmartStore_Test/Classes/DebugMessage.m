//
//  DebugMessage.m
//  SmartStore_Test
//
//  Created by 楊野 勇智 on 2013/08/15.
//  Copyright (c) 2013年 salesforce.com. All rights reserved.
//

#import "DebugMessage.h"

@implementation DebugMessage

+ (void)show:(NSString*)message
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"DEBUG" message:message delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alert show];
}

@end
