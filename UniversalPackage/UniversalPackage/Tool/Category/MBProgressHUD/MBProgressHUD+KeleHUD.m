//
//  MBProgressHUD+KeleHUD.m
// RabbitConyYok
//
//  Created by Single_Nobel on 2018/8/7.
//  Copyright © 2018年 Single_Nobel. All rights reserved.
//


#import "MBProgressHUD+KeleHUD.h"

#define DefaultMode MBProgressHUDModeIndeterminate
#define DefaultDelay 2
#define DefaultDelayIndeterminate 6

@implementation MBProgressHUD (MLHUD)
+ (MBProgressHUD *)showUnderMode:(MBProgressHUDMode)mode
                          toView:(UIView *)view
                            text:(NSString *)text
                            icon:(NSString *)icon
                            time:(float)time
{
    if (view == nil) {
        view = kWindow;
    }
    __block MBProgressHUD *hud_1 = [[MBProgressHUD alloc] init];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
        
        hud.contentColor =  [UIColor colorWithHexString:@"#000000" alpha:0.5];
        
        hud.label.text = text;
        hud.label.numberOfLines = 3;
        //    hud.label.font = Font(13);
        
        if (icon) {
            hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:icon]];
        }
        
        if (mode) {
            hud.mode = mode;
        }else{
            hud.mode = DefaultMode;
        }
        
        //  隐藏时移除
        hud.removeFromSuperViewOnHide = YES;
        
        if (time) {
            [hud hideAnimated:YES afterDelay:time];
        }else{
            [hud hideAnimated:YES afterDelay:DefaultDelay];
        }
        hud_1 = hud;
    });
    return hud_1;
}

//  风火轮模式
+ (void)showIndeterminate
{
    [MBProgressHUD showMode:DefaultMode toView:kWindow];
    //    [MBProgressHUD showUnderMode:DefaultMode toView:BntKeyWindow text:nil icon:nil time:10];
}


/**
 *  显示不带信息
 *
 *  @param mode 信息内容
 *  @param view    需要显示信息的视图
 *
 */

+ (void)showMode:(MBProgressHUDMode)mode toView:(UIView *)view {
    if (view == nil) view = kWindow;
    dispatch_async(dispatch_get_main_queue(), ^{
        // 快速显示一个提示信息
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
        hud.mode = mode;
        hud.bezelView.color = [UIColor colorWithHexString:@"#000000" alpha:0.5];
        
//        hud.contentColor = kMubHUDColor;
        
        [hud hideAnimated:YES afterDelay:DefaultDelayIndeterminate];
        // 隐藏时候从父控件中移除
        hud.removeFromSuperViewOnHide = YES;
    });
    
    
}

/**
 *  显示有信息和风火轮
 *
 *  @param message 信息
 *  @param view    toView
 *
 */
+ (void)bnt_indeterminateWithMessage:(NSString *)message
                              toView:(UIView *)view
{
    if (view == nil){
        view = kWindow;
    }
    // 快速显示一个提示信息
    MBProgressHUD *hud = [MBProgressHUD showUnderMode:MBProgressHUDModeIndeterminate toView:view text:message icon:nil time:DefaultDelayIndeterminate];
    // 蒙版效果
    hud.backgroundView.style = MBProgressHUDBackgroundStyleSolidColor;
    
}

+ (MBProgressHUD *)bnt_showMessage:(NSString *)message delay:(CGFloat)delay
{
    
    // 快速显示一个提示信息
    MBProgressHUD *hud = [MBProgressHUD showUnderMode:MBProgressHUDModeText toView:kWindow text:message icon:nil time:delay];
    
    // 蒙版效果
    hud.backgroundView.style = MBProgressHUDBackgroundStyleSolidColor;
    hud.contentColor = [UIColor colorWithHexString:@"#56C2F0"];
    
    return hud;
}

/**
 *  只显示信息
 *
 *  @param message 信息内容
 *  @param view    需要显示信息的视图
 *
 *  @return 直接返回一个MBProgressHUD，需要手动关闭
 */
+ (MBProgressHUD *)bnt_showMessage:(NSString *)message
                            toView:(UIView *)view
{    if (view == nil) {
    view = kWindow;
}
    // 快速显示一个提示信息
    MBProgressHUD *hud = [MBProgressHUD showUnderMode:MBProgressHUDModeText toView:view text:message icon:nil time:DefaultDelay];
    
    // 蒙版效果
    hud.backgroundView.style = MBProgressHUDBackgroundStyleSolidColor;
    hud.contentColor = [UIColor colorWithHexString:@"#56C2F0"];
    
    return hud;
}

+ (MBProgressHUD *)bnt_showMessage:(NSString *)message
{
    // 快速显示一个提示信息
    MBProgressHUD *hud = [MBProgressHUD bnt_showMessage:message toView:kWindow];
    
    return hud;
}


#pragma mark - error
/**
 *  显示错误信息
 *
 */
+ (void)bnt_showError:(NSString *)error
{
    [self bnt_showError:error toView:nil];
}

/**
 *  显示错误信息
 *
 *  @param error 错误信息内容
 *  @param view  需要显示信息的视图
 */
+ (void)bnt_showError:(NSString *)error toView:(UIView *)view{
    [self showUnderMode:MBProgressHUDModeText toView:view text:error icon:nil time:0.5];
}



#pragma mark - hide

/**
 *  手动关闭
 */
+ (void)bnt_hideHUD
{
    [self bnt_hideHUDForView:nil];
    
}

+ (void)bnt_hideHUDForView:(UIView *)view
{
    if (view == nil)
    {
        view = kWindow;
    }
    dispatch_async(dispatch_get_main_queue(), ^{
        
        [self hideHUDForView:view animated:YES];
    });
}


+ (void)show:(NSString *)text icon:(NSString *)icon view:(UIView *)view{
    if (view == nil) view = [UIApplication sharedApplication].keyWindow;
    
    dispatch_async(dispatch_get_main_queue(), ^{
        if (self) {
            [self bnt_hideHUD];
        }
        MBProgressHUD *hub = [MBProgressHUD showHUDAddedTo:view animated:YES];
        hub.label.text = text;
        //        hub.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"MBProgressHUD.bundle/%@", icon]]];
        hub.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:icon]];
        hub.mode = MBProgressHUDModeCustomView;
        hub.removeFromSuperViewOnHide = YES;
        [MBProgressHUD bnt_hideHUD];
    });
    
}


+ (void)hideHUDView:(UIView *)view{
    dispatch_async(dispatch_get_main_queue(), ^{
        [MBProgressHUD hideHUDForView:view animated:YES];
    });
}

+ (void)showError:(NSString *)error toView:(UIView *)view{
    
    [self show:error icon:@"info_Nav" view:view];
    //        [self show:error icon:@"error.png" view:view];
}

+ (void)showSuccess:(NSString *)success toView:(UIView *)view{
    
    [self show:success icon:@"success.png" view:view];
    
}

/**
 * 转圈等待蒙板
 */
+ (MBProgressHUD *)showMessage:(NSString *)message toView:(UIView *)view{
    if (view == nil) {
        view = [UIApplication sharedApplication].keyWindow;
    }
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.label.text = message;
    hud.removeFromSuperViewOnHide = YES;
    // 蒙版效果
    hud.backgroundView.style = MBProgressHUDBackgroundStyleSolidColor;
    //需要蒙板效果xc
    //        hud.dimBackground = YES;
    //        [hud hide:YES afterDelay:0.6];
    return hud;
}
@end
