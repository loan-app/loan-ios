//
//  KeleDeviceInfoTool.m
// RabbitConyYok
//
//  Created by Single_Nobel on 2018/8/7.
//  Copyright © 2018年 Single_Nobel. All rights reserved.
//

#import "KeleDeviceInfoTool.h"
#import "sys/utsname.h"
#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#import <CoreTelephony/CTCarrier.h>
@implementation KeleDeviceInfoTool


//获取网络类型
+ (NSString *)getDeviceNetWorkingStatus {
    NSString *strNetworkInfo = @"No Network";
    struct sockaddr_storage zeroAddress;
    bzero(&zeroAddress,sizeof(zeroAddress));
    zeroAddress.ss_len = sizeof(zeroAddress);
    zeroAddress.ss_family = AF_INET;
    SCNetworkReachabilityRef defaultRouteReachability = SCNetworkReachabilityCreateWithAddress(NULL,(struct sockaddr *)&zeroAddress);
    SCNetworkReachabilityFlags flags;
    //获得连接的标志
    BOOL didRetrieveFlags = SCNetworkReachabilityGetFlags(defaultRouteReachability,&flags);
    CFRelease(defaultRouteReachability);
    //如果不能获取连接标志，则不能连接网络，直接返回
    if(!didRetrieveFlags){
        return strNetworkInfo;
    }
    BOOL isReachable = ((flags & kSCNetworkFlagsReachable)!=0);
    BOOL needsConnection = ((flags & kSCNetworkFlagsConnectionRequired)!=0);
    if(!isReachable || needsConnection) {
        return strNetworkInfo;
        
    }
    // 网络类型判断
    if((flags & kSCNetworkReachabilityFlagsConnectionRequired)== 0){
        strNetworkInfo = @"wifi";
    }
    if(((flags & kSCNetworkReachabilityFlagsConnectionOnDemand ) != 0) ||(flags & kSCNetworkReachabilityFlagsConnectionOnTraffic) != 0) {
        if ((flags & kSCNetworkReachabilityFlagsInterventionRequired) == 0){
            strNetworkInfo = @"wifi";
        }
    }
    if ((flags & kSCNetworkReachabilityFlagsIsWWAN) == kSCNetworkReachabilityFlagsIsWWAN)
    {
        if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
            CTTelephonyNetworkInfo * info = [[CTTelephonyNetworkInfo alloc] init];NSString *currentRadioAccessTechnology = info.currentRadioAccessTechnology;
            if (currentRadioAccessTechnology) {
                if ([currentRadioAccessTechnology isEqualToString:CTRadioAccessTechnologyLTE]) {
                    strNetworkInfo =  @"4g";
                } else if ([currentRadioAccessTechnology isEqualToString:CTRadioAccessTechnologyEdge] || [currentRadioAccessTechnology isEqualToString:CTRadioAccessTechnologyGPRS]) {
                    strNetworkInfo =  @"2g";
                } else {
                    strNetworkInfo =  @"3g";
                }
            }
        } else {
            if((flags & kSCNetworkReachabilityFlagsReachable) == kSCNetworkReachabilityFlagsReachable) {
                if ((flags & kSCNetworkReachabilityFlagsTransientConnection) == kSCNetworkReachabilityFlagsTransientConnection) {
                    if((flags & kSCNetworkReachabilityFlagsConnectionRequired) == kSCNetworkReachabilityFlagsConnectionRequired) {
                        strNetworkInfo = @"2G";
                    } else {
                        strNetworkInfo = @"3G";
                    }
                }
            }
        }
    }
    if ([strNetworkInfo isEqualToString:@"No Network"])
    {
        strNetworkInfo = @"WWAN";
    }
    return strNetworkInfo;
}

