//
//  AppDelegate.h
//  AvassetTest
//
//  Created by zhongwu on 14-9-16.
//  Copyright (c) 2014年 boloomo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LiveCommandEngine.h"
#import "LiveDownloadTSEngine.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

#define ApplicationDelegate ((AppDelegate *)[UIApplication sharedApplication].delegate)

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) LiveCommandEngine *liveCommandEngine;
@property (strong, nonatomic) LiveDownloadTSEngine *liveDownloadEngine;

@end

