//
//  BaseModel.h
//  zoneSun
//
//  Created by Zeaple on 16/4/27.
//  Copyright © 2016年 Zeaple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaseModel : NSObject
@property(nonatomic, copy)NSString * d_pic_url;
@property(nonatomic, copy)NSString * pic_url;
+ (BaseModel *)modelWithDic:(NSDictionary *)dic;
@end
