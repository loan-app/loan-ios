//
//  MBProgressHUD+KeleHUD.h
// RabbitConyYok
//
//  Created by Single_Nobel on 2018/8/7.
//  Copyright © 2018年 Single_Nobel. All rights reserved.
//


#import <MBProgressHUD/MBProgressHUD.h>

@interface MBProgressHUD (MLHUD)

/**
 *  显示
 *
 *  @param mode 模式
 *  @param view 添加到视图
 *  @param text 信息
 *  @param icon 图标
 *  @param time 持续时间
 */
+ (MBProgressHUD *)showUnderMode:(MBProgressHUDMode)mode
                          toView:(UIView *)view
                            text:(NSString *)text
                            icon:(NSString *)icon
                            time:(float)time;

/**
 *  显示风火轮
 */
+ (void)showIndeterminate;

/**
 *  显示有信息和风火轮
 *
 *  @param message 信息
 *  @param view    toView
 *
 */
+ (void)bnt_indeterminateWithMessage:(NSString *)message
                              toView:(UIView *)view;

/**
 *  只显示信息
 *
 *  @param message 信息内容
 *
 *  @return 直接返回一个MBProgressHUD，需要手动关闭
 */
+ (MBProgressHUD *)bnt_showMessage:(NSString *)message;

+ (MBProgressHUD *)bnt_showMessage:(NSString *)message
                            toView:(UIView *)view;

+ (MBProgressHUD *)bnt_showMessage:(NSString *)message delay:(CGFloat)delay;

+ (void)bnt_showError:(NSString *)error;
+ (void)bnt_showError:(NSString *)error toView:(UIView *)view;

+ (void)bnt_hideHUD;
+ (void)bnt_hideHUDForView:(UIView *)view;

/**
 * 提示错误信息❌蒙板
 */
+ (void)showError:(NSString *)error toView:(UIView *)view;

/**
 * 提示成功蒙板
 */
+ (void)showSuccess:(NSString *)success toView:(UIView *)view;

/**
 * 转圈等待蒙板
 */

+ (MBProgressHUD *)showMessage:(NSString *)message toView:(UIView *)view;

/**
 *  移除蒙板
 *
 */
+ (void)hideHUDView:(UIView *)view;


@end
