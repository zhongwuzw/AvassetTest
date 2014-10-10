//
//  LiveCommandEngine.h
//  AvassetTest
//
//  Created by zhongwu on 14-9-25.
//  Copyright (c) 2014年 boloomo. All rights reserved.
//
#import "MKNetworkKit.h"
#import "MKNetworkEngine.h"
#include "GoProStatus.h"

@interface LiveCommandEngine : MKNetworkEngine
typedef void (^VoidBlock)(void);
typedef void (^StatusBlock)(void);

- (MKNetworkOperation *)startPreview:(NSString *)command symbol:(NSString *)sym onSucceeded:(VoidBlock)succeedBlock errorHandler:(MKNKErrorBlock)errorBlock;

- (MKNetworkOperation *)statusInquire:(NSString *)command onSucceeded:(StatusBlock)succeedBlock errorHandler:(MKNKErrorBlock)errorBlock;

@end
