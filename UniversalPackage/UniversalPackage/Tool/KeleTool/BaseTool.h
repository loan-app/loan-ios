//
//  BaseTool.h
// RabbitConyYok
//
//  Created by Single_Nobel on 2018/8/7.
//  Copyright © 2018年 Single_Nobel. All rights reserved.
//


#import <Foundation/Foundation.h>

@interface BaseTool : NSObject

+ (instancetype)sharedBaseTool;

/**
 *  判断token是否存在
 */

+ (BOOL)isExistToken;

/**
 *  获取token
 */

+ (NSString *)getToken;

/**
 *  保存Token
 *
 */
+ (void)saveToken:(NSString *)token;

/**
 *  删除Token
 *
 */
+ (void)removeToken;


/**
 *  获取userId
 *
 */
+ (NSString *)getUserId;

/**
 *  保存userId
 *
 */

+ (void)saveUserId:(NSString *)userId;

/**
 *  删除userId
 *
 */
+ (void)removeUserId;

/**
 *  获取mobile
 *
 */
+ (NSString *)getUserMobile;

/**
 *  保存mobile
 *
 */

+ (void)saveUserMobile:(NSString *)mobile;

/**
 *  删除mobile
 *
 */
+ (void)removeUserMobile;

/**
 *  登出登录
 *
 */

+ (void)loginOutUser;

//获取时间戳
+(NSString *)getTimeStr;

//判断是否是ipad
+ (BOOL)getIsIpad;



#pragma mark - json字符串转字典

+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString;

#pragma mark - 字典转换数组或json串

+ (NSString *)convertToJsonData:(NSDictionary *)dict;

#pragma mark - 数组转json

+ (NSString *)objArrayToJSON:(NSArray *)array;

#pragma mark - 字符串转字典

+ (NSDictionary *)parseJSONStringToNSDictionary:(NSString *)JSONString;

#pragma mark - 服务端网络请求共有参数

+ (NSMutableDictionary *)mlRewordNetAllParamater:(NSDictionary *)userInfo;


/**
 *  富文本修改文字颜色(label)
 */
+ (void)changeColor:(UIColor *)color subColor:(UIColor *)subColor withLabel:(UILabel *)label onString:(NSString *)string subString:(NSString *)subString;

/**
 *  富文本修改文字颜色(textField)
 *
 */
+ (void)changeColor:(UIColor *)color subColor:(UIColor *)subColor withTextField:(UITextField *)textField onString:(NSString *)string subString:(NSString *)subString;


/**
 *  去除手机空格
 */

+ (NSString *)dealWithPhoneNumber:(NSString *)phone;


/**
 *  验证手机号码
 */
+ (BOOL)isMobileNumber:(NSString *)mobileNum;

/**
 *  验证网络请求的结果
 */

+ (BOOL)responseWithNetworkDealResponse:(id)response;

/**
 *  处理验证码倒计时
 */
+ (void)countDownTimer:(UIButton *)resultBtn;

/** 字符串md5加密
 */
+ (NSString *)md5:(NSString *)str;

/** 处理手机号加星
 */
+ (NSString *)getMobilePhoneStar:(NSString *)phone;

/** 记录设备信息
 */

+ (void)rewordLoginMessage;

/** 验证头像
 */
+ (BOOL)Imageisexit:(NSString *)urlstr;

/**判断数组是否为空
 */
+ (BOOL)isBlankArr:(NSArray *)arr;
+ (BOOL)isBlankMuArr:(NSMutableArray *)arr;

#pragma mark - 延迟执行

+ (void)delayPerform:(NSTimeInterval)timeInterval complete:(void (^)(void))complete;
/** 画一条直线
 */
+(void)drawLine:(CGPoint )startp End:(CGPoint)endp Toview:(UIView *)view;

@end
