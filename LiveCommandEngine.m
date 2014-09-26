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
        NSArray *documentDirectories = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentDirectory = [documentDirectories objectAtIndex:0];
        NSString *finalDirectory = [documentDirectory stringByAppendingPathComponent:@"status.data"];
        
        NSData *data = [NSData dataWithContentsOfFile:finalDirectory];
        NSString *dataString = [data description];
        
        GoProStatus *goPro = [GoProStatus sharedInstance];
        goPro.currentMode = [[dataString substringWithRange:NSMakeRange(4, 1)] intValue];
        goPro.defaultMode = [[dataString substringWithRange:NSMakeRange(8, 1)] intValue];
        
        NSInteger batteryHigh = [[dataString substringWithRange:NSMakeRange(43, 1)] intValue];
        NSInteger batteryLow = [[dataString substringWithRange:NSMakeRange(44, 1)] intValue];
        NSInteger battery = batteryHigh*16 + batteryLow;
        goPro.Battery = battery;
        
        NSInteger photoAvailableHigh1 = [[dataString substringWithRange:NSMakeRange(48, 1)] intValue];
        NSInteger photoAvailableHigh2 = [[dataString substringWithRange:NSMakeRange(49, 1)] intValue];
        NSInteger photoAvailableLow1 = [[dataString substringWithRange:NSMakeRange(50, 1)] intValue];
        NSInteger photoAvailableLow2 = [[dataString substringWithRange:NSMakeRange(51, 1)] intValue];
        NSInteger photosAvailable = photoAvailableHigh1*16*16*16 + photoAvailableHigh2*16*16 + photoAvailableLow1*16 +photoAvailableLow2;
        goPro.photosAvailable = photosAvailable;
        
        NSInteger photoCountHigh1 = [[dataString substringWithRange:NSMakeRange(52, 1)] intValue];
        NSInteger photoCountHigh2 = [[dataString substringWithRange:NSMakeRange(53, 1)] intValue];
        NSInteger photoCountLow1 = [[dataString substringWithRange:NSMakeRange(55, 1)] intValue];
        NSInteger photoCountLow2 = [[dataString substringWithRange:NSMakeRange(56, 1)] intValue];
        NSInteger photosCount = photoCountHigh1*16*16*16 + photoCountHigh2*16*16 + photoCountLow1*16 +photoCountLow2;
        goPro.photosCount = photosCount;
        
        NSInteger videoAvailableHigh1 = [[dataString substringWithRange:NSMakeRange(57, 1)] intValue];
        NSInteger videoAvailableHigh2 = [[dataString substringWithRange:NSMakeRange(58, 1)] intValue];
        NSInteger videoAvailableLow1 = [[dataString substringWithRange:NSMakeRange(59, 1)] intValue];
        NSInteger videoAvailableLow2 = [[dataString substringWithRange:NSMakeRange(60, 1)] intValue];
        NSInteger videoAvailable = videoAvailableHigh1*16*16*16 + videoAvailableHigh2*16*16 + videoAvailableLow1*16 +videoAvailableLow2;
        goPro.videoRemainMin = videoAvailable;
        
        NSInteger videoCountHigh1 = [[dataString substringWithRange:NSMakeRange(61, 1)] intValue];
        NSInteger videoCountHigh2 = [[dataString substringWithRange:NSMakeRange(62, 1)] intValue];
        NSInteger videoCountLow1 = [[dataString substringWithRange:NSMakeRange(64, 1)] intValue];
        NSInteger videoCountLow2 = [[dataString substringWithRange:NSMakeRange(65, 1)] intValue];
        NSInteger videoCount = videoCountHigh1*16*16*16 + videoCountHigh2*16*16 + videoCountLow1*16 + videoCountLow2;
        goPro.videoCount = videoCount;
        
        NSLog(@"字节是：%@",goPro);
        
        NSLog(@"数据是：%@，长度是%lu",dataString,(unsigned long)dataString.length);
        succeedBlock();
     
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
