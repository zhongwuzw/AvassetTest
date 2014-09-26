//
//  ViewController.m
//  AvassetTest
//
//  Created by zhongwu on 14-9-16.
//  Copyright (c) 2014年 boloomo. All rights reserved.
//

#import "ViewController.h"
#import "MyCollectionViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  //  NSURL *m = [[NSBundle mainBundle] URLForResource:@"Movie" withExtension:@"m4v"];
 //   NSURL *m = [NSURL URLWithString:@"http://10.5.5.9:8080/live/amba.m3u8"];
  //  AVURLAsset *asset = [AVURLAsset URLAssetWithURL:m options:nil];
  //  AVPlayerItem *item = [AVPlayerItem playerItemWithAsset:asset];
   // AVPlayer *p = [AVPlayer playerWithPlayerItem:item];
    self.playButton.enabled = NO;
  //  NSURL *m = [NSURL URLWithString:@"http://devimages.apple.com/iphone/samples/bipbop/bipbopall.m3u8"];
//    self.asset = [AVURLAsset URLAssetWithURL:m options:nil];
//    AVPlayerItem *item = [AVPlayerItem playerItemWithAsset:self.asset];
//    AVPlayer *p = [AVPlayer playerWithURL:m];
 //   AVPlayer *p = [AVPlayer playerWithPlayerItem:item];
 //   AVPlayer *p = [[AVPlayer alloc] initWithURL:m];
//    self.player = p;
//    [self.player addObserver:self forKeyPath:@"status" options:0 context:nil];
//    AVPlayerLayer *lay = [AVPlayerLayer playerLayerWithPlayer:p];
//    lay.frame = CGRectMake(10, 10, 300, 200);
//    [self.view.layer addSublayer:lay];
    
    UIView *controlView = [[UIView alloc] initWithFrame:CGRectMake(10, 10, 300, 200)];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    [button setFrame:CGRectMake(10, 10, 30, 30)];
    [button setTitle:@"test" forState:UIControlStateNormal];
    [controlView addSubview:button];
    
    [self.view addSubview:controlView];
    UISlider *shit = [[UISlider alloc] initWithFrame:CGRectMake(10, 20, 100, 60)];
    [self.testView addSubview:shit];
    
    self.liveCommandOperation = [ApplicationDelegate.liveCommandEngine startPreview:@"PV" symbol:@"02" onSucceeded:^(void){
        NSLog(@"finish recommit");
        NSURL *m = [NSURL URLWithString:@"http://10.5.5.9:8080/live/amba.m3u8"];
        self.player = [AVPlayer playerWithURL:m];
        [self.player addObserver:self forKeyPath:@"status" options:0 context:nil];
        AVPlayerLayer *lay = [AVPlayerLayer playerLayerWithPlayer:self.player];
       // lay.frame = CGRectMake(10, 10, 300, 200);
        lay.frame = self.view.bounds;
        [self.view.layer addSublayer:lay];
       // self.liveBroadView.backgroundColor = [UIColor blackColor];
       // [self.view addSubview:self.liveBroadView];
    }errorHandler:^(NSError *error){
        NSLog(@"commit error");
        DLog(@"%@\t%@\t%@\t%@",[error localizedDescription],[error localizedFailureReason],[error localizedRecoveryOptions],[error localizedRecoverySuggestion]);
    }];
    self.liveBroadTimer = [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(handleLiveCommand) userInfo:nil repeats:YES];
    
    self.liveCommandOperation = [ApplicationDelegate.liveCommandEngine statusInquire:@"se" onSucceeded:^(void){
        
    }errorHandler:^(NSError *error){
        NSLog(@"commit error");
        DLog(@"%@\t%@\t%@\t%@",[error localizedDescription],[error localizedFailureReason],[error localizedRecoveryOptions],[error localizedRecoverySuggestion]);
    }];
    
   // uint8_t buf[1024];
    NSArray *documentDirectories = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDirectory = [documentDirectories objectAtIndex:0];
    NSString *finalDirectory = [documentDirectory stringByAppendingPathComponent:@"status.data"];
    
    [self.liveCommandOperation addDownloadStream:[NSOutputStream outputStreamToFileAtPath:finalDirectory append:NO]];
    
