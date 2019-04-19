//
//  BaseViewController.h
//  ViewDemo
//
//  Created by Single_Nobel on 2018/8/3.
//  Copyright © 2018年 Single_Nobel. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseNavgationBar.h"
@interface BaseViewController : UIViewController
@property(strong,nonatomic)BaseNavgationBar *BaseNavgationBar;
@property(strong,nonatomic)UIView *baseHeadView;
- (void)creatLineWith:(UIView *)view withFrame:(CGRect )frame;
@end
