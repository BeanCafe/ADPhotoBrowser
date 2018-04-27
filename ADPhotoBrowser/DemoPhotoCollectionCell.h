//
//  DemoPhotoCollectionCell.h
//  ADPhotoBrowser
//
//  Created by Zeaple on 16/5/25.
//  Copyright © 2016年 Zeaple. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BaseModel;

@interface DemoPhotoCollectionCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *photo;
@property (strong, nonatomic)BaseModel *photoModel;
@end
