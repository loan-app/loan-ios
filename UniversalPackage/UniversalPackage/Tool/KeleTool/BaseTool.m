//
//  BaseTool.m
// RabbitConyYok
//
//  Created by Single_Nobel on 2018/8/7.
//  Copyright © 2018年 Single_Nobel. All rights reserved.
//
#import "BaseTool.h"
#import <CommonCrypto/CommonDigest.h>
static BaseTool * mlManager = nil;

@implementation BaseTool


+ (instancetype)sharedBaseTool {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        mlManager = [[BaseTool alloc] init];
    });
    return mlManager;
}


/**
 *  token网络公共参数
 */

+ (NSString *)isToken {
    if (isValidStr([BaseTool getToken])) {
        return [BaseTool getToken];
    }else {
        return @"";
    }
}

/**
 *  判断token是否存在
 */

+ (BOOL)isExistToken {
    if (isValidStr([BaseTool getToken])) {
        return YES;
    }else {
        return NO;
    }
}


+ (NSString *)getToken
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:kUserDefaultToken];
}

+ (void)saveToken:(NSString *)token
{
    [[NSUserDefaults standardUserDefaults] setObject:token forKey:kUserDefaultToken];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (void)removeToken {
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:kUserDefaultToken];
    [[NSUserDefaults standardUserDefaults] synchronize];
}



/**
 *  获取userId
 *
 */
+ (NSString *)getUserId
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:kUserDefaultUserId];
}

+ (void)saveUserId:(NSString *)userId
{
    [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%@", userId] forKey:kUserDefaultUserId];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (void)removeUserId {
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:kUserDefaultUserId];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

/**
 *  获取mobile
 *
 */
+ (NSString *)getUserMobile{
    return [[NSUserDefaults standardUserDefaults] objectForKey:kUserDefaultTelNumber];
}

+ (void)removeUserMobile {
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:kUserDefaultTelNumber];
    [[NSUserDefaults standardUserDefaults] synchronize];
}


/**
 *  保存mobile
 *
 */

