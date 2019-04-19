//
//  AppDelegate+Vender.m
//  RabbitConyYok
//
//  Created by Single_Nobel on 2018/8/17.
//  Copyright © 2018年 Single_Nobel. All rights reserved.
//

#import "AppDelegate+Vender.h"

@implementation AppDelegate (Vender)

//初始化initwindow
- (void)initWithWindows {
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    [self.window makeKeyAndVisible];
    //避免在一个界面上同时点击多个UIButton导致同时响应多个方法
    [[UIButton appearance] setExclusiveTouch:YES];
    if (@available(iOS 11.0, *)) {
        [[UIScrollView appearance] setContentInsetAdjustmentBehavior:UIScrollViewContentInsetAdjustmentNever];
        [UITableView appearance].estimatedRowHeight = 0;
        [UITableView appearance].estimatedSectionHeaderHeight = 0;
        [UITableView appearance].estimatedSectionFooterHeight = 0;
    }
}


#pragma mark - 获取当前vc
//单例
+ (AppDelegate *)shareAppDelegate {
    return   (AppDelegate *)[UIApplication sharedApplication].delegate;
}

- (UIViewController*)getCurrentVC {
    UIViewController * controller = nil;
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal) {
        NSArray * windows = [[UIApplication sharedApplication] windows];
        for (UIWindow * tmpwindow in windows) {
            if (tmpwindow.windowLevel == UIWindowLevelNormal) {
                window = tmpwindow;
                break;
            }
        }
    }
    UIView * firstView = [[window subviews] objectAtIndex:0];
    id nextResponder = [firstView nextResponder];
    if ([nextResponder isKindOfClass:[UIViewController class]]) {
        controller = nextResponder;
    }else{
        controller = window.rootViewController;
    }
    
    return controller;
}
//
- (UIViewController*)getCurrentUIVC {
    UIViewController * superVC = [self getCurrentVC];
    if ([superVC isKindOfClass:[UITabBarController class]]) {
        UIViewController  *tabSelectVC = ((UITabBarController*)superVC).selectedViewController;
        
        if ([tabSelectVC isKindOfClass:[UINavigationController class]]) {
            
            return ((UINavigationController*)tabSelectVC).viewControllers.lastObject;
        }
        return tabSelectVC;
    }else
        if ([superVC isKindOfClass:[UINavigationController class]]) {
            
            return ((UINavigationController*)superVC).viewControllers.lastObject;
        }
    return superVC;
}

@end
