//
//  LiveDownloadTSEngine.m
//  AvassetTest
//
//  Created by zhongwu on 14-10-10.
//  Copyright (c) 2014年 boloomo. All rights reserved.
//

#import "LiveDownloadTSEngine.h"
#define GOPRO_FILE_URL(__C1__) [NSString stringWithFormat:@"live/%@", __C1__]

@implementation LiveDownloadTSEngine

- (MKNetworkOperation *)downLoadTS:(NSString *)fileName onSucceeded:(FileBlock)succeedBlock errorHandler:(MKNKErrorBlock)errorBlock
{
    MKNetworkOperation *op = [self operationWithPath:GOPRO_FILE_URL(fileName)];
    
    [op addCompletionHandler:^(MKNetworkOperation *completionOperation){

    }errorHandler:^(MKNetworkOperation *errorOp,NSError *error){
        errorBlock(error);
        NSLog(@"download Failed");
    }];
    
    [self enqueueOperation:op];
    return op;
}

@end
