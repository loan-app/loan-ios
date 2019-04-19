//
//  ForgetPwdViewController.m
//  RabbitConyYok
//
//  Created by Single_Nobel on 2018/7/7.
//  Copyright © 2018 Single_Nobel. All rights reserved.
//

#import "ForgetPwdViewController.h"
#import "RegisterView.h"
#import "ImgCodeAlert.h"
#import "JudgeViewController.h"
@interface ForgetPwdViewController ()<RegisterViewDelagate,YzmChangeBtnDelegate>
@property(strong,nonatomic)RegisterView *registerview;
@property(copy,nonatomic)NSString *phoneStr;
@property (nonatomic, strong) ImgCodeAlert * imgCodeView;
@property(copy,nonatomic)NSString *smsType;
@end

@implementation ForgetPwdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor =kWhiteColor;
    [self initUI];
 

    // Do any additional setup after loading the view.
}
-(void)initUI{
    [self.view addSubview:self.registerview];

}
-(void)setPhoneNum:(NSString *)phoneNum{
    _phoneStr = phoneNum;
}
-(RegisterView *)registerview{
    if (!_registerview) {
        _registerview = [[RegisterView alloc] initWithFrame:CGRectMake(0,kNavBarHeight, kWidth, kHeight - kNavBarHeight)];
        _registerview.delegate = self;
    }
    return _registerview;
}
-(void)setJudeStr:(NSString *)judeStr{
    _judeStr = judeStr;
    self.BaseNavgationBar.title = judeStr;
    if ([_judeStr isEqualToString:@"验证注册"]) {
        _smsType = ksms_type_Regist;
    }else {
        _smsType = ksms_type_ChangePassword;
    }
}
#pragma mark 实现代理协议
-(void)clickRegisterWithBtn:(UIButton *)sender{
    if ([_judeStr isEqualToString:@"验证注册"]) {
        [self RegisterClick:sender];
    }else{
        
        [self RewordPwdClick:sender];
    }
}
-(void)RegisterClick:(UIButton *)sender{
    sender.enabled = NO;
    kWeakSelf(self);
    if (isValidStr(_phoneStr) && isValidStr(self.registerview.verifyTextfiled.text) && isValidStr(self.registerview.pwdTextfiled.text)) {
        [[NetworkUtils sharedInstance] registerPhoneWithNetwork:_phoneStr password:self.registerview.pwdTextfiled.text phone_code:self.registerview.verifyTextfiled.text utilsSuccess:^(id response) {
            if ([BaseTool responseWithNetworkDealResponse:response]) {
                //注册成功
                [weakself login];
            }else {
                [MBProgressHUD bnt_showMessage:response[kMessageStr] delay:kMubDelayTime];
            }
            sender.enabled = YES;
        } utilsFail:^(NSString *error) {
        }];
    }else if (!isValidStr(self.registerview.verifyTextfiled.text)) {
        [MBProgressHUD bnt_showMessage:@"亲，验证码不能为空" delay:kMubDelayTime];
        sender.enabled = YES;
    }else if (!isValidStr(self.registerview.pwdTextfiled.text)) {
        [MBProgressHUD bnt_showMessage:@"亲，密码不能为空" delay:kMubDelayTime];
        sender.enabled = YES;
    }else {
        sender.enabled = YES;
    }
}
-(void)login{
    kWeakSelf(self);
    [[NetworkUtils sharedInstance]loginInWithNetwork:_phoneStr passwrod:self.registerview.pwdTextfiled.text utilsSuccess:^(id response) {
        if ([BaseTool responseWithNetworkDealResponse:response]) {
            if ([BaseTool responseWithNetworkDealResponse:response]) {
                [MBProgressHUD bnt_showMessage:@"登录成功" delay:kMubDelayTime];
                if (isValidStr(response[@"data"][@"token"])) {
                    [BaseTool saveToken:response[@"data"][@"token"]];
                }
                if (isValidStr(response[@"data"][@"uid"])) {
                    [BaseTool saveUserId:response[@"data"][@"uid"]];
                }
                //记录设备相关信息
                [self rewordLoginMessage];
                //保存登录的mobile
                [BaseTool saveUserMobile:weakself.phoneStr];
                [self.navigationController popToRootViewControllerAnimated:YES];
            }
        }else {
            [MBProgressHUD bnt_showMessage:response[kMessageStr] delay:kMubDelayTime];
        }
    } utilsFail:^(NSString *error) {
        
    }];
}
- (void)rewordLoginMessage {
    [[NetworkUtils sharedInstance] recordLoginInWithUtilsSuccess:^(id response) {
        
    } utilsFail:^(NSString *error) {
        
    }];
}
-(void)RewordPwdClick:(UIButton *)sender{
    kWeakSelf(self);
    sender.enabled = NO;
    if (isValidStr(_phoneStr) && isValidStr(self.registerview.verifyTextfiled.text) && isValidStr(self.registerview.pwdTextfiled.text)) {
        [[NetworkUtils sharedInstance] findUserPasswordNetwork:_phoneStr password:self.registerview.pwdTextfiled.text phone_code:self.registerview.verifyTextfiled.text utilsSuccess:^(id response) {
            if ([BaseTool responseWithNetworkDealResponse:response]) {
                //找回成功
                [weakself  login];
            }else {
                [MBProgressHUD bnt_showMessage:response[kMessageStr] delay:kMubDelayTime];
            }
            sender.enabled = YES;
        } utilsFail:^(NSString *error) {
            sender.enabled = YES;
        }];
    }else if (!isValidStr(self.registerview.verifyTextfiled.text)) {
        [MBProgressHUD bnt_showMessage:@"亲，验证码不能为空" delay:kMubDelayTime];
        sender.enabled = YES;
    }else if (!isValidStr(self.registerview.pwdTextfiled.text)) {
        [MBProgressHUD bnt_showMessage:@"亲，密码不能为空" delay:kMubDelayTime];
        sender.enabled = YES;
    }else {
        sender.enabled = YES;
    }
    
}
-(void)clickVerifytWithBtn:(UIButton *)sender{
    [self rewordYzmImgAlert:sender];
    
}

