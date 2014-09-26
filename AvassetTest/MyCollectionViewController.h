//
//  MyCollectionViewController.h
//  AvassetTest
//
//  Created by zhongwu on 14-9-21.
//  Copyright (c) 2014年 boloomo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyCollectionViewCell.h"
#import "PunchedLayout.h"
#import "DecorationView.h"

@interface MyCollectionViewController : UIViewController<UICollectionViewDelegateFlowLayout,UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, strong)UICollectionView *collectionViewTest;
@property (nonatomic, strong)UIButton *editButton;

@end
