//
//  AppDelegate.m
//  RabbitConyYok
//
//  Created by Single_Nobel on 2018/8/28.
//  Copyright © 2018年 Single_Nobel. All rights reserved.
//

#import "AppDelegate.h"
#import "AppDelegate+Vender.h"
#import "BaseTabBarViewController.h"
#import "StarupViewController.h"
#import "BaseNavViewController.h"
#import "StartoverView.h"

@interface AppDelegate ()
@property (nonatomic, copy)  NSString * versionContent;
@property (nonatomic, copy)  NSString * versionUrl;
@property (nonatomic, strong) NSNumber * versionForce;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [self initWithWindows];
    [self setUpVersionCode];
    [self startUP];
    
    return YES;
}

-(void)startUP{
    StarupViewController *starVC = [[StarupViewController alloc]init];
    BaseNavViewController *nvaVC = [[BaseNavViewController alloc]initWithRootViewController:starVC];
    [self.window setRootViewController:nvaVC];
}
-(void)enterApp{
    BaseTabBarViewController *baseTabBVC = [[BaseTabBarViewController alloc]init];
    [self.window setRootViewController:baseTabBVC];
    [StartoverView sharInstance];


}

//版本更新
- (void)setUpVersionCode {
    kWeakSelf(self);
    [[NetworkUtils sharedInstance]checkVersionWithUtilsSuccess:^(id response) {
        if ([BaseTool responseWithNetworkDealResponse:response]) {
            [weakself versionAppUpgrade:response];
            
        }
    } utilsFail:^(NSString *error) {
        
    }];
}
- (void)versionAppUpgrade:(id)response {
    if (isValidDict(response[@"data"])) {
        //1,强制升级 0 不是强升
        self.versionForce = response[@"data"][@"versionForce"];
        //  提示的文案
        self.versionContent = response[@"data"][@"versionContent"];
        
        self.versionUrl  = response[@"data"][@"versionUrl"];
        
        NSString *currentVersion = [[[NSBundle mainBundle]infoDictionary]objectForKey:@"CFBundleVersion"];
        NSLog(@"当前版本----%@", currentVersion);
        
        int currentVS = [currentVersion intValue];
        int nowVS = [response[@"data"][@"versionCode"] intValue];
        if (currentVS < nowVS) {
            dispatch_async(dispatch_get_main_queue(), ^{
                if ([self.versionForce isEqualToNumber:@1]) {
                    [self constrainVersion];
                }else if ([self.versionForce isEqualToNumber:@0]){
                    BaseAlertViewController * alertVC = [BaseAlertViewController alertControllerWithTitle:@"发现新版本" message:self.versionContent];
                    alertVC.messageAlignment = NSTextAlignmentLeft;
                    BaseAlertAction *mldate = [BaseAlertAction actionWithTitle:@"我知道了" handler:^(BaseAlertAction *action) {
                        NSLog(@"点击了 %@ 按钮",action.title);
                    }];
                    BaseAlertAction *cancel = [BaseAlertAction actionWithTitle:@"前往更新" handler:^(BaseAlertAction *action) {
                        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:self.versionUrl]];
                    }];
                    [alertVC addAction:cancel];
                    [alertVC addAction:mldate];
                    
                    [[kAppDelegate getCurrentUIVC] presentViewController:alertVC animated:NO completion:nil];
                }
            });
        }else {
            
        }
    }
}

- (void)constrainVersion{
    BaseAlertViewController * malertVC = [BaseAlertViewController alertControllerWithTitle:@"发现新版本" message:self.versionContent];
    malertVC.messageAlignment = NSTextAlignmentLeft;
    BaseAlertAction *update = [BaseAlertAction actionWithTitle:@"立即更新" handler:^(BaseAlertAction *action) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:self.versionUrl]];
    }];
    [malertVC addAction:update];
    [[kAppDelegate getCurrentUIVC] presentViewController:malertVC animated:NO completion:nil];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
