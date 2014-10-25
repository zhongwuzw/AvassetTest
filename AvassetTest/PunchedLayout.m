//
//  PunchedLayout.m
//  AvassetTest
//
//  Created by zhongwu on 14-9-22.
//  Copyright (c) 2014年 boloomo. All rights reserved.
//

#import "PunchedLayout.h"
@interface PunchedLayout()

@property (nonatomic, strong)NSIndexPath *pinchItem;
@property (nonatomic) CGSize pinchedItemSize;

@end

@implementation PunchedLayout

- (void)resizeItemAtIndexPath:(NSIndexPath *)indexPath withPinchDistance:(CGFloat)distance
{
    self.pinchItem = indexPath;
    self.pinchedItemSize = CGSizeMake(distance, distance);
}

- (void)resizePinchedItem
{
    self.pinchedItemSize = CGSizeMake(70.00, 70.00);
 //   self.pinchItem = nil;
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
    NSArray *attrs = [super layoutAttributesForElementsInRect:rect];

    UICollectionViewLayoutAttributes *attr = [[attrs filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"indexPath == %@",_pinchItem]] firstObject];
    attr.size = _pinchedItemSize;
    attr.zIndex = 100;
    return attrs;
}

//- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
//{
//    return YES;
//}
//
//- (UICollectionViewLayoutAttributes *)initialLayoutAttributesForAppearingItemAtIndexPath:(NSIndexPath *)itemIndexPath
//{
//    UICollectionViewLayoutAttributes *attributes = [self layoutAttributesForItemAtIndexPath:itemIndexPath];
//    attributes.alpha = 0.0;
//    
//    CGSize size = [self collectionView].frame.size;
//    attributes.center = CGPointMake(size.width / 2.0, size.height / 2.0);
//    return attributes;
//}
//
//- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
//{
//    NSArray *array = [super layoutAttributesForElementsInRect:rect];
//    NSLog(@"array count is %lu",(unsigned long)array.count);
//    for (UICollectionViewLayoutAttributes *attributes in array) {
//        if (!CGRectIntersectsRect(attributes.frame, rect))
//            continue;
//        
//        CGSize boundsSize = self.collectionView.bounds.size;
//        CGFloat midX = boundsSize.width / 2.0f;
//        CGPoint contentOffSet = self.collectionView.contentOffset;
//        CGPoint itemCenter = CGPointMake(attributes.center.x - contentOffSet.x, attributes.center.y - contentOffSet.y);
//        CGFloat distance = ABS(midX - itemCenter.x);
//        
//        CGFloat normalized = distance/midX;
//        normalized = MIN(1.0f, normalized);
//        CGFloat zoom = cos(normalized*M_PI_4);
//        
//        attributes.transform3D = CATransform3DMakeScale(zoom, zoom, 1.0f);
//    }
//    
//    
//    
//    return array;
//}
//
//- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity
//{
//    CGFloat offsetAdjustment = MAXFLOAT;
//    
//    NSLog(@"collectionViewContentSize is %f",self.collectionViewContentSize.width);
//    
//    CGSize boundsSize = self.collectionView.bounds.size;
//    CGFloat midX = boundsSize.width/2.0f;
//    
//    CGRect targetRect = CGRectMake(proposedContentOffset.x, 0.0, boundsSize.width, boundsSize.height);
//    NSArray *array = [super layoutAttributesForElementsInRect:targetRect];
//    
//    CGFloat proposedCenterX = proposedContentOffset.x + midX;
//    
//    for (UICollectionViewLayoutAttributes *layoutAttributes in array) {
//        CGFloat distance = layoutAttributes.center.x - proposedCenterX;
//        if (ABS(distance) < ABS(offsetAdjustment)) {
//            offsetAdjustment = distance;
//        }
//    }
//    
//    CGPoint desiredPoint = CGPointMake(proposedContentOffset.x + offsetAdjustment, proposedContentOffset.y);
//    
//    if ((proposedContentOffset.x == 0) || (proposedContentOffset.x >= (self.collectionViewContentSize.width - boundsSize.width))) {
//        return proposedContentOffset;
//    }
//    
//    return desiredPoint;
//}

@end
