//
//  RunLoopSource.m
//  AvassetTest
//
//  Created by zhongwu on 14/10/25.
//  Copyright (c) 2014年 boloomo. All rights reserved.
//

#import "RunLoopSource.h"

@implementation RunLoopSource

- (void)fireAllCommandsOnRunLoop:(CFRunLoopRef)runloop
{
    CFRunLoopSourceSignal(runLoopSource);
    CFRunLoopWakeUp(runloop);
}

void RunLoopSourceScheduleRoutine (void *info, CFRunLoopRef rl, CFStringRef mode)
{
    RunLoopSource* obj = (__bridge RunLoopSource*)info;
    AppDelegate*   del = ApplicationDelegate;
    RunLoopContext* theContext = [[RunLoopContext alloc] initWithSource:obj andLoop:rl];
    
    [del performSelectorOnMainThread:@selector(registerSource:)
                          withObject:theContext waitUntilDone:NO];
}

void RunLoopSourcePerformRoutine (void *info)
{
    RunLoopSource*  obj = (__bridge RunLoopSource*)info;
    [obj sourceFired];
}

void RunLoopSourceCancelRoutine (void *info, CFRunLoopRef rl, CFStringRef mode)
{
    RunLoopSource* obj = (__bridge RunLoopSource*)info;
    AppDelegate* del = ApplicationDelegate;
    RunLoopContext* theContext = [[RunLoopContext alloc] initWithSource:obj andLoop:rl];
    
    [del performSelectorOnMainThread:@selector(removeSource:)
                          withObject:theContext waitUntilDone:YES];
}

- (void)addToCurrentRunLoop
{
    CFRunLoopRef runLoop = CFRunLoopGetCurrent();
    CFRunLoopAddSource(runLoop, runLoopSource, kCFRunLoopDefaultMode);
}

- (id)init
{
    CFRunLoopSourceContext context = {0,(__bridge void *)(self),NULL,NULL,NULL,NULL,NULL,
        &RunLoopSourceScheduleRoutine,&RunLoopSourceCancelRoutine,&RunLoopSourcePerformRoutine};
    runLoopSource = CFRunLoopSourceCreate(NULL, 0, &context);
    commands = [[NSMutableArray alloc] init];
    
    return self;
}
@end
