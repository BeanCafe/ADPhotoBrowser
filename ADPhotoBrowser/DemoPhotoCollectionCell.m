//
//  DemoPhotoCollectionCell.m
//  ADPhotoBrowser
//
//  Created by Zeaple on 16/5/25.
//  Copyright © 2016年 Zeaple. All rights reserved.
//

#import "DemoPhotoCollectionCell.h"

#import "UIKit+AFNetworking.h"

#import "BaseModel.h"

@implementation DemoPhotoCollectionCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setPhotoModel:(BaseModel *)photoModel {
    _photoModel = photoModel;    
    [self.photo setImageWithURL:[NSURL URLWithString:photoModel.d_pic_url]];
}
@end
