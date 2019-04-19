//
//  AppDelegate+Vender.h
//  RabbitConyYok
//
//  Created by Single_Nobel on 2018/8/17.
//  Copyright © 2018年 Single_Nobel. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate (Vender)
//初始化initwindow
-(void)initWithWindows;

//单例
+ (AppDelegate *)shareAppDelegate;

- (UIViewController *)getCurrentVC;
//当前顶层控制器
//

-(UIViewController *)getCurrentUIVC;
@end
