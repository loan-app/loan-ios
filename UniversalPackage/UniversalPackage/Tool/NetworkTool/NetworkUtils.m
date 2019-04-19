  //
//  NetworkUtils.m
// RabbitConyYok
//
//  Created by Single_Nobel on 2018/8/7.
//  Copyright © 2018年 Single_Nobel. All rights reserved.
//

#import "NetworkUtils.h"
#import "NetworkManager.h"
static NetworkUtils * netTool = nil;

@implementation NetworkUtils

+ (instancetype)sharedInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        netTool = [[self alloc] init];
    });
    return netTool;
}

/** 判断手机号存在
 */

- (void)phoneExistWithNetwork:(NSString *)phone
                 utilsSuccess:(UtilsSuccessBlock)utilsSuccess
                    utilsFail:(UtilsFailueBlock)utilsFail {
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    [dic setObjectNotNil:phone forKey:@"phone"];
    NSString * url = [NSString stringWithFormat:@"%@%@", kHTTPUrl, kMobileExistUrl];
    [[NetworkManager sharedInstance] postJsonData:dic url:url successBlock:^(id responseBody) {
        utilsSuccess(responseBody);
    } failureBlock:^(NSString *error) {
        utilsFail(error);
    }];
}

/** 注册
 */

- (void)registerPhoneWithNetwork:(NSString *)phone
                        password:(NSString *)password
                      phone_code:(NSString *)phone_code
                    utilsSuccess:(UtilsSuccessBlock)utilsSuccess
                       utilsFail:(UtilsFailueBlock)utilsFail {
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    [dic setObjectNotNil:phone forKey:@"phone"];
    [dic setObjectNotNil:[BaseTool md5:password] forKey:@"password"];
    [dic setObjectNotNil:phone_code forKey:@"phone_code"];
    NSString * url = [NSString stringWithFormat:@"%@%@", kHTTPUrl, kRegisterUrl];
    [[NetworkManager sharedInstance] postJsonData:dic url:url successBlock:^(id responseBody) {
        utilsSuccess(responseBody);
    } failureBlock:^(NSString *error) {
         utilsFail(error);
    }];
}

/** 登录
 */

- (void)loginInWithNetwork:(NSString *)phone
                  passwrod:(NSString *)password
              utilsSuccess:(UtilsSuccessBlock)utilsSuccess
                 utilsFail:(UtilsFailueBlock)utilsFail {
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    [dic setObjectNotNil:phone forKey:@"phone"];
    [dic setObjectNotNil:[BaseTool md5:password] forKey:@"password"];
    NSString * url = [NSString stringWithFormat:@"%@%@", kHTTPUrl, kLoginInUrl];
    [[NetworkManager sharedInstance] postJsonData:dic url:url successBlock:^(id responseBody) {
        utilsSuccess(responseBody);
    } failureBlock:^(NSString *error) {
        utilsFail(error);
    }];
}

/** 修改密码
 */
- (void)findUserPasswordNetwork:(NSString *)phone
                       password:(NSString *)password
                     phone_code:(NSString *)phone_code
                   utilsSuccess:(UtilsSuccessBlock)utilsSuccess utilsFail:(UtilsFailueBlock)utilsFail {
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    [dic setObjectNotNil:phone forKey:@"phone"];
    [dic setObjectNotNil:[BaseTool md5:password] forKey:@"password"];
    [dic setObjectNotNil:phone_code forKey:@"phone_code"];
    NSString * url = [NSString stringWithFormat:@"%@%@", kHTTPUrl, kChangePasswordUrl];
    [[NetworkManager sharedInstance] postJsonData:dic url:url successBlock:^(id responseBody) {
        utilsSuccess(responseBody);
    } failureBlock:^(NSString *error) {
        utilsFail(error);
    }];
}


/** 获取图形验证码
 */

