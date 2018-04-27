//
//  Tools.m
//  TianXingPlanet
//
//  Created by Zeaple on 15/8/12.
//  Copyright (c) 2015年 Zyii. All rights reserved.
//

#import "Tools.h"
#import "AFNetworking.h"
#import "SVProgressHUD.h"

@implementation Tools

#pragma mark - 计算Label竖直方向高度

+ (CGFloat)makeVircalHeightLabelWidth:(CGFloat)labelWidth andFontSize:(CGFloat)size andText:(NSString *)text{
    CGFloat height = 0;
    UILabel *vircal = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, labelWidth, 0)];
    vircal.text = text;
    vircal.numberOfLines = 0;
    vircal.lineBreakMode = NSLineBreakByWordWrapping;
    vircal.textAlignment = NSTextAlignmentLeft;
    vircal.font = [UIFont systemFontOfSize:size];
    [vircal sizeToFit];
    height = vircal.frame.size.height;
    return height;
}

#pragma mark - JsonDataToString
+ (NSString *)stringConvertToJsonString:(id)aString {
    NSData *jsonData = [NSJSONSerialization
                           dataWithJSONObject:aString options:NSJSONWritingPrettyPrinted error:nil];
    return [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
}
#pragma mark-ViewController
+(void)popViewControllerAfterDelay:(NSInteger)delay WithController:(UIViewController *)viewController {
    Tools *instanceTool = [[Tools alloc]init];
    [instanceTool performSelector:@selector(popAfterDelay:) withObject:viewController afterDelay:delay];
}
-(void)popAfterDelay:(UIViewController *)vc {
    [vc.navigationController popViewControllerAnimated:YES];
}
//dismissController
+(void)dismissViewControllerAfterDelay:(NSInteger)delay WithController:(UIViewController *)viewController {
    Tools *instanceTool = [[Tools alloc]init];
    [instanceTool performSelector:@selector(dismissAfterDelay:) withObject:viewController afterDelay:delay];
}
-(void)dismissAfterDelay:(UIViewController *)vc {
    [vc dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark-将手机号替换成180****0811形式
+(NSString *)transferPhoneNumToSecretTypeWithNum:(NSString *)phoneNum {
    NSRange secretPhoneRange;
    secretPhoneRange.length = 4;
    secretPhoneRange.location = 3;
    NSString *secretPhoneTypeStr = [phoneNum stringByReplacingCharactersInRange:secretPhoneRange withString:@"****"];
    return secretPhoneTypeStr;
}

+ (void)AFNetworkingRequestTypeGETWithUrl:(NSString *)url  afterResultBlock:(afterResultBlock)resultAct{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:url parameters:nil success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        if (!responseObject) {
            [SVProgressHUD showErrorWithStatus:@"No Data!"];
        } else {
            resultAct(responseObject);
        }
    } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
        if (error.localizedDescription) {
            if (error.code == -999) {
                [SVProgressHUD dismiss];
            } else {
                [SVProgressHUD showErrorWithStatus:error.localizedDescription];
            }
        }
    }];
}
+ (void)AFNetworkingRequestTypeGETWithUrl:(NSString *)url paramters:(id)paramters afterResultBlock:(afterResultBlock)resultAct{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:url parameters:paramters success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        if (!responseObject) {
            [SVProgressHUD showErrorWithStatus:@"No Data!"];
        } else {
            resultAct(responseObject);
        }
    } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
        if (error.localizedDescription) {
            if (error.code == -999) {
                [SVProgressHUD dismiss];
            } else {
                [SVProgressHUD showErrorWithStatus:error.localizedDescription];
            }
        }
    }];
}

//Wish To Handle Error Action
+ (void)AFNetworkingRequestTypeGETWithUrl:(NSString *)url paramters:(id)paramters afterResultBlock:(afterResultBlock)resultAct handleErrorBlock:(errorActionBlock)errorAct{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:url parameters:paramters success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        if (!responseObject) {
            [SVProgressHUD showErrorWithStatus:@"No Data!"];
        } else {
            resultAct(responseObject);
        }
    } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
        if (error.localizedDescription) {
            if (error.code == -999) {
                [SVProgressHUD dismiss];
            } else {
                [SVProgressHUD showErrorWithStatus:error.localizedDescription];
            }
            errorAct(error);
        }
    }];
}

+ (void)AFNetworkingRequestTypePOSTWithUrl:(NSString *)url MultiParamters:(id)paramters afterResultBlock:(afterResultBlock)resultAct{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager GET:url parameters:paramters success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        manager.requestSerializer = [AFHTTPRequestSerializer serializer];
        if (!responseObject) {
            [SVProgressHUD showErrorWithStatus:@"No Data!"];
        } else {
            resultAct(responseObject);
        }
    } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
        if (error.localizedDescription) {
            if (error.code == -999) {
                [SVProgressHUD dismiss];
            } else {
                [SVProgressHUD showErrorWithStatus:error.localizedDescription];
            }
        }
    }];
}

+ (void)cancelAllNetworkRequests {
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager.operationQueue cancelAllOperations];
}

@end
