//
//  NetworkUtils.h
// RabbitConyYok
//
//  Created by Single_Nobel on 2018/8/7.
//  Copyright © 2018年 Single_Nobel. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^UtilsSuccessBlock)(id response);
typedef void(^UtilsFailueBlock)(NSString * error);
@interface NetworkUtils : NSObject

+ (instancetype)sharedInstance;

/** 判断手机号存在
 */

- (void)phoneExistWithNetwork:(NSString *)phone
                 utilsSuccess:(UtilsSuccessBlock)utilsSuccess
                    utilsFail:(UtilsFailueBlock)utilsFail;

/** 注册
 */

- (void)registerPhoneWithNetwork:(NSString *)phone
                        password:(NSString *)password
                      phone_code:(NSString *)phone_code
                    utilsSuccess:(UtilsSuccessBlock)utilsSuccess
                       utilsFail:(UtilsFailueBlock)utilsFail;


/** 修改密码
 */
- (void)findUserPasswordNetwork:(NSString *)phone
                       password:(NSString *)password
                     phone_code:(NSString *)phone_code
                   utilsSuccess:(UtilsSuccessBlock)utilsSuccess utilsFail:(UtilsFailueBlock)utilsFail;

/** 登录
 */

- (void)loginInWithNetwork:(NSString *)phone
                  passwrod:(NSString *)password
              utilsSuccess:(UtilsSuccessBlock)utilsSuccess
                 utilsFail:(UtilsFailueBlock)utilsFail;

/** 获取图形验证码
 */

- (void)rewordImgCodeWithNetwork:(NSString *)phone
                    utilsSuccess:(UtilsSuccessBlock)utilsSuccess
                       utilsFail:(UtilsFailueBlock)utilsFail;

/** 发送验证码 sms_type 001-注册   002-修改密码
 */

- (void)sendMessageWithNetwork:(NSString *)phone
                    graph_code:(NSString *)graph_code
                      sms_type:(NSString *)sms_type
                  utilsSuccess:(UtilsSuccessBlock)utilsSuccess
                     utilsFail:(UtilsFailueBlock)utilsFail;

/**  退出登录
 */

- (void)loginOutWithUtilsSuccess:(UtilsSuccessBlock)utilsSuccess
                       utilsFail:(UtilsFailueBlock)utilsFail;

/**  记录登录设备
 */

- (void)recordLoginInWithUtilsSuccess:(UtilsSuccessBlock)utilsSuccess
                            utilsFail:(UtilsFailueBlock)utilsFail;

/** 上传图片
 */

- (void)uploadImgWith:(id)data MaxLength:(NSInteger)maxlength
         utilsSuccess:(UtilsSuccessBlock)utilsSuccess
            utilsFail:(UtilsFailueBlock)utilsFail ;
/** 轮播.分类.提示广告
 */
-(void)rewordBannerAndNoticeutilSuccess:(UtilsSuccessBlock)utilsSuccess
                              utilsFail:(UtilsFailueBlock)utilsFail;






/** 人脸识别并上传图片
 */
- (void)uploadFaceImgWith:(id)data
         utilsSuccess:(UtilsSuccessBlock)utilsSuccess
            utilsFail:(UtilsFailueBlock)utilsFail;

/**启动页
 */
-(void)getSatrtImageutilsSuccess:(UtilsSuccessBlock)utilsSuccess
                       utilsFail:(UtilsFailueBlock)utilsFail;




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
                    utilsFail:(UtilsFailueBlock)utilsFail;

/** 获取实名
 */

- (void)rewordRealNameutilSuccess:(UtilsSuccessBlock)utilsSuccess
                        utilsFail:(UtilsFailueBlock)utilsFail;

/**  通讯录上传
 */

- (void)updataTheAllContact:(NSString *)userContact
               utilsSuccess:(UtilsSuccessBlock)utilsSuccess
                  utilsFail:(UtilsFailueBlock)utilsFail;

/**  提交个人信息
 */

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
                             utilsFail:(UtilsFailueBlock)utilsFail;

/**
 运营商校验
 
 @param phoneNum 手机号
 @param name 姓名
 @param ID 身份证号
 @param psw 密码
 @param utilsSuccess 成功回调
 @param utilsFail 失败回调
 */
- (void)carrierEnsureWithPhoneNum:(NSString *)phoneNum
                             name:(NSString *)name
                               ID:(NSString *)ID
                              psw:(NSString *)psw
                     utilsSuccess:(UtilsSuccessBlock)utilsSuccess
                        utilsFail:(UtilsFailueBlock)utilsFail ;

/** 获取个人实名信息
 */
-(void)getPersonalRealInfoWithUtilsSuccess:(UtilsSuccessBlock)utilsSuccess
                                 utilsFail:(UtilsFailueBlock)utilsFail;
/**  获取个人信息
 */
- (void)rewordPersonInfoWithUtilsSuccess:(UtilsSuccessBlock)utilsSuccess
                               utilsFail:(UtilsFailueBlock)utilsFail;

/**  保存个人信息
 */
-(void)saveUserInfo:(NSString *)content Type:(NSString *)type utilsSuccess:(UtilsSuccessBlock)utilsSuccess
          utilsFail:(UtilsFailueBlock)utilsFail;

/**  意见反馈
 */
- (void)feedBackWithNetWorkType:(NSString *)questionType
                   questionDesc:(NSString *)questionDesc
                    questionImg:(NSString *)questionImg
                   UtilsSuccess:(UtilsSuccessBlock)utilsSuccess
                      utilsFail:(UtilsFailueBlock)utilsFail;
/** 客户端升级
 */
- (void)checkVersionWithUtilsSuccess:(UtilsSuccessBlock)utilsSuccess
                           utilsFail:(UtilsFailueBlock)utilsFail ;

/** 当前订单进度
 */
- (void)getCurrentLoanOrderWithUtilsSuccess:(UtilsSuccessBlock)utilsSuccess
                           utilsFail:(UtilsFailueBlock)utilsFail ;
/** 当前进度文案
 */
- (void)getorderHomeWithUtilsSuccess:(UtilsSuccessBlock)utilsSuccess
                                  utilsFail:(UtilsFailueBlock)utilsFail ;


/**
 获取用户认证状态
 */
- (void)getUserStatusWithUtilsSuccess:(UtilsSuccessBlock)utilsSuccess
                            utilsFail:(UtilsFailueBlock)utilsFail ;
@end





















