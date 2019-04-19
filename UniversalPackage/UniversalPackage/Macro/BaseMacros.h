//
//  BaseMacros.h
// HotLoanYok
//
//  Created by Single_Nobel on 2018/9/7.
//  Copyright © 2018年 Single_Nobel. All rights reserved.
//

#ifndef BaseMacros_h
#define BaseMacros_h
/*
 * Masnory 全局宏定义
 **/
#define MAS_SHORTHAND_GLOBALS   //使equalTo等效于mas_equalTo
#define MAS_SHORTHAND           //不是用mas_ 前缀

/*
 * 屏幕适配
 */
#define BntLength(W) [UIView bnt_configureWidth:(W)]
#define BntAltitude(H) [UIView bnt_configureHeight:(H)]

/* 缩放比例 */
#define kscale kWidth/375

/* 屏幕宽高 */
#define kWidth [UIScreen mainScreen].bounds.size.width
#define kHeight [UIScreen mainScreen].bounds.size.height


/* 字号 */
#define Font(F) [UIFont bnt_configure:(F)]
#define kFont (kWidth >320 ? 15: 14)
#define k5sFont (kWidth >320 ? 16: 15)
#define kiphoneXfont   (iPhoneX ? 12 :14)


/* 窗口 */
#define kWindow           [UIApplication sharedApplication].delegate.window
/* 16进制颜色 */
#define kRGB(r,g,b) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]
/* 判断iphone 型号 */

#define iPhone4s ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO) //判断是否iphone4

#define iPhone5s ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO) //判断是否iphone5

#define iPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO) //判断是否是iphoneX/S
#define iPhoneXR ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(828, 1792), [[UIScreen mainScreen] currentMode].size) : NO)//判断是否是iphoneXR
#define iPhoneXSMax ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2688), [[UIScreen mainScreen] currentMode].size) : NO)//判断是否是iphoneXSMAX

//#define KIsiPhoneX ((int)((kHeight/kWidth)*100) == 216) ? YES : NO  //根据屏占比 来判断是否是x、xs、xr、xsmax  目前仅适用于当前已有的手机型号

#define KIsiPhoneX (([[UIApplication sharedApplication] statusBarFrame].size.height == 44.0f) ? (YES):(NO)) //根据状态栏搞度判断来判断是否是x、xs、xr、xsmax 目前仅适用于当前已有的手机型号


/* 状态栏高度*/
#define kStatusbarHeight  [[UIApplication sharedApplication] statusBarFrame].size.height //状态栏高度
#define kNavBarHeight (int)(kStatusbarHeight+44.0) //导航bar高度


/* 强引用 && 弱引用 */
#define kWeakSelf(type)  __weak typeof(type) weak##type = type;
#define kStrongSelf(type)  __strong typeof(type) type = weak##type;

/* 一些方便的配置 */
#define kUrlfromStr(str)\
({NSURL *imgUrl = [NSURL URLWithString:str];\
(imgUrl);})

#define kMubDelayTime 1  //提示框时间
#define kImageName(_image) [UIImage imageNamed:_image]

#define kAppDelegate      [AppDelegate shareAppDelegate]

#define kuserdefaults [NSUserDefaults standardUserDefaults]

/* 系统版本 */
#define kiOS7    [[UIDevice currentDevice].systemVersion floatValue] >=7.0

/* 非空判断 */
#define STR_Not_NullAndEmpty(str) (str!=nil&&![str isEqualToString:@""])
#define isValidDict(f) (f!=nil && [f isKindOfClass:[NSDictionary class]])
#define isNilOrNull(_ref)   (((_ref) == nil) || ([(_ref) isEqual:[NSNull null]]) || ([(_ref) isKindOfClass:[NSNull class]]) )
#define isValidStr(_ref) ((isNilOrNull(_ref)==NO) && ([_ref length]>0) && (![_ref isEqualToString:@"(null)"]))

/**
 *  webViewTool 防止循环引用
 */
#define kwebSelf [[WeakScriptMessageDelegate alloc] initWithDelegate:self]
#define kcloseAndOpen @"closeAndOpen"
#define kGetTokenWeb @"getToken"



/* 打印信息 */
#ifdef DEBUG

#define NSLog(...)  NSLog(__VA_ARGS__)

#else

#define NSLog(...)

#endif


#endif /* BaseMacros_h */
