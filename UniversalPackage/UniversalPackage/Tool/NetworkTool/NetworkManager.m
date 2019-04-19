//
//  NetworkTool.m
// RabbitConyYok
//
//  Created by Single_Nobel on 2018/8/7.
//  Copyright © 2018年 Single_Nobel. All rights reserved.
//

#import "NetworkManager.h"
//#import "LoginViewController.h"

#define kRequestTimeOutTime 10

@implementation NetworkManager

+ (instancetype)sharedInstance
{
    static id sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (AFHTTPSessionManager *)baseHtppRequest
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    AFHTTPRequestSerializer *request_serializer = [AFHTTPRequestSerializer serializer];
    manager.requestSerializer = request_serializer;
    [manager.requestSerializer setTimeoutInterval:kRequestTimeOutTime];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", @"text/plain",nil];
    return manager;
}
- (AFHTTPSessionManager *)baseHtppRequest:(NSData *)data
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager.requestSerializer setTimeoutInterval:kRequestTimeOutTime];
    [manager.requestSerializer setValue:[NSString stringWithFormat:@"%ld",(long)[data length]] forHTTPHeaderField:@"Content-Length"];
    [manager.requestSerializer setValue:@"application/json; charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
    [manager.requestSerializer setValue:@"gzip" forHTTPHeaderField:@"Accept-Encoding"];
    
    return manager;
}

#pragma mark -post
-(void)postJsonData:(NSDictionary *)userInfo url:(NSString *)url successBlock:(SuccessBlock)successBlock failureBlock:(FailureBlock)failureBlock{
    AFHTTPSessionManager *manager = [self baseHtppRequest];
    NSMutableDictionary * resultDict = [BaseTool mlRewordNetAllParamater:userInfo];
    if ([[KeleDeviceInfoTool getDeviceNetWorkingStatus] isEqualToString:@"No Network"]) {
        [MBProgressHUD bnt_showMessage:@"请检查你的网络连接" delay:kMubDelayTime];
    }else{
        [manager POST:url parameters:resultDict progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            if ([responseObject[@"status"] isEqualToString:@"4002"]) {
                [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:kUserDefaultToken];
                successBlock(responseObject);
            }else{
                successBlock(responseObject);
            }
           
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"postJson error = %@",error);
            NSString *errorStr = [error.userInfo objectForKey:@"NSLocalizedDescription"];
            failureBlock(errorStr);
        }];
    }

}

//传图片
- (void)PostImgWithDic:(NSDictionary *)dic
               withImg:(NSDictionary *)imgDic
                   url:(NSString *)url
          successBlock:(SuccessBlock)successBlock
          failureBlock:(FailureBlock)failureBlock {
    AFHTTPSessionManager *postAvatarManager = [AFHTTPSessionManager manager];
    postAvatarManager.responseSerializer= [AFHTTPResponseSerializer serializer];
    NSMutableDictionary * resultDict = [BaseTool mlRewordNetAllParamater:dic];
    [postAvatarManager POST:url parameters:resultDict constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        if (imgDic.allKeys.count == 0) {
            NSLog(@"没有图片上传");
        }else
        {
            for (id key in imgDic) {
                          NSData *data  = [imgDic objectForKey:key];
                [formData appendPartWithFileData: data name:[NSString stringWithFormat:@"%@",key] fileName:[NSString stringWithFormat:@"%@_%@.jpg", [BaseTool getUserId],[BaseTool getTimeStr]] mimeType:@"image/jpg"];
            }
        }
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        nil;
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"上传图片成功了AFN ");
        successBlock(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSString *errorStr = [error.userInfo objectForKey:@"NSLocalizedDescription"];
        NSLog(@"上传图片失败了了AFN ");
        failureBlock(errorStr);
    }];
}

#pragma mark - trueGet

- (void)getJsonInfo:(NSDictionary *)userInfo url:(NSString *)url successBlock:(SuccessBlock)successBlock failureBlock:(FailureBlock)failureBlock
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", @"text/plain", @"image/jpeg",nil];
    manager.responseSerializer= [AFHTTPResponseSerializer serializer];
    NSMutableDictionary * resultDict = [BaseTool mlRewordNetAllParamater:userInfo];
    if ([[KeleDeviceInfoTool getDeviceNetWorkingStatus] isEqualToString:@"No Network"]) {
        [MBProgressHUD bnt_showMessage:@"请检查你的网络连接" delay:kMubDelayTime];
    }else{
        [manager GET:url parameters:resultDict progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            successBlock(responseObject);
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSString *errorStr = [error.userInfo objectForKey:@"NSLocalizedDescription"];
            failureBlock(errorStr);
        }];
    }
}

@end