- (void)rewordImgCodeWithNetwork:(NSString *)phone
                    utilsSuccess:(UtilsSuccessBlock)utilsSuccess
                       utilsFail:(UtilsFailueBlock)utilsFail {
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    [dic setObjectNotNil:phone forKey:@"phone"];
    NSString * url = [NSString stringWithFormat:@"%@%@", kHTTPUrl, kGetVerCode];
    [[NetworkManager sharedInstance] getJsonInfo:dic url:url successBlock:^(id responseBody) {
         utilsSuccess(responseBody);
    } failureBlock:^(NSString *error) {
         utilsFail(error);
    }];
}

/** 发送验证码 sms_type 1001-注册   1002-修改密码
 */

- (void)sendMessageWithNetwork:(NSString *)phone
                    graph_code:(NSString *)graph_code
                      sms_type:(NSString *)sms_type
                  utilsSuccess:(UtilsSuccessBlock)utilsSuccess
                     utilsFail:(UtilsFailueBlock)utilsFail {
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    [dic setObjectNotNil:phone forKey:@"phone"];
    [dic setObjectNotNil:graph_code forKey:@"graph_code"];
    [dic setObjectNotNil:sms_type forKey:@"sms_type"];
    NSString * url = [NSString stringWithFormat:@"%@%@", kHTTPUrl, kGetVeriCodeUrl];
    [[NetworkManager sharedInstance] postJsonData:dic url:url successBlock:^(id responseBody) {
        utilsSuccess(responseBody);
    } failureBlock:^(NSString *error) {
        utilsFail(error);
    }];
}

/**  退出登录
 */

- (void)loginOutWithUtilsSuccess:(UtilsSuccessBlock)utilsSuccess
                       utilsFail:(UtilsFailueBlock)utilsFail {
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    [dic setObjectNotNil:kAliasName forKey:@"alias"];
    NSString * url = [NSString stringWithFormat:@"%@%@", kHTTPUrl, kLoginOutUrl];
    [[NetworkManager sharedInstance] postJsonData:dic url:url successBlock:^(id responseBody) {
        utilsSuccess(responseBody);
    } failureBlock:^(NSString *error) {
        utilsFail(error);
    }];
}


/**  记录登录设备
 */

- (void)recordLoginInWithUtilsSuccess:(UtilsSuccessBlock)utilsSuccess
                            utilsFail:(UtilsFailueBlock)utilsFail {
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    [dic setObjectNotNil:[BaseTool getToken] forKey:@"token"];
    [dic setObjectNotNil:[KeleDeviceInfoTool getUDID] forKey:@"deviceid"];
    [dic setObjectNotNil:@"" forKey:@"location"];
    [dic setObjectNotNil:@"" forKey:@"city"];
    [dic setObjectNotNil:[KeleDeviceInfoTool getDeviceNetWorkingStatus] forKey:@"netType"];
    
    [dic setObjectNotNil:[KeleDeviceInfoTool getDeviceModel] forKey:@"phoneBrand"];
    [dic setObjectNotNil:[KeleDeviceInfoTool getiPhoneDevice] forKey:@"phoneModel"];
    [dic setObjectNotNil:[KeleDeviceInfoTool getScrePhone] forKey:@"phoneResolution"];
    [dic setObjectNotNil:[KeleDeviceInfoTool getPhoneDiskSapce] forKey:@"phoneMemory"];    
    [dic setObjectNotNil:[KeleDeviceInfoTool getcarrierName] forKey:@"isp"];
    [dic setObjectNotNil:[KeleDeviceInfoTool getOperatingSystemVersion] forKey:@"phoneSystem"];
    NSString * url = [NSString stringWithFormat:@"%@%@", kHTTPUrl, kuserDeviceUrl];
    [[NetworkManager sharedInstance] postJsonData:dic url:url successBlock:^(id responseBody) {
        utilsSuccess(responseBody);
    } failureBlock:^(NSString *error) {
        utilsFail(error);
    }];
}

/** 上传图片
 */

- (void)uploadImgWith:(id)data MaxLength:(NSInteger)maxlength
         utilsSuccess:(UtilsSuccessBlock)utilsSuccess
            utilsFail:(UtilsFailueBlock)utilsFail {
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];

    data = [UIImage compressWithImage:data MaxLength:maxlength];

    [dic setObjectNotNil:data forKey:@"file"];
    NSString * url = [NSString stringWithFormat:@"%@%@", kHTTPUrl, kUploadUrl];
    [[NetworkManager sharedInstance] PostImgWithDic:nil withImg:dic url:url successBlock:^(id responseBody) {
        NSDictionary *dataDic = [NSJSONSerialization JSONObjectWithData:responseBody options:NSJSONReadingMutableContainers error:nil];
        utilsSuccess(dataDic);
    } failureBlock:^(NSString *error) {
        utilsFail(error);
    }];
}


