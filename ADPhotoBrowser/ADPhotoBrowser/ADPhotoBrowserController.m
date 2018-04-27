//
//  ADPhotoBrowserController.m
//  ADPhotoBrowser
//
//  Created by Zeaple on 16/5/26.
//  Copyright © 2016年 Zeaple. All rights reserved.
//

#import "ADPhotoBrowserController.h"

static NSString *const kADMainCollectionViewCellReuseIdentifier = @"ad.mainCollectionViewCell";

CGFloat const photoGap = 20;

#define Main_Screen_Height      [[UIScreen mainScreen] bounds].size.height
#define Main_Screen_Width       [[UIScreen mainScreen] bounds].size.width

#import "ADMainCollectionCell.h"

#import "ADPhoto.h"

@interface ADPhotoBrowserController ()<UICollectionViewDataSource, UICollectionViewDelegate>
@property(strong, nonatomic)UICollectionView *mainCollectionView;
@property(strong, nonatomic)NSMutableArray *adPhotoUrls;
@end

@implementation ADPhotoBrowserController

#pragma mark - LifeCircle

- (instancetype)init
{
    self = [super init];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initPhotoData];
    [self setUpMainCollectionView];
    [self scrollToCurrentIndex];
    // Do any additional setup after loading the view.
}

#pragma mark - PrviateMethods

- (void)initPhotoData {
    
    self.adPhotoUrls = [NSMutableArray array];
    int i=0;
    for (NSString *url in self.highQualityPhotoUrls) {
        ADPhoto *a = [[ADPhoto alloc]init];
        a.highQualityPhotoUrl = url;
        a.lowQualityPhotoUrl = self.lowQualityPhotoUrls[i];
        [self.adPhotoUrls addObject:a];
        i++;
    }
}

- (void)setUpMainCollectionView {
    
    UICollectionViewFlowLayout *layOut = [[UICollectionViewFlowLayout alloc]init];
    layOut.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layOut.minimumLineSpacing = 0;
    layOut.minimumInteritemSpacing = 0;
    layOut.itemSize = CGSizeMake(Main_Screen_Width+photoGap, Main_Screen_Height);
    
    self.mainCollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width+20, Main_Screen_Height) collectionViewLayout:layOut];
    self.mainCollectionView.delegate = self;
    self.mainCollectionView.dataSource = self;
    self.mainCollectionView.pagingEnabled = YES;
    [self.view addSubview:self.mainCollectionView];
    //    self.mainCollectionView.backgroundColor = [UIColor clearColor];
    
    [self.mainCollectionView registerClass:[ADMainCollectionCell class] forCellWithReuseIdentifier:kADMainCollectionViewCellReuseIdentifier];
}

- (void)scrollToCurrentIndex {
    
    if (self.currentIndex) {
        NSIndexPath *currentIndex = [NSIndexPath indexPathForRow:self.currentIndex inSection:0];
        [self.mainCollectionView scrollToItemAtIndexPath:currentIndex atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
    }
}

#pragma Delegates - 
#pragma mark - CollectionViewDelegate

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.adPhotoUrls.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    ADMainCollectionCell *cell = [self.mainCollectionView dequeueReusableCellWithReuseIdentifier:kADMainCollectionViewCellReuseIdentifier forIndexPath:indexPath];
    cell.photoData = self.adPhotoUrls[indexPath.row];
    return cell;
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
