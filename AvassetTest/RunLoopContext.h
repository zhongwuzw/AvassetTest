//
//  RunLoopContext.h
//  AvassetTest
//
//  Created by zhongwu on 14/10/25.
//  Copyright (c) 2014年 boloomo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RunLoopSource.h"
@interface RunLoopContext : NSObject
{
    CFRunLoopRef runLoop;
    RunLoopSource *source;
}

@property (readonly) CFRunLoopRef runlLoop;
@property (readonly) RunLoopSource *source;

- (id)initWithSource:(RunLoopSource *)src andLoop:(CFRunLoopRef)loop;
@end