//    NSData *data = [NSData dataWithContentsOfFile:finalDirectory];
//    NSString *dataString = [data description];
//    NSLog(@"数据是：%@",dataString);
    
    
    //[self.liveCommandOperation addDownloadStream:[NSOutputStream outputStreamToBuffer:buf capacity:1024]];
    
    
    //[self.liveCommandOperation addDownloadStream:[NSOutputStream outputStreamToBuffer:buf capacity:1024]];
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    if (object == self.player && [keyPath isEqualToString:@"status"]) {
        if (self.player.status == AVPlayerStatusReadyToPlay) {
            [self.player play];
            self.playButton.enabled = YES;
            
        }
        else if (self.player.status == AVPlayerStatusFailed)
        {
            NSLog(@"shit");
        }
    }
}

- (void)handleLiveCommand{
    self.liveCommandOperation = [ApplicationDelegate.liveCommandEngine startPreview:@"PV" symbol:@"02" onSucceeded:^(void){
     //   NSLog(@"preview commit Success!");
        [self.player play];
        
    }errorHandler:^(NSError *error){
        
        NSLog(@"preview commit error!");
        DLog(@"%@\t%@\t%@\t%@",[error localizedDescription],[error localizedFailureReason],[error localizedRecoveryOptions],[error localizedRecoverySuggestion]);
        
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)handleButton:(UIButton *)sender {
    [self.player play];
    NSInteger i = self.asset.tracks.count;
    NSLog(@"%ld",i);
    
}

- (IBAction)collectionTest:(id)sender {
//    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
//    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
//   
//    layout.sectionInset = UIEdgeInsetsMake(10.0, 10.0, 10.0, 10.0);
    
 //   MyCollectionViewController *mcc = [[MyCollectionViewController alloc] initWithCollectionViewLayout:layout];
    MyCollectionViewController *mcc = [[MyCollectionViewController alloc] init];

    mcc.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self presentViewController:mcc animated:YES completion:nil];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
  //  NSURL *m = [[NSBundle mainBu/Users/frank/Downloads/MKNetworkKit-master/MKNetworkKitndle] URLForResource:@"G0010217.LRV" withExtension:@"mp4"];
  //  NSURL *m = [NSURL URLWithString:@"http://10.5.5.9:8080/DCIM/100GOPRO/GOPR0221.MP4"];
  //  NSURL *m = [NSURL URLWithString:@"http://10.5.5.9:8080/live/amba.m3u8"];
    //  AVURLAsset *asset = [AVURLAsset URLAssetWithURL:m options:nil];
    //  AVPlayerItem *item = [AVPlayerItem playerItemWithAsset:asset];
    // AVPlayer *p = [AVPlayer playerWithPlayerItem:item];
  //  self.playButton.enabled = NO;
  //  NSURL *m = [NSURL URLWithString:@"http://devimages.apple.com/iphone/samples/bipbop/bipbopall.m3u8"];
  //  self.asset = [AVURLAsset URLAssetWithURL:m options:nil];
  //  AVPlayerItem *item = [AVPlayerItem playerItemWithAsset:self.asset];
  //  AVPlayer *p = [AVPlayer playerWithURL:m];
    //   AVPlayer *p = [AVPlayer playerWithPlayerItem:item];
    //   AVPlayer *p = [[AVPlayer alloc] initWithURL:m];
//    self.player = p;
//    [self.player addObserver:self forKeyPath:@"status" options:0 context:nil];
//    AVPlayerLayer *lay = [AVPlayerLayer playerLayerWithPlayer:p];
//    lay.frame = self.view.bounds;
//    [self.view.layer addSublayer:lay];
    
}
@end