/** 轮播.分类.提示广告
 */
-(void)rewordBannerAndNoticeutilSuccess:(UtilsSuccessBlock)utilsSuccess
                              utilsFail:(UtilsFailueBlock)utilsFail{
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    NSString * url = [NSString stringWithFormat:@"%@%@", kHTTPUrl, kHomebannerUrl];
    [[NetworkManager sharedInstance] postJsonData:dic url:url successBlock:^(id responseBody) {
        utilsSuccess(responseBody);
    } failureBlock:^(NSString *error) {
        utilsFail(error);
    }];

}




/** 人脸识别并上传图片
 */
- (void)uploadFaceImgWith:(id)data
             utilsSuccess:(UtilsSuccessBlock)utilsSuccess
                utilsFail:(UtilsFailueBlock)utilsFail{
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    
        data = [UIImage compressWithImage:data MaxLength:50];
    [dic setObjectNotNil:data forKey:@"file"];
    NSString * url = [NSString stringWithFormat:@"%@%@", kHTTPUrl, kface_saveUrl];
    [[NetworkManager sharedInstance] PostImgWithDic:nil withImg:dic url:url successBlock:^(id responseBody) {
        NSDictionary *dataDic = [NSJSONSerialization JSONObjectWithData:responseBody options:NSJSONReadingMutableContainers error:nil];
        utilsSuccess(dataDic);
    } failureBlock:^(NSString *error) {
        utilsFail(error);
    }];
    
}
/**
 */
-(void)getSatrtImageutilsSuccess:(UtilsSuccessBlock)utilsSuccess utilsFail:(UtilsFailueBlock)utilsFail{
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    NSString * url = [NSString stringWithFormat:@"%@%@", kHTTPUrl, kApp_homeUrl];
    [[NetworkManager sharedInstance] postJsonData:dic url:url successBlock:^(id responseBody) {
        utilsSuccess(responseBody);
    } failureBlock:^(NSString *error) {
        utilsFail(error);
    }];
}


/** 提交实名
 */

- (void)uplodRealUserNameWith:(NSString *)userName
                   userCertNo:(NSString *)userCertNo
                           ia:(NSString *)ia
                       indate:(NSString *)indate
                      address:(NSString *)address
                       nation:(NSString *)nation
                 imgCertFront:(NSString *)imgCertFront
                  imgCertBack:(NSString *)imgCertBack
                 utilsSuccess:(UtilsSuccessBlock)utilsSuccess
                    utilsFail:(UtilsFailueBlock)utilsFail {
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    [dic setObjectNotNil:userName forKey:@"userName"];
    [dic setObjectNotNil:userCertNo forKey:@"userCertNo"];
    [dic setObjectNotNil:ia forKey:@"ia"];
    [dic setObjectNotNil:indate forKey:@"indate"];
    [dic setObjectNotNil:address forKey:@"address"];
    [dic setObjectNotNil:nation forKey:@"nation"];
    [dic setObjectNotNil:imgCertFront forKey:@"imgCertFront"];
    [dic setObjectNotNil:imgCertBack forKey:@"imgCertBack"];
    NSString * url = [NSString stringWithFormat:@"%@%@", kHTTPUrl, kRewordReanNameUrl];
    [[NetworkManager sharedInstance] postJsonData:dic url:url successBlock:^(id responseBody) {
        utilsSuccess(responseBody);
    } failureBlock:^(NSString *error) {
        utilsFail(error);
    }];
}

/** 获取实名
 */

