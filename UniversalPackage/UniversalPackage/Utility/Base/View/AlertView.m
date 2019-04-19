//
//  AlertView.m
//  demo
//
//  Created by Single_Nobel on 2018/9/5.
//  Copyright © 2018年 Fan Zhang. All rights reserved.
//

#import "AlertView.h"
static AlertView *alertObj;
@interface AlertView()<UIGestureRecognizerDelegate>
@property(copy,nonatomic)void(^confirmback)(void);
@property(copy,nonatomic)void(^cancelback)(void);
@end
@implementation AlertView
-(instancetype)init{
    if (self = [super init]) {
        self.backgroundColor =kWhiteColor;
    }
    return self;
}
+(AlertView *)sharInstance{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        alertObj = [[self alloc]init];
    });
    return alertObj;
}
-(void)showpopView:(NSString *)name Identi:(NSString *)identi{
    [kWindow addSubview:self];
    [self setUI];
    [self setContrains];
    self.nameLab.text = [NSString stringWithFormat:@"姓名: %@",name];
    self.identiLab.text =  [NSString stringWithFormat:@"身份证: %@",identi];
}
-(void)hidepopView{
    [self removeFromSuperview];
}
-(void)setUI{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hidepopView)];
    tap.delegate = self;
    [self addGestureRecognizer:tap];
    self.backgroundColor = [UIColor colorWithWhite:0.2 alpha:0.6];
    [self addSubview:self.popView];
}
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    if ([touch.view isDescendantOfView:self.popView]) {
        return NO;
    }
    return YES;
}

-(void)setContrains{
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_equalTo(0);
        make.width.mas_equalTo(kWidth);
        make.height.mas_equalTo(kHeight);
    }];
    CGFloat height =  iPhone4s ||iPhone5s ? 10 : 60;
    CGFloat width = iPhone4s ||iPhone5s ? kWidth : 375;
    [self.popView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(kWidth-80);
        make.height.mas_equalTo(width-height);
        make.centerX.equalTo(self.mas_centerX);
        make.centerY.equalTo(self.mas_centerY);
    }];
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(30);
        make.left.mas_equalTo(20);
        make.height.mas_equalTo(30);
        make.width.equalTo(self.popView.mas_width).offset(-40);
    }];
    [self.remainLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLab.mas_bottom).offset(5);
        make.left.mas_equalTo(20);
        make.width.equalTo(self.popView.mas_width).offset(-40);
        make.height.mas_equalTo(30);
    }];
    [self.textBcView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.remainLab.mas_bottom).offset(15);
        make.left.mas_equalTo(15);
        make.width.equalTo(self.popView.mas_width).offset(-30);
        make.height.mas_equalTo(80);
    }];
    
    [self.nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(5);
        make.left.mas_equalTo(10);
        make.width.equalTo(self.textBcView.mas_width).offset(-20);
        make.height.mas_equalTo(30);
    }];
    [self.identiLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.nameLab.mas_bottom).offset(10);
        make.left.mas_equalTo(10);
        make.width.equalTo(self.textBcView.mas_width).offset(-20);
        make.height.mas_equalTo(30);
    }];
    
    [self.nameBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.textBcView.mas_bottom).offset(20);
        make.left.mas_equalTo(0);
        make.width.equalTo(self.popView.mas_width);
        make.height.mas_equalTo(50);
    }];
    [self.confirmBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.nameBtn.mas_bottom);
        make.left.mas_equalTo(0);
        make.width.equalTo(self.popView.mas_width);
        make.height.mas_equalTo(50);
    }];
    
}
-(UIView *)popView{
    if (!_popView) {
        _popView = [[UIView alloc]init];
        _popView.layer.cornerRadius = 5;
        _popView.backgroundColor = kWhiteColor;
        [_popView addSubview:self.titleLab];
        [_popView addSubview:self.textBcView];
        [_popView addSubview:self.remainLab];
        [_popView addSubview:self.confirmBtn];
        [_popView addSubview:self.nameBtn];
    }
    return _popView;
}
-(UIView *)textBcView{
    if (!_textBcView) {
        _textBcView = [[UIView alloc]init];
        [_textBcView addSubview:self.nameLab];
        [_textBcView addSubview:self.identiLab];
        _textBcView.backgroundColor = kededColor;
    }
    return _textBcView;
}
-(UILabel *)titleLab{
    if (!_titleLab) {
        _titleLab = [[UILabel alloc]init];
        _titleLab.text = @"请核对个人信息";
        _titleLab.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLab;
}
-(UILabel *)nameLab{
    if (!_nameLab) {
        _nameLab = [[UILabel alloc]init];
        CGFloat fonts =  iPhone4s ||iPhone5s ? 13 : 15;
        _nameLab.font = Font(fonts);
        if (iPhoneX) {
            _nameLab.font = Font(14);
        }
    }
    return _nameLab;
}
-(UILabel *)identiLab{
    if (!_identiLab) {
        _identiLab = [[UILabel alloc]init];
        CGFloat fonts =  iPhone4s ||iPhone5s ? 13 : 15;
        _identiLab.font = Font(fonts);
        if (iPhoneX) {
            _identiLab.font = Font(14);
        }
    }
    return _identiLab;
}
-(UILabel *)remainLab{
    if (!_remainLab) {
        _remainLab = [[UILabel alloc]init];
        _remainLab.textAlignment = NSTextAlignmentCenter;
        _remainLab.text =  @"确认后无法修改,请务必核实正确";
        CGFloat fonts =  iPhone4s ||iPhone5s ? 13 : 15;
        _remainLab.font = Font(fonts);
        if (iPhoneX) {
            _remainLab.font = Font(14);
        }
        _remainLab.textColor = kea3Color;
    }
    return _remainLab;
}
-(UIButton *)confirmBtn{
    if (!_confirmBtn) {
        _confirmBtn = [[UIButton alloc]init];
        [_confirmBtn setTitle:@"正确无误" forState:UIControlStateNormal];
        [_confirmBtn setTitleColor:k518Color forState:UIControlStateNormal];
        
        CALayer *Border = [CALayer layer];
        float width=kWidth-80;
        Border.frame = CGRectMake(0, 0, width, 1);
        Border.backgroundColor = kF5F5F5Color.CGColor;
        [_confirmBtn.layer addSublayer:Border];
        [_confirmBtn addTarget:self action:@selector(confirmClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _confirmBtn;
}
-(void)confirmClick{
    if (self.confirmback) {
        self.confirmback();
    }
    [self removeFromSuperview];
    
}
+(void)confirmClick:(void (^)(void))back{
    [AlertView sharInstance].confirmback = back;
}
+(void)cancelClick:(void (^)(void))back{
    [AlertView sharInstance].cancelback = back;
}
-(UIButton *)nameBtn{
    if (!_nameBtn) {
        _nameBtn = [[UIButton alloc]init];
        [_nameBtn setTitle:@"信息有误,去修改" forState:UIControlStateNormal];
        [_nameBtn setTitleColor:k518Color forState:UIControlStateNormal];
        CALayer *Border = [CALayer layer];
        float width=kWidth-80;
        Border.frame = CGRectMake(0, 0, width, 1);
        Border.backgroundColor = kF5F5F5Color.CGColor;
        [_nameBtn.layer addSublayer:Border];
        [_nameBtn addTarget:self action:@selector(cancelClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _nameBtn;
}
-(void)cancelClick{
    
    if (self.cancelback) {
        self.cancelback();
    }
    [self removeFromSuperview];
    
}
@end
