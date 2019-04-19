//
//  KeleDeviceInfoTool.h
// RabbitConyYok
//
//  Created by Single_Nobel on 2018/8/7.
//  Copyright © 2018年 Single_Nobel. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KeleDeviceInfoTool : NSObject

/*获取网络类型
 */
+ (NSString *)getDeviceNetWorkingStatus;

//获取设备型号
+ (NSString *)getDeviceModel;

/**
 *  获取UDID
 */
+ (NSString *)getUDID;

/**
 *  获取手机分辨率
 */
+ (NSString *)getScrePhone;

/**
 *  运营商
 */
+ (NSString *)getcarrierName;

/**
 *  手机内存
 */
+ (NSString *)getPhoneDiskSapce;

/** 获取操作系统版本 获取操作系统版本 11.1
 */
+ (NSString *)getOperatingSystemVersion;

/** 获取iPhone8,1
 */

+ (NSString *)getiPhoneDevice;



@end
