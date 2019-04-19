//
//  BaseNavViewController.m
//  ViewDemo
//
//  Created by Single_Nobel on 2018/8/3.
//  Copyright © 2018年 Single_Nobel. All rights reserved.
//

#import "BaseNavViewController.h"
@interface BaseNavViewController ()<UIGestureRecognizerDelegate,UINavigationControllerDelegate,UINavigationBarDelegate>
@end

@implementation BaseNavViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    self.navigationBar.translucent = NO;
    self.navigationBar.hidden = YES;
    //去掉导航bar底部的横线;
    [self searchNavigationBarUnderLine:self.navigationBar].hidden =YES;
}
+ (void)load
{
    UINavigationBar *bar = [UINavigationBar appearance];
    // 设置导航条标题字体
    NSMutableDictionary *attr = [NSMutableDictionary dictionary];
    attr[NSFontAttributeName] = [UIFont boldSystemFontOfSize:18];
    bar.titleTextAttributes = attr;
    bar.tintColor = [UIColor blackColor];
    // 设置item
    UIBarButtonItem *item = [UIBarButtonItem appearance];
    NSMutableDictionary *itemAttrs = [NSMutableDictionary dictionary];
    itemAttrs[NSForegroundColorAttributeName] =[UIColor blackColor];
    itemAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:14];
    [item setTitleTextAttributes:itemAttrs forState:UIControlStateNormal];
    // UIControlStateDisabled
    NSMutableDictionary *itemDisabledAttrs = [NSMutableDictionary dictionary];
    [item setTitleTextAttributes:itemDisabledAttrs forState:UIControlStateDisabled];
}
- (UIImageView *)searchNavigationBarUnderLine:(UIView *)view
{
    // 查找是否属于UIImageView以及Frame是否小于1.0
    if ([view isKindOfClass:[UIImageView class]] && view.bounds.size.height < 1.0f)
    {
        return (UIImageView *)view;
    }
    // 循环第二层查找
    for (UIView *subView in view.subviews)
    {
        // 递归查找
        UIImageView *imageView = [self searchNavigationBarUnderLine:subView];
        if (imageView) {
            return imageView;
        }
    }
    return nil;
}
#pragma mark 返回手势代理
-(id)initWithRootViewController:(UIViewController *)rootViewController
{
    BaseNavViewController * nvc = [super initWithRootViewController:rootViewController];
    self.interactivePopGestureRecognizer.delegate = self;
    nvc.delegate = self;
    return nvc;
}

#pragma mark - 重写push
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.viewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
        //重写返回按钮
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"ic_back"] landscapeImagePhone:nil style:UIBarButtonItemStyleDone target:self action:@selector(back)];
    }
    [super pushViewController:viewController animated:animated];
}
#pragma mark -  拦截所有pop方法
- (void)back
{
       //这里就可以自行修改返回按钮的各种属性等 返回的方法
    [super popViewControllerAnimated:YES];
    [self.navigationController popViewControllerAnimated:YES];
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    // 这里我们根据当前导航控制器的子控制数量来判断当前的控制器是否为根控制器
    return self.childViewControllers.count > 1;
}


@end
