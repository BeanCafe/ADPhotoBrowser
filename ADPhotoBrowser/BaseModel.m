//
//  BaseModel.m
//  zoneSun
//
//  Created by Zeaple on 16/4/27.
//  Copyright © 2016年 Zeaple. All rights reserved.
//

#import "BaseModel.h"

@implementation BaseModel
+ (BaseModel *)modelWithDic:(NSDictionary *)dic {
    return [[[self class] alloc]initWithDic:dic];
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
//    NSLog(@"key: %@, value: %@", key, value);
}

- (instancetype)initWithDic:(NSDictionary *)dic {
    self = [super init];
    if (self) {
        [self setValuesForKeysWithDictionary:dic];
    }
    return self;
}

@end