- (void)rewordRealNameutilSuccess:(UtilsSuccessBlock)utilsSuccess
                        utilsFail:(UtilsFailueBlock)utilsFail {
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    [dic setObjectNotNil:@"ios" forKey:@"type"];
    NSString * url = [NSString stringWithFormat:@"%@%@", kHTTPUrl, kRealNameUrl];
    [[NetworkManager sharedInstance] postJsonData:dic url:url successBlock:^(id responseBody) {
        utilsSuccess(responseBody);
    } failureBlock:^(NSString *error) {
        utilsFail(error);
    }];
}

/**  通讯录上传
 */

- (void)updataTheAllContact:(NSString *)userContact
               utilsSuccess:(UtilsSuccessBlock)utilsSuccess
                  utilsFail:(UtilsFailueBlock)utilsFail {
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    [dic setObjectNotNil:userContact forKey:@"addressList"];
    NSString * url = [NSString stringWithFormat:@"%@%@", kHTTPUrl, kuploadAllContactUrl];
    [[NetworkManager sharedInstance] postJsonData:dic url:url successBlock:^(id responseBody) {
        utilsSuccess(responseBody);
    } failureBlock:^(NSString *error) {
        utilsFail(error);
    }];
}


- (void)thePersonWithUrgencyEducation:(NSString *)education
                          liveProvince:(NSString *)liveProvince
                              liveCity:(NSString *)liveCity
                          liveDistrict:(NSString *)liveDistrict
                           liveAddress:(NSString *)liveAddress
                           marryStatus:(NSString *)marryStatus
                              liveTime:(NSString *)liveTime
                                   job:(NSString *)job
                           workAddress:(NSString *)workAddress
                               company:(NSString *)company
                                 zhixi:(NSString *)zhixi
                             zhixiName:(NSString *)zhixiName
                              zhixiTel:(NSNumber *)zhixiTel
                                others:(NSString *)others
                            othersName:(NSString *)othersName
                             othersTel:(NSNumber *)othersTel
                          utilsSuccess:(UtilsSuccessBlock)utilsSuccess
                             utilsFail:(UtilsFailueBlock)utilsFail {
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    [dic setObjectNotNil:education forKey:@"education"];
    [dic setObjectNotNil:liveProvince forKey:@"liveProvince"];
    [dic setObjectNotNil:liveCity forKey:@"liveCity"];
    if (isValidStr(liveDistrict)) {
        [dic setObjectNotNil:liveDistrict forKey:@"liveDistrict"];
    }else {
        [dic setObject:@"" forKey:@"liveDistrict"];
    }
    [dic setObjectNotNil:liveAddress forKey:@"liveAddress"];//具体地址
    [dic setObjectNotNil:liveTime forKey:@"liveTime"];
    [dic setObjectNotNil:marryStatus forKey:@"liveMarry"];
    [dic setObjectNotNil:job forKey:@"workType"];//职业
    [dic setObjectNotNil:company forKey:@"workCompany"];//公司
    [dic setObjectNotNil:workAddress forKey:@"workAddress"];//工作地址
    [dic setObjectNotNil:zhixi forKey:@"directContact"];
    [dic setObjectNotNil:zhixiName forKey:@"directContactName"];
    [dic setObjectNotNil:zhixiTel forKey:@"directContactPhone"];
    [dic setObjectNotNil:others forKey:@"othersContact"];
    [dic setObjectNotNil:othersName forKey:@"othersContactName"];
    [dic setObjectNotNil:othersTel forKey:@"othersContactPhone"];
    NSString * url = [NSString stringWithFormat:@"%@%@", kHTTPUrl, kverifyUserInfoSaveUrl];
    [[NetworkManager sharedInstance] postJsonData:dic url:url successBlock:^(id responseBody) {
        utilsSuccess(responseBody);
    } failureBlock:^(NSString *error) {
        utilsFail(error);
    }];
}

/** 获取个人实名信息
 */
-(void)getPersonalRealInfoWithUtilsSuccess:(UtilsSuccessBlock)utilsSuccess
                                 utilsFail:(UtilsFailueBlock)utilsFail{
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    [dic setObjectNotNil:@"ios" forKey:@"type"];
    NSString * url = [NSString stringWithFormat:@"%@%@", kHTTPUrl, kGetPersonalRealInfo];
    [[NetworkManager sharedInstance] postJsonData:dic url:url successBlock:^(id responseBody) {
        utilsSuccess(responseBody);
    } failureBlock:^(NSString *error) {
        utilsFail(error);
    }];
}

