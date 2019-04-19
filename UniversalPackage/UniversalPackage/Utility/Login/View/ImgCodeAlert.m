//
//  ImgCodeAlert.m
//  RabbitConyYok
//
//  Created by Single_Nobel on 2018/6/4.
//  Copyright © 2018年 Single_Nobel. All rights reserved.
//

#import "ImgCodeAlert.h"

@interface ImgCodeAlert ()
@property (nonatomic, strong) UIView      * alertView;
@property (nonatomic, strong) UILabel     * yzmErrorLabel;
@property (nonatomic, strong) UILabel     * titleLabel;
@property (nonatomic, strong) UIButton    * closeBtn;
@property (nonatomic, strong) UIButton    * sureBtn;
@property (nonatomic, strong) UILabel     * lineLabel;
@property (nonatomic, copy) btnClickBlock btnClickBlock;
@end

@implementation ImgCodeAlert

- (id)initWithTitle:(NSString *)titleStr sureBtn:(NSString *)sureBtn btnClickBlock:(btnClickBlock)btnClickIndex {
    if (self = [super init]) {
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:.6];
        [self initUI];
        [self configureWithUI];
        self.yzmErrorLabel.hidden = YES;
        self.titleLabel.text = titleStr;
        self.btnClickBlock = [btnClickIndex copy];
    }
    return self;
}

- (void)initUI {
    [self addSubview:self.alertView];
    [self.alertView addSubview:self.titleLabel];
    [self.alertView addSubview:self.closeBtn];
    [self.alertView addSubview:self.yzmErrorLabel];
    [self.alertView addSubview:self.sureBtn];
    [self.alertView addSubview:self.yzmImg];
    [self.alertView addSubview:self.lineLabel];
    [self.alertView addSubview:self.yzmTextField];
}

- (void)configureWithUI {
    self.alertView.frame = CGRectMake(BntLength(53), BntAltitude(207), kWidth-BntLength(53)*2, BntAltitude(191));
    
    [self.closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.alertView).offset(BntLength(-6));
        make.top.equalTo(self.alertView).offset(BntAltitude(6));
        make.width.offset(BntLength(20));
        make.height.offset(BntAltitude(20));
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.alertView).offset(BntLength(0));
        make.right.equalTo(self.alertView).offset(BntLength(0));
        make.top.equalTo(self.alertView).offset(BntAltitude(20));
        make.height.mas_offset(BntAltitude(16));
    }];
    
    [self.yzmImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.alertView).offset(BntLength(20));
        make.top.equalTo(self.titleLabel.mas_bottom).offset(BntAltitude(21));
        make.width.offset(BntLength(120));
        make.height.offset(BntAltitude(48));
    }];
    [self.lineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.yzmImg.mas_right).offset(BntLength(10));
        make.right.equalTo(self.alertView).offset(BntLength(-20));
        make.top.equalTo(self.titleLabel.mas_bottom).offset(BntAltitude(68));
        make.height.offset(BntAltitude(1));
    }];
    [self.yzmTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.yzmImg.mas_right).offset(BntLength(10));
        make.top.equalTo(self.titleLabel.mas_bottom).offset(BntAltitude(40));
        make.height.offset(BntAltitude(29));
        make.width.offset(BntLength(100));
    }];
    
    [self.yzmErrorLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.alertView).offset(BntLength(20));
        make.top.equalTo(self.yzmImg.mas_bottom).offset(BntAltitude(6));
        make.height.offset(BntAltitude(14));
    }];
    
    [self.sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.alertView).offset(BntLength(30));
        make.right.equalTo(self.alertView).offset(BntLength(-30));
        make.top.equalTo(self.yzmImg.mas_bottom).offset(BntAltitude(22));
        make.height.offset(BntAltitude(44));
    }];
}


- (UIView *)alertView{
    if (!_alertView) {
        _alertView = [[UIView alloc] init];
        _alertView.layer.cornerRadius = 8;
        _alertView.layer.masksToBounds = YES;
        _alertView.backgroundColor = kWhiteColor;
    }
    return _alertView;
}


- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [UILabel configWithFont:Font(kFont) TextColor:kblackColor background:nil title:@"请输入图形验证码"];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        [_titleLabel sizeToFit];
    }
    return _titleLabel;
}

