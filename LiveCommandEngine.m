//
//  LiveCommandEngine.m
//  AvassetTest
//
//  Created by zhongwu on 14-9-25.
//  Copyright (c) 2014年 boloomo. All rights reserved.
//

#import "LiveCommandEngine.h"

#define GOPRO_COMMAND_URL(__C1__,__C2__) [NSString stringWithFormat:@"camera/%@?t=blm123123&p=%%%@", __C1__,__C2__]
#define GOPRO_STATUS_URL(__C1__) [NSString stringWithFormat:@"camera/%@?t=blm123123", __C1__]

@implementation LiveCommandEngine

- (MKNetworkOperation *)statusInquire:(NSString *)command onSucceeded:(StatusBlock)succeedBlock errorHandler:(MKNKErrorBlock)errorBlock
{
    MKNetworkOperation *op = [self operationWithPath:GOPRO_STATUS_URL(command)];
    
    [op addCompletionHandler:^(MKNetworkOperation *completionOperation){
        //  NSDictionary *responseDict = [completionOperation responseJSON];
//        NSString *statusString = [completionOperation setdo];
      //  NSLog(@"status is :%s",statusString);
        succeedBlock();
     //   NSLog(@"commit success!");
    }errorHandler:^(MKNetworkOperation *errorOp,NSError *error){
        errorBlock(error);
        NSLog(@"faild commit");
    }];
    
    [self enqueueOperation:op];
    
    return op;

}

- (MKNetworkOperation *)startPreview:(NSString *)command symbol:(NSString *)sym onSucceeded:(VoidBlock)succeedBlock errorHandler:(MKNKErrorBlock)errorBlock
{
    MKNetworkOperation *op = [self operationWithPath:GOPRO_COMMAND_URL(command, sym)];
    
    [op addCompletionHandler:^(MKNetworkOperation *completionOperation){
        //  NSDictionary *responseDict = [completionOperation responseJSON];
        succeedBlock();
     //   NSLog(@"commit success!");
    }errorHandler:^(MKNetworkOperation *errorOp,NSError *error){
        errorBlock(error);
        NSLog(@"faild commit");
    }];
    
    [self enqueueOperation:op];
    
    return op;
}

@end
