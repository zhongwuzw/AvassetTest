//
//  LiveDownloadTSEngine.h
//  AvassetTest
//
//  Created by zhongwu on 14-10-10.
//  Copyright (c) 2014年 boloomo. All rights reserved.
//

#import "MKNetworkEngine.h"

@interface LiveDownloadTSEngine : MKNetworkEngine
typedef void (^FileBlock)(void);

- (MKNetworkOperation *)downLoadTS:(NSString *)fileName onSucceeded:(FileBlock)succeedBlock errorHandler:(MKNKErrorBlock)errorBlock;
@end