+ (void)saveUserMobile:(NSString *)mobile
{
    [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%@", mobile] forKey:kUserDefaultTelNumber];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

/**
 *  登出登录
 *
 */

+ (void)loginOutUser {
    [BaseTool cleanUserdefaults];
}
+(void)cleanUserdefaults{
    NSString *appDomainStr = [[NSBundle mainBundle] bundleIdentifier];
    [kuserdefaults removePersistentDomainForName:appDomainStr];
    [kuserdefaults synchronize];
}



//获取时间戳
+(NSString *)getTimeStr
{
    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval a=[dat timeIntervalSince1970]*1000;
    NSString *timeString = [NSString stringWithFormat:@"%.0f", a];
    return timeString;
}
//判断是否是ipad
+ (BOOL)getIsIpad
{
    NSString *deviceType = [UIDevice currentDevice].model;
    if([deviceType isEqualToString:@"iPhone"]) {
        //iPhone
        return NO;
    }
    else if([deviceType isEqualToString:@"iPod touch"]) {
        //iPod Touch
        return NO;
    }
    else if([deviceType isEqualToString:@"iPad"]) {
        //iPad
        return YES;
    }
    return NO;
}

#pragma mark - json字符串转字典

+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString {
    if (jsonString == nil) {
        return nil;
    }
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err) {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}


#pragma mark - 字典转换数组或json串

+ (NSString *)convertToJsonData:(NSDictionary *)dict {
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:&error];
    NSString *jsonString;
    if (!jsonData) {
        NSLog(@"%@",error);
    }else{
        jsonString = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    NSMutableString *mutStr = [NSMutableString stringWithString:jsonString];
    NSRange range = {0,jsonString.length};
    //去掉字符串中的空格
    [mutStr replaceOccurrencesOfString:@" " withString:@"" options:NSLiteralSearch range:range];
    NSRange range2 = {0,mutStr.length};
    //去掉字符串中的换行符
    [mutStr replaceOccurrencesOfString:@"\n" withString:@"" options:NSLiteralSearch range:range2];
    return mutStr;
}

#pragma mark - 数组转json串

+ (NSString *)objArrayToJSON:(NSArray *)array {
    NSString *jsonStr = @"[";
    for (NSInteger i = 0; i < array.count; ++i) {
        if (i != 0) {
            jsonStr = [jsonStr stringByAppendingString:@","];
        }
        jsonStr = [jsonStr stringByAppendingString:array[i]];
    }
    jsonStr = [jsonStr stringByAppendingString:@"]"];
    return jsonStr;
}

#pragma mark - 字符串转字典

+ (NSDictionary *)parseJSONStringToNSDictionary:(NSString *)JSONString {
    NSData *JSONData = [JSONString dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *responseJSON = [NSJSONSerialization JSONObjectWithData:JSONData options:NSJSONReadingMutableLeaves error:nil];
    return responseJSON;
}


#pragma mark - 服务端网络请求共有参数

+ (NSMutableDictionary *)mlRewordNetAllParamater:(NSDictionary *)userInfo {
    NSMutableDictionary * resultDic = [NSMutableDictionary dictionaryWithDictionary:userInfo];
    [resultDic setObjectNotNil:@"ios" forKey:@"type"];
    [resultDic setObjectNotNil:kAliasName forKey:@"alias"];
    [resultDic setObjectNotNil:[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"] forKey:@"version"];
    [resultDic setObjectNotNil:[BaseTool isToken] forKey:@"token"];
    return resultDic;
}

+ (void)changeColor:(UIColor *)color subColor:(UIColor *)subColor withLabel:(UILabel *)label onString:(NSString *)string subString:(NSString *)subString
{
    label.textColor = color;
    
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:string];
    NSRange redRangeTwo = NSMakeRange([[str string] rangeOfString:subString].location, [ [str string] rangeOfString:subString].length);
    //设置：在0-3个单位长度内的内容显示成红色
    [str addAttribute:NSForegroundColorAttributeName value:subColor range:redRangeTwo];
    
    [label setAttributedText:str];
}

+ (void)changeColor:(UIColor *)color subColor:(UIColor *)subColor withTextField:(UITextField *)textField onString:(NSString *)string subString:(NSString *)subString
{
    textField.textColor = color;
    
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:string];
    NSRange redRangeTwo = NSMakeRange([[str string] rangeOfString:subString].location, [ [str string] rangeOfString:subString].length);
    //设置：在0-3个单位长度内的内容显示成红色
    [str addAttribute:NSForegroundColorAttributeName value:subColor range:redRangeTwo];
    
    [textField setAttributedText:str];
}

#pragma mark - 去输入框空格

+ (NSString *)dealWithPhoneNumber:(NSString *)phone {
    return [phone stringByReplacingOccurrencesOfString:@" " withString:@""];
}

/**
 *  验证手机号码
 
 */

+ (BOOL)isMobileNumber:(NSString *)mobileNum
{
    if (mobileNum.length != 11)
    {
        return NO;
    }
    NSString *MOBILE = @"^1(3[0-9]|4[0-9]|5[0-9]|6[0-9]|7[0-9]|8[0-9]|9[0-9])\\d{8}$";
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    
    if ([regextestmobile evaluateWithObject:mobileNum] == YES)
    {
        return YES;
    }
    else
    {
        return NO;
    }
}


/**
 *  验证网络请求的结果
 */

+ (BOOL)responseWithNetworkDealResponse:(id)response {
    if ([response[kStatusCode] isEqualToString:@"2000"]) {
        return YES;
    }else {
        return NO;
    }
}

/**
 *  处理验证码倒计时
 */

+ (void)countDownTimer:(UIButton *)resultBtn {
    
    __block int timeout=59;
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0);
    dispatch_source_set_event_handler(_timer, ^{
        if(timeout<=0){ //倒计时结束，关闭
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                [resultBtn setTitle:@"重新获取" forState:UIControlStateNormal];
                resultBtn.userInteractionEnabled = YES;
                [resultBtn setBackgroundColor:k333Color];
                [resultBtn setTitleColor:kWhiteColor forState:UIControlStateNormal];
            });
        }else{
            int seconds = timeout % 60;
            NSString *strTime = [NSString stringWithFormat:@"%.2d", seconds];
            dispatch_async(dispatch_get_main_queue(), ^{
                [UIView beginAnimations:nil context:nil];
                [UIView setAnimationDuration:0];
                [resultBtn setTitle:[NSString stringWithFormat:@"%@s后重试",strTime] forState:UIControlStateNormal];
                [resultBtn setBackgroundColor:kf2f2Color];
                [resultBtn setTitleColor:knineNineColor forState:UIControlStateNormal];
                [UIView commitAnimations];
                resultBtn.userInteractionEnabled = NO;
            });
            timeout--;
        }
    });
    dispatch_resume(_timer);
}


