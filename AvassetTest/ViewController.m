//
//  ViewController.m
//  AvassetTest
//
//  Created by zhongwu on 14-9-16.
//  Copyright (c) 2014年 boloomo. All rights reserved.
//

#import "ViewController.h"


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
    
//    NSURL *m = [NSURL URLWithString:@"http://www.nasa.gov/multimedia/nasatv/NTV-Public-IPS.m3u8"];
//    self.player = [AVPlayer playerWithURL:m];
//    [self.player addObserver:self forKeyPath:@"status" options:0 context:nil];
//    AVPlayerLayer *lay = [AVPlayerLayer playerLayerWithPlayer:self.player];
//    lay.frame = CGRectMake(10, 10, 300, 200);
//    // lay.frame = self.view.bounds;
//    [self.view.layer addSublayer:lay];
    
    NSArray *documentDirectories = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    self.documentDirectory = [documentDirectories objectAtIndex:0];
    
    
    self.liveCommandOperation = [ApplicationDelegate.liveCommandEngine startPreview:@"PV" symbol:@"02" onSucceeded:^(void){
        NSLog(@"finish recommit");
        NSURL *m = [NSURL URLWithString:@"http://10.5.5.9:8080/live/amba.m3u8"];
        self.player = [AVPlayer playerWithURL:m];
        [self.player.currentItem addObserver:self forKeyPath:@"status" options:0 context:nil];
        AVPlayerLayer *lay = [AVPlayerLayer playerLayerWithPlayer:self.player];
        lay.frame = CGRectMake(10, 10, 300, 200);
        [self.view.layer addSublayer:lay];
    

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

    NSString *finalDirectory = [self.documentDirectory stringByAppendingPathComponent:@"status.data"];
    
    [self.liveCommandOperation addDownloadStream:[NSOutputStream outputStreamToFileAtPath:finalDirectory append:NO]];
    
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"test"]];
    imageView.frame = CGRectMake(10, 250, 50, 50);
    imageView.layer.masksToBounds = YES;
    imageView.layer.cornerRadius = 25;
    [self.view addSubview:imageView];
    
    
    UIView *redView = [[UIView alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2,0, 30, 30)];
    redView.backgroundColor = [UIColor redColor];
    [self.view addSubview:redView];
    
//    self.animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
//    
//    UISnapBehavior *snapBehaviour = [[UISnapBehavior alloc] initWithItem:redView snapToPoint:self.view.center];
//    snapBehaviour.damping = 0.8f;
//    [self.animator addBehavior:snapBehaviour];
    
    self.animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
    UIGravityBehavior *gravityBehavior = [[UIGravityBehavior alloc] initWithItems:@[redView]];
    gravityBehavior.gravityDirection = CGVectorMake(-1.0, 0);
    [self.animator addBehavior:gravityBehavior];
    
    UICollisionBehavior *collisionBehavior = [[UICollisionBehavior alloc] initWithItems:@[redView]];
    collisionBehavior.translatesReferenceBoundsIntoBoundary = YES;
    [self.animator addBehavior:collisionBehavior];
    
    UIDynamicItemBehavior *elasticityBehavior = [[UIDynamicItemBehavior alloc] initWithItems:@[redView]];
    elasticityBehavior.elasticity = 0.7f;
    [self.animator addBehavior:elasticityBehavior];
    
    @autoreleasepool {
        NSLog(@"starting thread....");
        NSTimer *timer = [NSTimer timerWithTimeInterval:2 target:self selector:@selector(doTimerTask) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];
        
    }
    
//    NSData *data = [NSData dataWithContentsOfFile:finalDirectory];
//    NSString *dataString = [data description];
//    NSLog(@"数据是：%@",dataString);
    
    
    //[self.liveCommandOperation addDownloadStream:[NSOutputStream outputStreamToBuffer:buf capacity:1024]];
    
    
    //[self.liveCommandOperation addDownloadStream:[NSOutputStream outputStreamToBuffer:buf capacity:1024]];
    
    // Do any additional setup after loading the view, typically from a nib.    
}

- (void)doTimerTask
{
    NSLog(@"do timer task");
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [self.player.currentItem removeObserver:self forKeyPath:@"status"];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    if (object == self.player.currentItem && [keyPath isEqualToString:@"status"]) {
        if (self.player.currentItem.status == AVPlayerStatusReadyToPlay) {
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
    self.liveCommandOperation = [ApplicationDelegate.liveCommandEngine statusInquire:@"se" onSucceeded:^(void){
        
    }errorHandler:^(NSError *error){
        NSLog(@"commit error");
        DLog(@"%@\t%@\t%@\t%@",[error localizedDescription],[error localizedFailureReason],[error localizedRecoveryOptions],[error localizedRecoverySuggestion]);
    }];
    self.liveCommandOperation = [ApplicationDelegate.liveCommandEngine startPreview:@"PV" symbol:@"02" onSucceeded:^(void){
     //   NSLog(@"preview commit Success!");
      //  [self.player play];
        
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
    [self.player setRate:0.0f];
}

- (IBAction)collectionTest:(id)sender {
//    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
//    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
//   
//    layout.sectionInset = UIEdgeInsetsMake(10.0, 10.0, 10.0, 10.0);
    
 //   MyCollectionViewController *mcc = [[MyCollectionViewController alloc] initWithCollectionViewLayout:layout];

  //  MyCollectionViewController *mcc = [[MyCollectionViewController alloc] init];
    self.mcc = [[MyCollectionViewController alloc] init];
    self.mcc.editing = YES;
    self.mcc.navigationItem.leftBarButtonItem = [self.mcc editButtonItem];

    self.mcc.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
//    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:mcc];
//    [self presentViewController:nav animated:YES completion:nil];
   [self.view addSubview:self.mcc.view];
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
- (IBAction)handleUploadStream:(UIButton *)sender {
    self.liveUploadTimer = [NSTimer scheduledTimerWithTimeInterval:4.5f target:self selector:@selector(handleLiveUpload) userInfo:nil repeats:YES];
}

- (void)handleLiveUpload{
    double delayInSeconds = 0.00;
    for (int i = 1; i <= 16; i+=1) {
        if (i == 1) {
            delayInSeconds = 0.0;
        }else if (i == 5 || i == 9 || i == 13)
            delayInSeconds += 1.00;
        else
            delayInSeconds += 0.01 ;
        
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            NSString *file = [[NSString alloc] initWithFormat:@"amba_hls-%d.ts",i];
            self.liveDownloadTSOperation = [ApplicationDelegate.liveDownloadEngine downLoadTS:file onSucceeded:^(void){
                
            }errorHandler:^(NSError *error){
                NSLog(@"download error");
                DLog(@"%@\t%@\t%@\t%@",[error localizedDescription],[error localizedFailureReason],[error localizedRecoveryOptions],[error localizedRecoverySuggestion]);
            }];
            NSDate *date = [NSDate date];
            NSTimeInterval aInterval = [date timeIntervalSince1970];
            NSString *timeString = [NSString stringWithFormat:@"%f",aInterval];
            NSString *saveFile = [self.documentDirectory stringByAppendingPathComponent:[[NSString alloc] initWithFormat:@"%@.ts",timeString]];
            [self.liveDownloadTSOperation addDownloadStream:[NSOutputStream outputStreamToFileAtPath:saveFile append:NO]];
        });
    }
}
@end