/**  获取个人信息
 */
- (void)rewordPersonInfoWithUtilsSuccess:(UtilsSuccessBlock)utilsSuccess
                               utilsFail:(UtilsFailueBlock)utilsFail {
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    [dic setObjectNotNil:@"ios" forKey:@"type"];
    NSString * url = [NSString stringWithFormat:@"%@%@", kHTTPUrl, kRewordPersonInfoUrl];
    [[NetworkManager sharedInstance] postJsonData:dic url:url successBlock:^(id responseBody) {
        utilsSuccess(responseBody);
    } failureBlock:^(NSString *error) {
        utilsFail(error);
    }];
}

/**保存个人信息
 */
-(void)saveUserInfo:(NSString *)content Type:(NSString *)type utilsSuccess:(UtilsSuccessBlock)utilsSuccess utilsFail:(UtilsFailueBlock)utilsFail{
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    if (isValidStr(type)) {
        [dic setObjectNotNil:content forKey:type];
    }
    NSString * url = [NSString stringWithFormat:@"%@%@", kHTTPUrl,kUserInfoSaveUrl ];
    [[NetworkManager sharedInstance] postJsonData:dic url:url successBlock:^(id responseBody) {
        utilsSuccess(responseBody);
    } failureBlock:^(NSString *error) {
        utilsFail(error);
    }];
}
/**  意见反馈
 */

- (void)feedBackWithNetWorkType:(NSString *)questionType
                   questionDesc:(NSString *)questionDesc
                    questionImg:(NSString *)questionImg
                   UtilsSuccess:(UtilsSuccessBlock)utilsSuccess
                      utilsFail:(UtilsFailueBlock)utilsFail {
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    [dic setObjectNotNil:questionType forKey:@"questionType"];
    [dic setObjectNotNil:questionDesc forKey:@"questionDesc"];
    [dic setObjectNotNil:questionImg forKey:@"questionImg"];
    NSString * url = [NSString stringWithFormat:@"%@%@", kHTTPUrl, kFeedbackUrl];
    [[NetworkManager sharedInstance] postJsonData:dic url:url successBlock:^(id responseBody) {
        utilsSuccess(responseBody);
    } failureBlock:^(NSString *error) {
        utilsFail(error);
    }];
}
/** 客户端升级
 */
- (void)checkVersionWithUtilsSuccess:(UtilsSuccessBlock)utilsSuccess
                               utilsFail:(UtilsFailueBlock)utilsFail {
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    NSString * url = [NSString stringWithFormat:@"%@%@", kHTTPUrl, kversionUrl];
    [[NetworkManager sharedInstance] postJsonData:dic url:url successBlock:^(id responseBody) {
        utilsSuccess(responseBody);
    } failureBlock:^(NSString *error) {
        utilsFail(error);
    }];
}
/** 当前订单进度
 */
- (void)getCurrentLoanOrderWithUtilsSuccess:(UtilsSuccessBlock)utilsSuccess
                                  utilsFail:(UtilsFailueBlock)utilsFail {
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    NSString * url = [NSString stringWithFormat:@"%@%@", kHTTPUrl, kcurrentOrderUrl];
    [[NetworkManager sharedInstance] postJsonData:dic url:url successBlock:^(id responseBody) {
        utilsSuccess(responseBody);
    } failureBlock:^(NSString *error) {
            utilsFail(error);
    }];
}

/** 当前进度文案
 */
- (void)getorderHomeWithUtilsSuccess:(UtilsSuccessBlock)utilsSuccess
                           utilsFail:(UtilsFailueBlock)utilsFail{
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    NSString * url = [NSString stringWithFormat:@"%@%@", kHTTPUrl, korderHomeUrl];
    [[NetworkManager sharedInstance] postJsonData:dic url:url successBlock:^(id responseBody) {
        utilsSuccess(responseBody);
    } failureBlock:^(NSString *error) {
        utilsFail(error);
    }];
}

@end

















