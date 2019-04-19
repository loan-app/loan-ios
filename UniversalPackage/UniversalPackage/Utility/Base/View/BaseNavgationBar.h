//
//  BaseNavgationBar.h
//  ViewDemo
//
//  Created by Single_Nobel on 2018/8/3.
//  Copyright © 2018年 Single_Nobel. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol BaseNavDelegate<NSObject>
-(void)clickWithRightBtn:(UIButton *)sender;
@end
@interface BaseNavgationBar : UIView
@property(assign,nonatomic) id<BaseNavDelegate>delegate;
+(instancetype)shareBaseNagationBar; //初始化
@property(copy,nonatomic)void(^leftClickBack)(void);//左侧按钮点击回调

@property(strong,nonatomic)UIButton *leftBtn; //左侧返回按钮

@property(strong,nonatomic)UIButton *rightBtn; //右侧按钮,默认隐藏

@property(strong,nonatomic)CALayer *linelayer;

@property(strong,nonatomic)UILabel *titleLabel; //标题

@property(assign,nonatomic)BOOL NavRightBtnHidden; //右侧按钮是否隐藏BOOL值

@property(assign,nonatomic)BOOL RightBtnEnabled; //右侧按钮否可以点击 BOOL 值

@property(assign,nonatomic)BOOL lineHidden;

@property(copy,nonatomic)NSString *Rbtntitle; //右侧按钮标题
@property(copy,nonatomic)NSString *title;
@property(copy,nonatomic)NSString *rightImage;


@end
