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

- (NSInteger)handleHexDecimalToInt:(NSString *)subString
{
    NSScanner *scan = [NSScanner scannerWithString:subString];
    unsigned int n = 0;
    [scan scanHexInt:&n];
    return n;
}

- (MKNetworkOperation *)statusInquire:(NSString *)command onSucceeded:(StatusBlock)succeedBlock errorHandler:(MKNKErrorBlock)errorBlock
{
    MKNetworkOperation *op = [self operationWithPath:GOPRO_STATUS_URL(command)];
    
    [op addCompletionHandler:^(MKNetworkOperation *completionOperation){
        NSArray *documentDirectories = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentDirectory = [documentDirectories objectAtIndex:0];
        NSString *finalDirectory = [documentDirectory stringByAppendingPathComponent:@"status.data"];
        
        NSData *data = [NSData dataWithContentsOfFile:finalDirectory];
        NSString *dataString = [data description];
        NSLog(@"%@",data);
        NSString *finalString = [[dataString substringWithRange:NSMakeRange(1, 69)] stringByReplacingOccurrencesOfString:@" " withString:@""];
        
        GoProStatus *goPro = [GoProStatus sharedInstance];
        
        goPro.currentMode = [self handleHexDecimalToInt:[finalString substringWithRange:NSMakeRange(2, 2)]];
        goPro.defaultMode = [self handleHexDecimalToInt:[finalString substringWithRange:NSMakeRange(6, 2)]];
        goPro.Battery = [self handleHexDecimalToInt:[finalString substringWithRange:NSMakeRange(38, 2)]];
        goPro.photosAvailable = [self handleHexDecimalToInt:[finalString substringWithRange:NSMakeRange(42, 4)]];
        goPro.photosCount = [self handleHexDecimalToInt:[finalString substringWithRange:NSMakeRange(46, 4)]];
        goPro.videoRemainMin = [self handleHexDecimalToInt:[finalString substringWithRange:NSMakeRange(50, 4)]];
        goPro.videoCount = [self handleHexDecimalToInt:[finalString substringWithRange:NSMakeRange(54, 4)]];

        NSLog(@"goPro的数据是：%@",goPro);
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
