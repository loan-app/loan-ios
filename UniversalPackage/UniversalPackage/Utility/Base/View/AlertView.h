//
//  AlertView.h
//  demo
//
//  Created by Single_Nobel on 2018/9/5.
//  Copyright © 2018年 Fan Zhang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AlertView : UIView
+(AlertView *)sharInstance;
@property(strong,nonatomic)UIView *popView;
@property(strong,nonatomic)UIView *textBcView;
@property(strong,nonatomic)UILabel *titleLab;
@property(strong,nonatomic)UILabel *nameLab;
@property(strong,nonatomic)UILabel *identiLab;
@property(strong,nonatomic)UILabel *remainLab;
@property(strong,nonatomic)UIButton *confirmBtn;
@property(strong,nonatomic)UIButton *nameBtn;
-(void)showpopView:(NSString *)name Identi:(NSString *)identi;
+(void)confirmClick:(void(^)(void))back;
+(void)cancelClick:(void(^)(void))back;

@end
