//
//  BaseTabBarViewController.m
//  ViewDemo
//
//  Created by Single_Nobel on 2018/8/2.
//  Copyright © 2018年 Single_Nobel. All rights reserved.
//
#import "BaseTabBarViewController.h"
#import "BaseNavViewController.h"
#import "HomeViewController.h"
#import "MineViewController.h"
@interface BaseTabBarViewController ()
@end
@implementation BaseTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
//    self.tabBar.clipsToBounds = YES;
    [UITabBar appearance].translucent = NO;//去掉tabbar透明效果;
    self.tabBar.backgroundColor = kFFFColor;
    [self setupChildController];
//
//    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(changeItemTitle:) name:@"loadH5code" object:nil];

    // Do any additional setup after loading the view.
}
//-(void)changeItemTitle:(NSNotification *)notification{
//     NSString *loadPathStr = [notification.userInfo objectForKey:@"key"];
//    UIViewController *secNav = self.childViewControllers[1];
//    [self setupTabBarItemPropertyWithVC:secNav title:loadPathStr image:@"ic_find_normal" selectedImage:@"ic_find_selected"];
//}
-(void)setupChildController{

    HomeViewController *IndividualVC = [[HomeViewController alloc]init];
    BaseNavViewController *IndividualNav = [[BaseNavViewController alloc]initWithRootViewController:IndividualVC];

    
    MineViewController *MineVC = [[MineViewController alloc]init];
    BaseNavViewController *MineNav = [[BaseNavViewController alloc]initWithRootViewController:MineVC];
    
    self.viewControllers = @[IndividualNav,MineNav];
    
    [self setupAllBarItem];

}
- (void)setupAllBarItem {
    UIViewController *firstNav = self.childViewControllers[0];
    [self setupTabBarItemPropertyWithVC:firstNav title:@"首页" image:@"ic_home_normal" selectedImage:@"ic_home_selected"];
    UIViewController *thirdNav = self.childViewControllers[1];
    [self setupTabBarItemPropertyWithVC:thirdNav title:@"我的" image:@"ic_personnal_normal" selectedImage:@"ic_personal_selected"];
}

- (void)setupTabBarItemPropertyWithVC:(UIViewController *)vc title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage {
    vc.tabBarItem.title = title;
    //去掉系统渲染
    vc.tabBarItem.image = [[UIImage imageNamed:image] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    vc.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    [vc.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:K999Color , NSFontAttributeName:[UIFont fontWithName:@"Marion-Italic" size:12.0] } forState:UIControlStateNormal];
    [vc.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:k333Color , NSFontAttributeName:[UIFont fontWithName:@"Marion-Italic" size:12.0]} forState:UIControlStateSelected];
}

-(void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)dealloc{
//    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"loadH5code" object:self];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
