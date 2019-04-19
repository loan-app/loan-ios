//
//  NetworkTool.h
// RabbitConyYok
//
//  Created by Single_Nobel on 2018/8/7.
//  Copyright © 2018年 Single_Nobel. All rights reserved.
//
#import <Foundation/Foundation.h>
typedef void(^SuccessBlock)(id responseBody);
typedef void(^FailureBlock)(NSString *error);
@interface NetworkManager : NSObject

+ (instancetype)sharedInstance;

-(AFHTTPSessionManager *)baseHtppRequest;

-(AFHTTPSessionManager *)baseHtppRequest:(NSData *)data;

#pragma mark- get方法

- (void)getJsonInfo:(NSDictionary *)userInfo
                url:(NSString *)url
       successBlock:(SuccessBlock)successBlock
       failureBlock:(FailureBlock)failureBlock;

#pragma mark - post方法

-(void)postJsonData:(NSDictionary *)userInfo
                url:(NSString *)url
       successBlock:(SuccessBlock)successBlock
       failureBlock:(FailureBlock)failureBlock;

- (void)PostImgWithDic:(NSDictionary *)dic
               withImg:(NSDictionary *)imgDic
                   url:(NSString *)url
          successBlock:(SuccessBlock)successBlock
          failureBlock:(FailureBlock)failureBlock;

@end
