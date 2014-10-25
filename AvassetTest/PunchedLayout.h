//
//  PunchedLayout.h
//  AvassetTest
//
//  Created by zhongwu on 14-9-22.
//  Copyright (c) 2014年 boloomo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PunchedLayout : UICollectionViewFlowLayout

- (void)resizeItemAtIndexPath:(NSIndexPath *)indexPath withPinchDistance:(CGFloat)distance;
- (void)resizePinchedItem;

@end
