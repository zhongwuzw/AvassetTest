//
//  ViewController.h
//  AvassetTest
//
//  Created by zhongwu on 14-9-16.
//  Copyright (c) 2014年 boloomo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "AppDelegate.h"
#import "LiveCommandEngine.h"
//#import <AVFoundation/AVMediaFormat.h>

@interface ViewController : UIViewController
- (IBAction)handleButton:(UIButton *)sender;
- (IBAction)collectionTest:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *playButton;
@property (nonatomic, strong) AVPlayer *player;
@property (nonatomic, strong) AVURLAsset *asset;
@property (weak, nonatomic) IBOutlet UIView *testView;
@property (nonatomic, strong) MKNetworkOperation *liveCommandOperation;
@property (nonatomic, strong) NSTimer *liveBroadTimer;


@end

