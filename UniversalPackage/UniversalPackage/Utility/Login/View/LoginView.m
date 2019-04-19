//
//  LoginView.m
//  RabbitConyYok
//
//  Created by Single_Nobel on 2018/7/7.
//  Copyright © 2018 Single_Nobel. All rights reserved.
//

#import "LoginView.h"

@implementation LoginView
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self initUI:frame];
    }
    return self;
}
-(void)initUI:(CGRect)frame{
    
    _logoImageView = [[UIImageView alloc]initWithFrame:CGRectMake((kWidth-70)/2, 80, 70, 70)];
    _logoImageView.image = kImageName(@"avatar");
    _phonelabel = [UILabel initFrame:CGRectMake(38, CGRectGetMaxY(self.logoImageView.frame)+20, kWidth-76, 21) Aligent:NSTextAlignmentCenter Font:21 Text:@"18112345678" Color:fontColor];
    _phonelabel.textAlignment = NSTextAlignmentCenter;
    _phoneTextfiled = [[UITextField alloc]initWithFrame:CGRectMake((kWidth-210)/2, CGRectGetMaxY(_phonelabel.frame)+43, 210, 30)];
    _phoneTextfiled.secureTextEntry = true;
    _phoneTextfiled.clearButtonMode = UITextFieldViewModeWhileEditing;
    [_phoneTextfiled addTarget:self action:@selector(textChanged:) forControlEvents:UIControlEventEditingChanged];
    _phoneTextfiled.placeholder = @"请输入密码";
    _phoneTextfiled.font = Font(14);
    _phoneTextfiled.textColor = fontColor;
    
    _lineView = [[UIView alloc]initWithFrame:CGRectMake((kWidth-210)/2, CGRectGetMaxY(_phoneTextfiled.frame), 210, 1)];
    _lineView.backgroundColor = kCBCBCColor;
    _loginBtn = [[UIButton alloc]initWithFrame:CGRectMake((kWidth-210)/2 , CGRectGetMaxY(_lineView.frame)+37, 210, 44)];
    _loginBtn.layer.cornerRadius = 22;
    _loginBtn.titleLabel.font = Font(15);
    [_loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    [_loginBtn setTitleColor:kWhiteColor forState:UIControlStateNormal];
    [_loginBtn addTarget:self action:@selector(netxWithLogin:) forControlEvents:UIControlEventTouchUpInside];
    _loginBtn.backgroundColor = kCBCBCColor;
    _forgetPwdBtn = [[UIButton alloc]initWithFrame:CGRectMake(kWidth-120, CGRectGetMaxY(_loginBtn.frame)+24, 82, 12)];
    [_forgetPwdBtn setTitle:@"忘记密码?" forState:UIControlStateNormal];
    _forgetPwdBtn.titleLabel.font =Font(12);
    [_forgetPwdBtn setTitleColor:fontColor forState:UIControlStateNormal];
    [_forgetPwdBtn addTarget:self action:@selector(ForgetPwd:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_forgetPwdBtn];
    [self addSubview:_logoImageView];
    [self addSubview:_phonelabel];
    [self addSubview:_phoneTextfiled];
    [self addSubview:_pwdLabel];
    [self addSubview:_lineView];
    [self addSubview:_loginBtn];
}
-(void)textChanged:(UITextField *)textfield{
    UIColor *Color;
    Color = textfield.text.length == 0 ? kCBCBCColor :  k595Color ;
    _loginBtn.backgroundColor = Color;
}
-(void)netxWithLogin:(UIButton *)sender{
    if (self.delegate && [self.delegate respondsToSelector:@selector(clickLoginWithBtn:)]) {
        [self.delegate clickLoginWithBtn:sender];
    }
}

-(void)ForgetPwd:(UIButton *)sender{
    if (self.delegate && [self.delegate respondsToSelector:@selector(clickForgetWithBtn:)]) {
        [self.delegate clickForgetWithBtn:sender];
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