#pragma mark -  获取图形验证码

- (void)rewordYzmImgAlert:(UIButton *)sender {
    sender.enabled = NO;
    kWeakSelf(self);
    [[NetworkUtils sharedInstance] rewordImgCodeWithNetwork:_phoneStr utilsSuccess:^(id response) {
        UIImage *imageYzm=[[UIImage alloc] initWithData:response];
        [weakself yanZhengMaResponse:imageYzm];
    } utilsFail:^(NSString *error) {
        
    }];
    sender.enabled = YES;
}
- (void)yanZhengMaResponse:(UIImage *)yzmImg {
    kWeakSelf(self);
    self.imgCodeView = [[ImgCodeAlert alloc] initWithTitle:@"请输入图形验证码" sureBtn:@"确定" btnClickBlock:^(NSString *str) {
        if (isValidStr(str)) {
            //发送验证码
            [weakself sendMessageWithReturn:str];
        }else {
            
        }
    }];
    [_imgCodeView.yzmTextField becomeFirstResponder];
    [_imgCodeView setImgButton:yzmImg];
    [_imgCodeView show];
    self.imgCodeView.delegate = self;
}

- (void)sendMessageWithReturn:(NSString *)verCode {
    kWeakSelf(self);
    [[NetworkUtils sharedInstance] sendMessageWithNetwork:_phoneStr graph_code:verCode sms_type:_smsType utilsSuccess:^(id response) {
        if ([BaseTool responseWithNetworkDealResponse:response]) {
            [weakself.imgCodeView cancelBtnPressed];
            [weakself.imgCodeView hiddenKeyboard];
            [BaseTool countDownTimer:self.registerview.verifyBtn];//开启倒计时
        }else {
            [MBProgressHUD bnt_showMessage:response[kMessageStr] delay:kMubDelayTime];
            [weakself imgYzmWithRecoresAgain];
        }
    } utilsFail:^(NSString *error) {
        
    }];
}
#pragma mark - 换图形验证码

- (void)changeYanZhengMaWithButton:(UIButton *)sender {
    sender.enabled = NO;
    [self imgYzmWithRecoresAgain];
    sender.enabled = YES;
}

- (void)imgYzmWithRecoresAgain {
    kWeakSelf(self);
    [[NetworkUtils sharedInstance] rewordImgCodeWithNetwork:_phoneStr utilsSuccess:^(id response) {
        UIImage *imageYzm=[[UIImage alloc] initWithData:response];
        [weakself.imgCodeView setImgButton:imageYzm];
    } utilsFail:^(NSString *error) {
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
