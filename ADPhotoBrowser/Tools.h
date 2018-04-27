//
//  Tools.h
//  TianXingPlanet
//
//  Created by Zeaple on 15/8/12.
//  Copyright (c) 2015年 Zyii. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
typedef void(^afterResultBlock)(NSDictionary *resultDic);
typedef void(^errorActionBlock)(NSError *error);

@interface Tools : NSObject

#pragma mark - 计算Label竖直方向高度

+ (CGFloat)makeVircalHeightLabelWidth:(CGFloat)labelWidth andFontSize:(CGFloat)size andText:(NSString *)text;

#pragma mark - JsonDataToString

+ (NSString *)stringConvertToJsonString:(id)aString;

#pragma mark - HUD


#pragma mark - ViewController

+(void)popViewControllerAfterDelay:(NSInteger)delay WithController:(UIViewController *)viewController;

+(void)dismissViewControllerAfterDelay:(NSInteger)delay WithController:(UIViewController *)viewController;

+(NSString *)transferPhoneNumToSecretTypeWithNum:(NSString *)phoneNum;

#pragma mark - AFNetworking

//不带参数的get请求
+ (void)AFNetworkingRequestTypeGETWithUrl:(NSString *)url  afterResultBlock:(afterResultBlock)resultAct;
//带参数get请求
+ (void)AFNetworkingRequestTypeGETWithUrl:(NSString *)url paramters:(id)paramters afterResultBlock:(afterResultBlock)resultAct;
//多参数POST请求
+ (void)AFNetworkingRequestTypePOSTWithUrl:(NSString *)url MultiParamters:(id)paramters afterResultBlock:(afterResultBlock)resultAct;
//自行处理错误信息
+ (void)AFNetworkingRequestTypeGETWithUrl:(NSString *)url paramters:(id)paramters afterResultBlock:(afterResultBlock)resultAct handleErrorBlock:(errorActionBlock)errorAct;

//取消网络请求
+ (void)cancelAllNetworkRequests;

@end
