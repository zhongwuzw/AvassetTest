//
//  RunLoopSource.h
//  AvassetTest
//
//  Created by zhongwu on 14/10/25.
//  Copyright (c) 2014年 boloomo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppDelegate.h"
#import "RunLoopContext.h"

@interface RunLoopSource : NSObject
{
    CFRunLoopSourceRef runLoopSource;
    NSMutableArray *commands;
}

- (id)init;
- (void)addToCurrentRunLoop;
- (void)invalidate;

- (void)sourceFired;

- (void)addCommand:(NSInteger)command withData:(id)data;
- (void)fireAllCommandsOnRunLoop:(CFRunLoopRef)runloop;
@end
