//
//  ViewController.m
//  ADPhotoBrowser
//
//  Created by Zeaple on 16/5/25.
//  Copyright © 2016年 Zeaple. All rights reserved.
//

#import "ViewController.h"


#import "Tools.h"
#import "BaseModel.h"
#import "ADPhotoView.h"

#import "ADPhotoBrowserController.h"
#import "ADTransitionDelegate.h"

#import "DemoPhotoCollectionCell.h"

static NSString *const kDemoPhotoCollectionCellReuseIdentifier = @"ad.DemoPhotoCollectionCell";

@interface ViewController ()<UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, UIViewControllerTransitioningDelegate>
@property(strong, nonatomic)NSMutableArray *photoUrlsArray;
@property(strong, nonatomic)NSMutableArray *hPhotoUrls;
@property(strong, nonatomic)NSMutableArray *lPhotoUrls;
@property(strong, nonatomic)ADTransitionDelegate *animate;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadPhotoUrls];
    
//    [self setUpADPhotoView];
    [self setUpCollectionView];
    self.animate = [[ADTransitionDelegate alloc]init];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)loadPhotoUrls {
    
    self.photoUrlsArray = [NSMutableArray array];
    self.hPhotoUrls = [NSMutableArray array];
    self.lPhotoUrls = [NSMutableArray array];
    NSString *url = @"http://mobapi.meilishuo.com/2.0/twitter/popular.json";
    NSDictionary *parm = @{@"offset":@"\(offset)", @"limit":@"30", @"access_token":@"b92e0c6fd3ca919d3e7547d446d9a8c2"};
    [Tools AFNetworkingRequestTypeGETWithUrl:url paramters:parm afterResultBlock:^(NSDictionary *resultDic) {
        NSLog(@"%@", resultDic);
        
        NSArray *data = resultDic[@"data"];
        for (NSDictionary *dic in data) {
            BaseModel *model = [BaseModel modelWithDic:dic];
            [self.photoUrlsArray addObject:model];
            [self.hPhotoUrls addObject:model.pic_url];
            [self.lPhotoUrls addObject:model.d_pic_url];
        }
        [self.collectionView reloadData];
    }];
}

- (void)setUpADPhotoView {
    ADPhotoView *a = [[ADPhotoView alloc]initWithFrame:self.view.bounds];
//    [a.adImageView setImageWithURL:[NSURL URLWithString:@"http://d04.res.meilishuo.net/pic/u/0b/da/caa34ddada157f8784547f74fb9a_640_832.c1.png"]];
    [a.adImageView setImageWithURL:[NSURL URLWithString:@"http://d04.res.meilishuo.net/pic/u/07/81/f36e679f00895ed3d979947b57c2_640_832.c5.jpg"]];
    [self.view addSubview:a];
}

- (void)setUpCollectionView {
    
    UICollectionViewFlowLayout *layOut = [[UICollectionViewFlowLayout alloc]init];
    layOut.scrollDirection = UICollectionViewScrollDirectionVertical;
    layOut.minimumLineSpacing = 5;
    layOut.minimumInteritemSpacing = 0;
    layOut.itemSize = CGSizeMake(100, 100);
    
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 20, self.view.frame.size.width, self.view.frame.size.height-20) collectionViewLayout:layOut];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.view addSubview:self.collectionView];
    self.collectionView.backgroundColor = [UIColor clearColor];
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"DemoPhotoCollectionCell" bundle:nil] forCellWithReuseIdentifier:kDemoPhotoCollectionCellReuseIdentifier];
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.photoUrlsArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    DemoPhotoCollectionCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:kDemoPhotoCollectionCellReuseIdentifier forIndexPath:indexPath];
    cell.photoModel = self.photoUrlsArray[indexPath.row];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (self.selectedIndexPath) {
        self.selectedIndexPath = nil;
    }
    self.selectedIndexPath = indexPath;
    
    ADPhotoBrowserController *a = [[ADPhotoBrowserController alloc]init];
    a.currentIndex = indexPath.row;
    a.highQualityPhotoUrls = (NSArray *)self.hPhotoUrls;
    a.lowQualityPhotoUrls = (NSArray *)self.lPhotoUrls;
    a.modalPresentationStyle = UIModalPresentationCustom;
    a.transitioningDelegate = self;
    [self presentViewController:a animated:YES completion:nil];
}

- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    return self.animate;
}

- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    return nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
