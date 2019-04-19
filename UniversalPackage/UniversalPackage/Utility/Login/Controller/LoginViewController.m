//
//  LoginViewController.m
//  RabbitConyYok
//
//  Created by Single_Nobel on 2018/7/7.
//  Copyright © 2018 Single_Nobel. All rights reserved.
//

#import "LoginViewController.h"
#import "JudgeViewController.h"
#import "ForgetPwdViewController.h"
@interface LoginViewController ()
@property(strong,nonatomic)UIView *bcView;
@property(strong,nonatomic)UITextField *phoneTextfiled;
@property(strong,nonatomic)UIButton *nextBtn;
@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.BaseNavgationBar.backgroundColor = kWhiteColor;
    [self setupUI];
    [self setupContrans];
}

-(void)viewDidAppear:(BOOL)animated{
    _nextBtn.enabled = NO;
}
- (void)setupUI {
    self.view.backgroundColor = kWhiteColor;
    [self.view addSubview:self.bcView];
    [BaseTool drawLine:CGPointMake(0, 32) End:CGPointMake(kWidth-150, 32) Toview:self.bcView];
}
-(void)setupContrans{
    [self.bcView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(kNavBarHeight+100);
        make.width.mas_equalTo(kWidth-150);
        make.height.mas_equalTo(150);
        make.centerX.equalTo(self.view.mas_centerX);
    }];
    [self.phoneTextfiled mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.mas_equalTo(0);
        make.height.mas_equalTo(30);
        make.width.equalTo(self.bcView.mas_width);
    }];

    
    [self.nextBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.phoneTextfiled.mas_bottom).offset(60);
        make.left.mas_equalTo(0);
        make.width.equalTo(self.bcView.mas_width);
        make.height.mas_equalTo(44);
        self->_nextBtn.layer.cornerRadius = 22;
    }];
}
-(UIView *)bcView{
    if (!_bcView) {
        _bcView = [[UIView alloc]init];
        [_bcView addSubview:self.phoneTextfiled];
        [_bcView addSubview:self.nextBtn];
    }
    return _bcView;
}
-(UITextField *)phoneTextfiled{
    if (!_phoneTextfiled) {
        _phoneTextfiled = [[UITextField alloc]init];
        _phoneTextfiled.placeholder = @"请输入手机号";
  [_phoneTextfiled addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
        
    }
    return _phoneTextfiled;
}
-(UIButton *)nextBtn{
    if (!_nextBtn) {
        _nextBtn = [[UIButton alloc]init];
        _nextBtn.backgroundColor = kCBCBCColor;
        [_nextBtn setTitle:@"下一步" forState:UIControlStateNormal];
        [_nextBtn addTarget:self action:@selector(netxWithLogin:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _nextBtn;
}
-(void)textFieldDidChange :(UITextField *)theTextField{
    UIColor *Color;
   Color = theTextField.text.length == 0 ? kCBCBCColor :  k595Color ;
    _nextBtn.backgroundColor = Color;
    _nextBtn.enabled = YES;
}
-(void)PopToparent{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)netxWithLogin:(UIButton *)sender{
    kWeakSelf(self);
    sender.enabled = NO;
    [_phoneTextfiled resignFirstResponder];
    NSString * phoneNum = [BaseTool dealWithPhoneNumber:_phoneTextfiled.text];
    BOOL isPhoneNumber = [BaseTool isMobileNumber:phoneNum];
    if (!isPhoneNumber) {
        [MBProgressHUD bnt_showMessage:@"手机号码格式不正确" delay:kMubDelayTime];
        sender.enabled = YES;
        return;
    }else{
        [MBProgressHUD bnt_indeterminateWithMessage:@"" toView:self.view];
    [[NetworkUtils sharedInstance] phoneExistWithNetwork:_phoneTextfiled.text utilsSuccess:^(id response) {
        [MBProgressHUD hideHUDView:self.view];
        sender.enabled = YES;
        if ([BaseTool responseWithNetworkDealResponse:response]) {
            [weakself skipWithRegistVC:phoneNum];
        }else if ([response[@"status"] isEqualToString:@"2001"]) {
            [weakself skipWithLoginVC:phoneNum ];
        }
    } utilsFail:^(NSString *error) {
        [MBProgressHUD hideHUDView:self.view];
        sender.enabled = YES;
    }];
    }
}
- (void)skipWithRegistVC:(NSString *)phone {
    ForgetPwdViewController *forgetVC = [[ForgetPwdViewController alloc]init];
    if (isValidStr(phone)) {
        forgetVC.phoneNum= phone;
        forgetVC.judeStr = @"验证注册";
    }
  [self.navigationController pushViewController:forgetVC animated:YES];
}
//登录页面
- (void)skipWithLoginVC:(NSString *)phone {
        JudgeViewController *judVC = [[JudgeViewController alloc]init];
           judVC.phoneNumber = phone;
        [self.navigationController pushViewController:judVC animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
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
