//
//  GoProStatus.h
//  AvassetTest
//
//  Created by zhongwu on 14-9-26.
//  Copyright (c) 2014年 boloomo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GoProStatus : NSObject
@property NSInteger currentMode;
@property NSInteger defaultMode;
@property NSInteger Battery;
@property NSInteger photosAvailable;
@property NSInteger photosCount;
@property NSInteger videoRemainMin;
@property NSInteger videoCount;
+ (GoProStatus *)sharedInstance;
@end