- (UILabel *)yzmErrorLabel {
    if (!_yzmErrorLabel) {
        _yzmErrorLabel = [UILabel configWithFont:Font(kFont) TextColor:kredError background:nil title:@"图形验证码错误或已过期"];
        [_yzmErrorLabel sizeToFit];
    }
    return _yzmErrorLabel;
}


- (UIButton *)yzmImg {
    if (!_yzmImg) {
        _yzmImg = [[UIButton alloc] init];
        [_yzmImg addTarget:self action:@selector(changeTheImgWithClick:) forControlEvents:UIControlEventTouchUpInside];
//        _yzmImg.backgroundColor = ksixsixColor;
    }
    return _yzmImg;
}

- (UILabel *)lineLabel {
    if (!_lineLabel) {
        _lineLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _lineLabel.backgroundColor = kLineColor;
        [_lineLabel sizeToFit];
    }
    return _lineLabel;
}

- (UIButton *)closeBtn {
    if (!_closeBtn) {
        _closeBtn = [[UIButton alloc] init];
//        [_closeBtn setImage:kImageName(@"closeButton") forState:UIControlStateNormal];
        [_closeBtn addTarget:self action:@selector(closeGuanBiAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _closeBtn;
}


- (UITextField *)yzmTextField {
    if (!_yzmTextField) {
        _yzmTextField = [[UITextField alloc] initWithFrame:CGRectZero];
        _yzmTextField.placeholder = @"请输入验证码";
        _yzmTextField.font = Font(kFont);
    }
    return _yzmTextField;
}

- (UIButton *)sureBtn {
    if (!_sureBtn) {
        _sureBtn = [UIButton configureOnNormalFont:Font(kFont) titleColor:kblackColor backGround:k595Color title:@"确定" cornerRadius:BntLength(22) borderWith:1.0 borderColor:kWhiteColor.CGColor];
        [_sureBtn setTitleColor:kWhiteColor forState:UIControlStateNormal];
        [_sureBtn addTarget:self action:@selector(BtnPressed:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _sureBtn;
}


#pragma mark - Action

- (void)show{
    self.frame = CGRectMake(0, 0, kWidth, kHeight);
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    self.alertView.alpha = 0.0;
    [UIView animateWithDuration:0.4 animations:^{
        self.alertView.alpha = 1.0;
    } completion:^(BOOL finished) {
        
    }];
}

//hidden

- (void)closeGuanBiAction:(UIButton *)sender {
    sender.enabled = NO;
    [self cancelBtnPressed];
    sender.enabled = YES;
}

- (void)cancelBtnPressed {
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}


- (void)BtnPressed:(UIButton *)sender{
    if (!isValidStr(self.yzmTextField.text)) {
        [MBProgressHUD bnt_showMessage:@"验证码不能为空" delay:kMubDelayTime];
    }else {
        if (self.btnClickBlock) {
            self.btnClickBlock(self.yzmTextField.text);
        }
    }
}

- (void)hiddenKeyboard{
    if ([self.yzmTextField becomeFirstResponder]) {
        [self.yzmTextField resignFirstResponder];
    }else{
        
    }
}

- (void)setImgButton:(UIImage *)img {
    [_yzmImg setImage:img forState:UIControlStateNormal];
    [_yzmImg setImage:img forState:UIControlStateHighlighted];
}



- (void)changeTheImgWithClick:(UIButton *)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(changeYanZhengMaWithButton:)]) {
        [self.delegate changeYanZhengMaWithButton:sender];
    }
}


- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(gogo:) name:@"keyboardAlertUp" object:nil];
    }
    return self;
}

- (void)gogo:(NSNotification *)sender{
    NSDictionary *dict = sender.userInfo;
    NSString *str = [dict objectForKey:@"keyboard"];
    if ([str isEqualToString:@"show"]) {
        self.alertView.frame = CGRectMake(BntLength(53), BntAltitude(207), kWidth - BntLength(53)*2, BntAltitude(191));
    }else if ([str isEqualToString:@"hidden"]){
        self.alertView.frame = CGRectMake(BntLength(53), BntAltitude(207), kWidth - BntLength(53)*2, BntAltitude(191));
    }
}


@end
