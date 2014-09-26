//
//  GoProStatus.m
//  AvassetTest
//
//  Created by zhongwu on 14-9-26.
//  Copyright (c) 2014年 boloomo. All rights reserved.
//

#import "GoProStatus.h"

@implementation GoProStatus

+ (GoProStatus *)sharedInstance
{
    static GoProStatus *singleton;
    static dispatch_once_t token;
    
    dispatch_once(&token,^{
        singleton = [[GoProStatus alloc] initGoProStatus];
    });
    return singleton;
}

- (id)initGoProStatus
{
    self = [super init];
    if (self) {
        ;
    }
    return self;
}

- (id)init
{
    return [GoProStatus sharedInstance];
}
@end