//获取设备型号
+ (NSString *)getDeviceModel {
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *deviceString = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    
    //iPhone
    if ([deviceString isEqualToString:@"iPhone1,1"])    return @"iPhone 1G";
    if ([deviceString isEqualToString:@"iPhone1,2"])    return @"iPhone 3G";
    if ([deviceString isEqualToString:@"iPhone2,1"])    return @"iPhone 3GS";
    if ([deviceString isEqualToString:@"iPhone3,1"])    return @"iPhone 4";
    if ([deviceString isEqualToString:@"iPhone3,2"])    return @"Verizon iPhone 4";
    if ([deviceString isEqualToString:@"iPhone4,1"])    return @"iPhone 4S";
    if ([deviceString isEqualToString:@"iPhone5,1"])    return @"iPhone 5";
    if ([deviceString isEqualToString:@"iPhone5,2"])    return @"iPhone 5";
    if ([deviceString isEqualToString:@"iPhone5,3"])    return @"iPhone 5C";
    if ([deviceString isEqualToString:@"iPhone5,4"])    return @"iPhone 5C";
    if ([deviceString isEqualToString:@"iPhone6,1"])    return @"iPhone 5S";
    if ([deviceString isEqualToString:@"iPhone6,2"])    return @"iPhone 5S";
    if ([deviceString isEqualToString:@"iPhone7,1"])    return @"iPhone 6 Plus";
    if ([deviceString isEqualToString:@"iPhone7,2"])    return @"iPhone 6";
    if ([deviceString isEqualToString:@"iPhone8,1"])    return @"iPhone 6s";
    if ([deviceString isEqualToString:@"iPhone8,2"])    return @"iPhone 6s Plus";
    if ([deviceString isEqualToString:@"iPhone8,4"])    return @"iPhone SE";
    if ([deviceString isEqualToString:@"iPhone9,1"] || [deviceString isEqualToString:@"iPhone9,3"])
        return @"iPhone 7";
    if ([deviceString isEqualToString:@"iPhone9,2"] || [deviceString isEqualToString:@"iPhone9,4"])
        return @"iPhone 7 Plus";
    if ([deviceString isEqualToString:@"iPhone10,1"] || [deviceString isEqualToString:@"iPhone10,4"])
        return @"iPhone 8";
    if ([deviceString isEqualToString:@"iPhone10,2"] || [deviceString isEqualToString:@"iPhone10,5"])
        return @"iPhone 8 Plus";
    if ([deviceString isEqualToString:@"iPhone10,3"] || [deviceString isEqualToString:@"iPhone10,6"])
        return @"iPhone X";
    if ([deviceString isEqualToString:@"iPhone11,2"])
        return @"iPhone XS";
    if ([deviceString isEqualToString:@"iPhone11,4"] || [deviceString isEqualToString:@"iPhone11,6"])
        return @"iPhone XS Max";
    if ([deviceString isEqualToString:@"iPhone11,8"])
        return @"iPhone XR";

    
    //iPod
    if ([deviceString isEqualToString:@"iPod1,1"])
        return @"iPod Touch 1G";
    if ([deviceString isEqualToString:@"iPod2,1"])      return @"iPod Touch 2G";
    
    if ([deviceString isEqualToString:@"iPod3,1"])      return @"iPod Touch 3G";
    
    if ([deviceString isEqualToString:@"iPod4,1"])      return @"iPod Touch 4G";
    
    if ([deviceString isEqualToString:@"iPod5,1"])      return @"iPod Touch 5G";
    
    //iPad
    if ([deviceString isEqualToString:@"iPad1,1"])      return @"iPad";
    
    if ([deviceString isEqualToString:@"iPad2,1"])      return @"iPad 2 (WiFi)";
    
    if ([deviceString isEqualToString:@"iPad2,2"])      return @"iPad 2 (GSM)";
    
    if ([deviceString isEqualToString:@"iPad2,3"])      return @"iPad 2 (CDMA)";
    
    if ([deviceString isEqualToString:@"iPad2,4"])      return @"iPad 2 (32nm)";
    
    if ([deviceString isEqualToString:@"iPad2,5"])      return @"iPad mini (WiFi)";
    
    if ([deviceString isEqualToString:@"iPad2,6"])      return @"iPad mini (GSM)";
    
    if ([deviceString isEqualToString:@"iPad2,7"])      return @"iPad mini (CDMA)";
    if ([deviceString isEqualToString:@"iPad3,1"])      return @"iPad 3(WiFi)";
    
    if ([deviceString isEqualToString:@"iPad3,2"])      return @"iPad 3(CDMA)";
    
    if ([deviceString isEqualToString:@"iPad3,3"])      return @"iPad 3(4G)";
    
    if ([deviceString isEqualToString:@"iPad3,4"])      return @"iPad 4 (WiFi)";
    
    if ([deviceString isEqualToString:@"iPad3,5"])      return @"iPad 4 (4G)";
    
    if ([deviceString isEqualToString:@"iPad3,6"])      return @"iPad 4 (CDMA)";
    
    if ([deviceString isEqualToString:@"iPad4,1"])      return @"iPad Air";
    
    if ([deviceString isEqualToString:@"iPad4,2"])      return @"iPad Air";
    
    if ([deviceString isEqualToString:@"iPad4,3"])      return @"iPad Air";
    
    if ([deviceString isEqualToString:@"iPad5,3"])      return @"iPad Air 2";
    
    if ([deviceString isEqualToString:@"iPad5,4"])      return @"iPad Air 2";
    
    if ([deviceString isEqualToString:@"i386"])         return @"Simulator";
    
    if ([deviceString isEqualToString:@"x86_64"])       return @"Simulator";
    if ([deviceString isEqualToString:@"iPad4,4"]
        
        ||[deviceString isEqualToString:@"iPad4,5"]
        
        ||[deviceString isEqualToString:@"iPad4,6"])      return @"iPad mini 2";
    if ([deviceString isEqualToString:@"iPad4,7"]
        
        ||[deviceString isEqualToString:@"iPad4,8"]
        
        ||[deviceString isEqualToString:@"iPad4,9"])      return @"iPad mini 3";
    return deviceString;
}

