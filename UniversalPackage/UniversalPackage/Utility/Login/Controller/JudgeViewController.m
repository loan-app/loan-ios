//
//  JudgeViewController.m
//  RabbitConyYok
//
//  Created by Single_Nobel on 2018/7/7.
//  Copyright © 2018 Single_Nobel. All rights reserved.
//

#import "JudgeViewController.h"
#import "LoginView.h"
#import "RegisterView.h"
#import "ForgetPwdViewController.h"
@interface JudgeViewController ()<LoginViewDelagate>
@property(copy,nonatomic)NSString *jumpStr;
@property(copy,nonatomic)NSString *Str;

@property(strong,nonatomic)LoginView *loginView;
@property(strong,nonatomic)RegisterView *regisView;
@property(copy,nonatomic)NSString *phonenumStr;
@end

@implementation JudgeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kWhiteColor;
    [self initUI];
    // Do any additional setup after loading the view.
}


-(void)initUI{

    [self.view addSubview:self.loginView];
   
    

}
-(void)setPhoneNumber:(NSString *)phoneNumber{
    _phonenumStr = phoneNumber;
}
-(LoginView *)loginView{
    if (!_loginView) {
        _loginView = [[LoginView alloc] initWithFrame:CGRectMake(0,kNavBarHeight, kWidth, kHeight - kNavBarHeight)];
        _loginView.phonelabel.text = _phonenumStr;
        _loginView.delegate = self;
    }
    return _loginView;
}

#pragma mark login delegate
-(void)clickForgetWithBtn:(UIButton *)sender{
    ForgetPwdViewController *forgetVC = [[ForgetPwdViewController alloc]init];
    forgetVC.judeStr = @"忘记密码";
    forgetVC.phoneNum = _phonenumStr;
    [self.navigationController pushViewController:forgetVC animated:YES];
}
-(void)clickLoginWithBtn:(UIButton *)sender{
    sender.enabled = NO;
  kWeakSelf(self);
    [MBProgressHUD bnt_indeterminateWithMessage:@"登录中,请稍候" toView:self.view];
    [[NetworkUtils sharedInstance]loginInWithNetwork:_phonenumStr passwrod:_loginView.phoneTextfiled.text utilsSuccess:^(id response) {
        sender.enabled = YES;
        [MBProgressHUD hideHUDView:self.view];
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
            [BaseTool saveUserMobile:weakself.phonenumStr];
            //拿到栈里控制器的层数;
            NSString *newstr = [[NSUserDefaults standardUserDefaults]objectForKey:@"judgeKey"];
            if ([newstr isEqualToString:@"h5"]) {
                NSInteger VCcount = self.navigationController.viewControllers.count;
                //控制器往前退两层,回到点击登录的页面;
                if (VCcount<=3) {
                    UIViewController *VCtrol = self.navigationController.viewControllers[VCcount-3];
                    [weakself.navigationController popToViewController:VCtrol animated:YES];
                }else{
                    [weakself.navigationController popToRootViewControllerAnimated:YES];
                }
            }else{
                [weakself.navigationController popToRootViewControllerAnimated:YES];
            }
            
        }else{
            [MBProgressHUD bnt_showMessage:response[@"message"]];

        }
    } utilsFail:^(NSString *error) {
        [MBProgressHUD bnt_showMessage:error];
        sender.enabled = YES;

    }];
    
}
- (void)rewordLoginMessage {
    [[NetworkUtils sharedInstance] recordLoginInWithUtilsSuccess:^(id response) {
        
    } utilsFail:^(NSString *error) {
        
    }];
}
-(void)Pop{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.loginView.phoneTextfiled resignFirstResponder];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)dealloc{
    [[NSUserDefaults standardUserDefaults]setObject:@"" forKey:@"judgeKey"];
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
