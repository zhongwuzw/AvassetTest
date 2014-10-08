//
//  TestPageViewController.m
//  AvassetTest
//
//  Created by zhongwu on 14-9-29.
//  Copyright (c) 2014年 boloomo. All rights reserved.
//

#import "TestPageViewController.h"

@interface TestPageViewController ()

@end

@implementation TestPageViewController

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
        TestViewController *mcc = [self.storyboard instantiateViewControllerWithIdentifier:@"test"];
    // TestStoryViewController *mcc = [[TestStoryViewController alloc] init];
    return mcc;
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    TestViewController *mcc = [self.storyboard instantiateViewControllerWithIdentifier:@"test"];
   //  TestStoryViewController *mcc = [[TestStoryViewController alloc] init];
    return mcc;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
     //   StoryBoardViewController *mcc = [self.storyboard instantiateViewControllerWithIdentifier:@"t"];
//        [[NSBundle mainBundle] loadNibNamed:@"TestStoryViewController" owner:self options:nil];
//        TestStoryViewController *mcc = [[TestStoryViewController alloc] init];
   //     MyCollectionViewController *mcc1 = [[MyCollectionViewController alloc] init];

    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
   //  TestViewController *mcc = [[TestViewController alloc] init];
    TestViewController *mcc = [self.storyboard instantiateViewControllerWithIdentifier:@"test"];
  //  TestViewController *mcc = [[TestViewController alloc] init];
    [self setViewControllers:[NSArray arrayWithObjects:mcc, nil] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];

    self.delegate = self;
    self.dataSource = self;
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
