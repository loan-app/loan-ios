//
//  RegisterView.m
//  RabbitConyYok
//
//  Created by Single_Nobel on 2018/7/7.
//  Copyright © 2018 Single_Nobel. All rights reserved.
//

#import "RegisterView.h"

@implementation RegisterView
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self initUI];
    }
    return self;
}
-(void)initUI{
    _verifyTextfiled = [[UITextField alloc]initWithFrame:CGRectMake((kWidth-210)/2, 62, 110, 30)];
    _verifyTextfiled.placeholder = @"请输入验证码";
    _verifyTextfiled.font = [UIFont systemFontOfSize:kFont];
    _verifyTextfiled.textColor = btnborderColor;
    _verifyBtn =[[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_verifyTextfiled.frame), 59, 100, 36)];
    [_verifyBtn setTitleColor:kWhiteColor forState:UIControlStateNormal];
    _verifyBtn.backgroundColor =k595Color;
    _verifyBtn.layer.cornerRadius = 5;
    [_verifyBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    [_verifyBtn addTarget:self action:@selector(getVerifyClick:) forControlEvents:UIControlEventTouchUpInside];
    _verifyBtn.titleLabel.font = Font(14);
    _firstLine = [[UIView alloc]initWithFrame:CGRectMake((kWidth-210)/2, CGRectGetMaxY(_verifyTextfiled.frame)+8, 110, 1)];
    _firstLine.backgroundColor = kCBCBCColor;

    _pwdTextfiled = [[UITextField alloc]initWithFrame:CGRectMake((kWidth-210)/2, CGRectGetMaxY(_firstLine.frame)+35, 210, 30)];
    _pwdTextfiled.placeholder = @"请设置6~12位登录密码";
    _pwdTextfiled.font = [UIFont systemFontOfSize:kFont];
    _pwdTextfiled.textColor = btnborderColor;
    _pwdTextfiled.secureTextEntry = YES;
    _pwdTextfiled.clearButtonMode = UITextFieldViewModeWhileEditing;
    [_pwdTextfiled addTarget:self action:@selector(textChanged:) forControlEvents:UIControlEventEditingChanged];
    _secndLine = [[UIView alloc]initWithFrame:CGRectMake((kWidth-210)/2, CGRectGetMaxY(_pwdTextfiled.frame)+8, 210, 1)];
    _secndLine.backgroundColor = kCBCBCColor;
    
    _nextBtn = [[UIButton alloc]initWithFrame:CGRectMake((kWidth-210)/2, CGRectGetMaxY(_secndLine.frame)+101, 220, 44)];
    [_nextBtn setTitle:@"下一步" forState:UIControlStateNormal];
    [_nextBtn setTitleColor:kWhiteColor forState:UIControlStateNormal];
    _nextBtn.backgroundColor = kCBCBCColor;
    _nextBtn.layer.cornerRadius = 22;
    [_nextBtn addTarget:self action:@selector(registerClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:_nextBtn];
    [self addSubview:_verifyTextfiled];
    [self addSubview:_verifyBtn];
    [self addSubview:_firstLine];
    [self addSubview:_pwdTextfiled];
    [self addSubview:_secndLine];
}


-(void)textChanged:(UITextField *)textfield{
    UIColor *Color;
    Color = textfield.text.length == 0 ? kCBCBCColor :  k595Color ;
    _nextBtn.backgroundColor = Color;
}
-(void)getVerifyClick:(UIButton *)sender{
    if (self.delegate && [self.delegate respondsToSelector:@selector(clickVerifytWithBtn:)]) {
        [self.delegate clickVerifytWithBtn:sender];
    }
}
-(void)registerClick:(UIButton *)sender{
    NSLog(@"你点击了");
    if (self.delegate && [self.delegate respondsToSelector:@selector(clickRegisterWithBtn:)]) {
        [self.delegate clickRegisterWithBtn:sender];
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