/**
 *  获取UDID
 *
 */
+ (NSString *)getUDID {
     NSString *identifierForVendor = [[UIDevice currentDevice].identifierForVendor UUIDString];
    return identifierForVendor;
}

//运营商
+ (NSString *)getcarrierName {
    CTTelephonyNetworkInfo *info = [[CTTelephonyNetworkInfo alloc] init];
    
    CTCarrier *carrier = [info subscriberCellularProvider];
    
    NSString *mobile;
    
    if (!carrier.isoCountryCode) {
        mobile = @"";
    }else{
        mobile = [carrier carrierName];
    }
    return mobile;
}

/**
   获取手机分辨率
 */
+ (NSString *)getScrePhone {
    CGRect rect = [[UIScreen mainScreen] bounds];
    CGSize size = rect.size;
    CGFloat width = size.width;
    CGFloat height = size.height;
    CGFloat scale_screen = [UIScreen mainScreen].scale;
    return  [NSString stringWithFormat:@"%.0f*%.0f", width*scale_screen,height*scale_screen];
}

/**
 *  手机内存
 */

+ (NSString *)getPhoneDiskSapce {
    //16 32 64 128 256
    float space =  [KeleDeviceInfoTool getTotalDiskspace];
    if (space > 0 && space <= 16) {
        return @"16";
    }else if (space >16 && space <=32){
        return @"32";
    }else if (space >32 && space <=64){
        return @"64";
    }else if (space >64 && space <=128){
        return @"128";
    }else if (space >128 && space <=256){
        return @"256";
    }else{
        return @"暂不支持此类型手机";
    }
}

+ (float)getTotalDiskspace{
    float totalSpace;
    NSError *error = nil;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSDictionary *dictionary = [[NSFileManager defaultManager] attributesOfFileSystemForPath:[paths lastObject] error: &error];
    if (dictionary) {
        NSNumber *fileSystemSizeInBytes = [dictionary objectForKey: NSFileSystemSize];
        totalSpace = [fileSystemSizeInBytes floatValue]/1024.0f/1024.0f/1024.0f;
    } else {
        totalSpace = 0;
    }
    return totalSpace;
}

/** 获取操作系统版本 11.1
 */
+ (NSString *)getOperatingSystemVersion {
    NSString *phoneVersion = [[UIDevice currentDevice] systemVersion];
    return phoneVersion;
}


/** 获取iPhone8,1
 */

+ (NSString *)getiPhoneDevice {
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *deviceString = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    return deviceString;
}

@end
