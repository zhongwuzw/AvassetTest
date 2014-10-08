//
//  MyCollectionViewController.m
//  AvassetTest
//
//  Created by zhongwu on 14-9-21.
//  Copyright (c) 2014年 boloomo. All rights reserved.
//

#import "MyCollectionViewController.h"

#define USE_IMAGES 1

@interface MyCollectionViewController ()

@end

@implementation MyCollectionViewController

static NSString * const reuseIdentifier = @"Cell";

- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.editButton.currentTitle isEqualToString:@"编辑"]) {
        return NO;
    }
    return YES;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    MyCollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
    UIView *view = [[UIView alloc] initWithFrame:cell.bounds];
    view.opaque = NO;
    view.alpha = 0.5;
    view.backgroundColor = [UIColor whiteColor];
    [cell.contentView addSubview:view];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(70.0, 70.0);
}

//- (id)initWithCollectionViewLayout:(UICollectionViewLayout *)layout
//{
//    if (self = [super initWithCollectionViewLayout:layout]) {
//        [self.collectionViewTest registerClass:[MyCollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
//    }
//    return self;
//}
- (void)setEditing:(BOOL)editing animated:(BOOL)animated{
    [super setEditing:editing animated:animated];
}
//- (UIBarButtonItem *)editButtonItem
//{
//    UIBarButtonItem *button = [[UIBarButtonItem alloc] initWithTitle:@"edit" style:UIBarButtonItemStyleBordered target:self action:nil];
//    
//    UIBarButtonItem *button1 = [[UIBarButtonItem alloc] ini]
//    return button;
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
  //  UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    PunchedLayout *layout = [[PunchedLayout alloc] init];
    [layout registerClass:[DecorationView class] forDecorationViewOfKind:@"decoration"];
    self.view.opaque = NO;
    self.view.backgroundColor = [UIColor colorWithRed: 120. / 0xFF green: 200. / 0xFF blue: 237. / 0xFF alpha: 1];
    
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    // layout.itemSize = CGSizeMake(75.0, 75.0);
    layout.sectionInset = UIEdgeInsetsMake(10.0, 10.0, 10.0, 10.0);
    
    self.editButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.editButton.frame = CGRectMake(270, 15, 40, 30);
    [self.editButton setTitle:@"编辑" forState:UIControlStateNormal];
    [self.editButton addTarget:self action:@selector(handleEditButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.editButton];
    
    self.collectionViewTest = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 50, 320, 530) collectionViewLayout:layout];
    self.collectionViewTest.backgroundColor = [UIColor whiteColor];
    
    // Register cell classes
    [self.collectionViewTest registerClass:[MyCollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    self.collectionViewTest.dataSource = self;
    self.collectionViewTest.delegate = self;
    
    [self.view addSubview:self.collectionViewTest];
    
    NSLog(@"view's frame is %f",self.view.frame.size.height);
    
    //self.collectionViewTest.frame = CGRectMake(0, 0, 320, 300);
    
    // Do any additional setup after loading the view.
}

- (void)handleEditButton:(UIButton *)sender{
    UIButton *button = (UIButton *)sender;
    if ([button.currentTitle  isEqualToString: @"编辑"]) {
        [button setTitle:@"删除" forState:UIControlStateNormal];
    }
    else if ([button.currentTitle isEqualToString:@"删除"])
    {
        [button setTitle:@"编辑" forState:UIControlStateNormal];
    }
    
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

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 7;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 4;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    MyCollectionViewCell *cell = [self.collectionViewTest dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    // Configure the cell
#if USE_IMAGES
    cell.imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"sa%ld.jpg",(long)indexPath.item]];
    
#else
    CGFloat hue = ((CGFloat)indexPath.item)/7;
    UIColor *cellColor = [UIColor colorWithHue:hue saturation:1.0 brightness:1.0 alpha:1.0];
    cell.contentView.backgroundColor = cellColor;

#endif
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    return CGSizeMake(60.0f, 30.0f);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
{
    return CGSizeMake(60.0f, 30.0f);
}

#pragma mark <UICollectionViewDelegate>

- (BOOL)collectionView:(UICollectionView *)collectionView shouldDeselectItemAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}
/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

@end