/** 字符串md5加密
 */
+ (NSString *)md5:(NSString *)str {
    const char* input = [str UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(input, (CC_LONG)strlen(input), result);
    
    NSMutableString *digest = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for (NSInteger i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
        [digest appendFormat:@"%02x", result[i]];
    }
    return digest;
}

/** 处理手机号加星
 */
+ (NSString *)getMobilePhoneStar:(NSString *)phone {
    return [BaseTool replaceStringWithAsterisk:3 length:4 phone:phone];
}

+ (NSString *)replaceStringWithAsterisk:(NSInteger)startLocation length:(NSInteger)length phone:(NSString *)phoneStr {
    for (NSInteger i = 0; i < length; i++) {
        NSRange range = NSMakeRange(startLocation, 1);
        phoneStr = [phoneStr stringByReplacingCharactersInRange:range withString:@"*"];
        startLocation ++;
    }
    return phoneStr;
}


+ (void)rewordLoginMessage {
    [[NetworkUtils sharedInstance] recordLoginInWithUtilsSuccess:^(id response) {
        
    } utilsFail:^(NSString *error) {
        
    }];
}


/** 验证头像是否存在
 */
+ (BOOL)Imageisexit:(NSString *)urlstr{
    BOOL esit = [urlstr isEqualToString:@"https://static-ym.oss-cn-hangzhou.aliyuncs.com/null"] ? NO : YES;
    return esit;
}

/**判断数组是否为空
 */
+ (BOOL)isBlankArr:(NSArray *)arr{
    if (!arr) {
        return YES;
    }
    if ([arr isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if (!arr.count) {
        return YES;
    }
    if (arr == nil) {
        return YES;
    }
    if (arr == NULL) {
        return YES;
    }
    if (![arr isKindOfClass:[NSArray class]]) {
        return YES;
    }
    return NO;
}
+ (BOOL)isBlankMuArr:(NSMutableArray *)arr{
    if (!arr) {
        return YES;
    }
    if ([arr isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if (!arr.count) {
        return YES;
    }
    if (arr == nil) {
        return YES;
    }
    if (arr == NULL) {
        return YES;
    }
    if (![arr isKindOfClass:[NSMutableArray class]]) {
        return YES;
    }
    return NO;
}


#pragma mark - 延迟执行

+ (void)delayPerform:(NSTimeInterval)timeInterval complete:(void (^)(void))complete {
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        sleep(timeInterval);
        if (complete) {
            dispatch_async(dispatch_get_main_queue(), ^{
                complete();
            });
        }
    });
}


#pragma mark - 存储数据

+ (void)storageData:(id)data forKey:(id)key onPath:(NSString *)path
{
    NSMutableDictionary *dic = [BaseTool readData:path].mutableCopy;
    
    if (dic ==  nil) {
        dic = [NSMutableDictionary dictionary];
    }
    [dic setValue:data forKey:key];
    [dic writeToFile:path atomically:YES];
}

#pragma mark - 读取已有数据
+ (NSMutableDictionary *)readData:(NSString *)path
{
    NSMutableDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:path].mutableCopy;
    return dic;
}

+(void)drawLine:(CGPoint )startp End:(CGPoint)endp Toview:(UIView *)view{
    UIBezierPath * path = [UIBezierPath bezierPath];
    [path moveToPoint:startp];//开始点
    [path addLineToPoint:endp];
    path.lineWidth = 2.0;
    path.lineCapStyle = kCGLineCapRound; //线条拐角
    path.lineJoinStyle = kCGLineCapRound; //终点处理
    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.path = path.CGPath;
    layer.fillColor =[UIColor clearColor].CGColor;
    layer.strokeColor = kRGB(240, 240, 240).CGColor;
    [view.layer addSublayer:layer];
}





@end
