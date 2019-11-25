//
//  BaseUrlMacros.h
// RabbitConyYok
//
//  Created by Single_Nobel on 2018/8/7.
//  Copyright © 2018年 Single_Nobel. All rights reserved.
//

#ifndef BaseUrlMacros_h
#define BaseUrlMacros_h
/** api接口
 */

//判断用户是否注册
#define kMobileExistUrl @"/user/user_judge_register"
//发送手机验证码
#define kGetVeriCodeUrl @"/user/mobile_code"
//获取图形验证码
#define kGetVerCode @"/user/user_graph_code"
//注册
#define kRegisterUrl @"/user/user_register"
//登录
#define kLoginInUrl @"/user/user_login"
//退出登录
#define kLoginOutUrl @"/user/user_loginout"
//修改密码
#define kChangePasswordUrl @"/user/user_update_pwd"
//记录设备登陆信息
#define kuserDeviceUrl @"/user/user_device"
//意见反馈
#define kFeedbackUrl @"/user/feedback"
//上传图片
#define kUploadUrl @"/file/upload"
//获取个人信息
#define kRewordPersonInfoUrl @"/user/person"
//当前订单进度
#define kcurrentOrderUrl @"/order/loan_current_order"
//首页获取额度文案
#define korderHomeUrl @"/order/loan_home"

//提交个人信息
#define kUserInfoSaveUrl @"/user/person_modify"
//获取启动页，轮播图，首页图片弹窗公告
#define kHomebannerUrl @"/app_index"

//人脸识别并上传图片，保存url到数据库
#define kface_saveUrl @"/user/face_save"
//提交实名信息
#define kRewordReanNameUrl @"/user/real_name_save"
//获取启动页,首页图片弹窗
#define kApp_homeUrl @"/app_home"
//获取个人实名信息
#define kGetPersonalRealInfo @"/user/user_info"

/** H5页面链接
 */


//用户认证中心
#define kcenterHtml @"/user/cert_center.html"
//用户银行卡
#define kBankCardHtml @"/user/bank_card"
//帮助中心
#define kHelpCenterHtml @"/help_center.html"
//订单记录
#define korderHistoryHtml @"/order/store_order_history"
//发现
#define kFinderHtml @"/find.html"
//首页估价
#define kphoneConditionHtml @"/order/phone_condition.html"
// 个人信息验证
#define kverifyUserInfoSaveUrl @"/user/user_info_save"
//获取实名信息
#define kRealNameUrl @"/user/real_name_info"

//提交人脸识别信息
#define kFaceCheckUrl @"/user/face_check"
//通讯录上传
#define kuploadAllContactUrl @"/user/address_list"
//客户端升级
#define kversionUrl @"/check_version"
//用户认证状态
#define kUserStatus @"/user_ident_info"
//申请额度
#define kApplyOrder @"/order/store_order_apply"
//订单详情
#define kOrderDetail @"/order/store_order_detail?orderId="
//app里的注册协议
#define kRegisterAgreement @"/agreement/register?alias="
//注册页的注册服务协议
#define kRegisterServiceAgreement @"/agreement/registar"
#define kMobileAuth @"/user/pullUserMobileAuth"
#define kBindBank @"/user/bank_card_bind"


#endif /* BaseUrlMacros_h */
